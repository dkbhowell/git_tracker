//
//  GitHubClient.swift
//  GitTracker
//
//  Created by Dustin Howell on 8/6/18.
//  Copyright © 2018 Dustin Howell. All rights reserved.
//

import Foundation

class GitHubClient {
    typealias ReposAction = (RepositoriesResult) -> Void
    
    let session = URLSession.shared
    
    private enum Endpoint: String {
        case repoSearch = "/search/repositories"
        
        private var baseURL: String { return "https://api.github.com" }
        var full: String { return baseURL + self.rawValue }
    }
    
    enum RepositoriesResult {
        case success([Repository])
        case failure(NetworkingError)
    }
    
    func fetchRepositories(completion: @escaping ReposAction) {
        let endpoint = Endpoint.repoSearch
        var comps = URLComponents(string: endpoint.full)
        let queryItems = [
            URLQueryItem(name: "sort", value: "stars"),
            URLQueryItem(name: "order", value: "desc"),
            URLQueryItem(name: "q", value: "language:swift+pushed:>2018-07-19") //
        ]
        comps?.queryItems = queryItems
        guard let url = comps?.url else {
            completion( .failure(NetworkingError.badURL(description: "Bad URL")) )
            return
        }
        print("making reqeust to url: \(url)")
        var request = URLRequest(url: url)
        request.addValue("application/vnd.github.v3+json", forHTTPHeaderField: "Accept")
        session.dataTask(with: request) { (data0, resp0, err0) in
            if let err = err0 { print("Error: \(err.localizedDescription)") }
            guard let data = data0, let _ = resp0 else { return }
            guard
                let jsonObject = (try? JSONSerialization.jsonObject(with: data, options: [])) as? [String:Any],
                let items = jsonObject["items"] as? [[String:Any]]
            else {
                completion( .failure(NetworkingError.parseError(description: "Parse Error")) )
                return
            }
            let repos = items.compactMap { Repository(dict: $0) }
            print("Downloaded \(repos.count) repositories")
            completion(.success(repos))
        }.resume()
    }   
}

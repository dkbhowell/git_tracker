//
//  GitHubClient.swift
//  GitTracker
//
//  Created by Dustin Howell on 8/6/18.
//  Copyright © 2018 Dustin Howell. All rights reserved.
//

import Foundation

class GitHubClient {
    
    let session = URLSession.shared
    
    private enum Endpoint: String {
        case repoSearch = "/search/repositories"
        
        private var baseURL: String { return "https://api.github.com" }
        var full: String { return baseURL + self.rawValue }
    }
    
    func makeQuery() {
        let endpoint = Endpoint.repoSearch
        var comps = URLComponents(string: endpoint.full)
        let queryItems = [
            URLQueryItem(name: "sort", value: "stars"),
            URLQueryItem(name: "order", value: "desc"),
            URLQueryItem(name: "q", value: "language:swift+pushed:>2018-07-19") //
        ]
        comps?.queryItems = queryItems
        guard let url = comps?.url else { fatalError("Bad URL")}
        print("making reqeust to url: \(url)")
        var request = URLRequest(url: url)
        request.addValue("application/vnd.github.v3+json", forHTTPHeaderField: "Accept")
        session.dataTask(with: request) { (data0, resp0, err0) in
            if let err = err0 { print("Error: \(err.localizedDescription)") }
            guard let data = data0, let resp = resp0 else { return }
            let jsonObject = try! JSONSerialization.jsonObject(with: data, options: [])
            print("received Response")
            print(jsonObject)
        }.resume()
    }
    
    
}

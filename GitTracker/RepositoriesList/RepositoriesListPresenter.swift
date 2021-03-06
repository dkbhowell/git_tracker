//
//  RepositoriesListPresenter.swift
//  GitTracker
//
//  Created by Dustin Howell on 7/22/18.
//  Copyright © 2018 Dustin Howell. All rights reserved.
//

import Foundation

class RepositoriesListPresenter {
    
    var repositories: [Repository]
    unowned let view: RepositoriesListView
    let gitClient: GitHubClient
    let navigator: Navigator
    
    init(view: RepositoriesListView, gitClient: GitHubClient, navigator: Navigator) {
        self.gitClient = gitClient
        self.view = view
        self.navigator = navigator
        self.repositories = [
            Repository(name: "OneScore", description: "Making hard decicsions easy", stars: 55),
            Repository(name: "PupPack", description: "Connect to the World Wide Wag", stars: 154),
            Repository(name: "GitTracker", description: "Keep up with your projects", stars: 7534)
        ]
        view.showLoadingView()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            view.showRepositories(repositories: self.repositories)
        }
    }
    
    func refreshRepositories() {
        view.showLoadingView()
        gitClient.fetchRepositories { (repos) in
            switch repos {
            case .success(let repos):
                self.repositories = repos
                DispatchQueue.main.async {
                    self.view.showRepositories(repositories: repos)
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    self.view.showRepositories(repositories: self.repositories)
                }
                self.view.showAlert(withTitle: NetworkingError.genericTitle, message: error.localizedDescription)
            }
        }
    }
}

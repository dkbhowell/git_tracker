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
    let view: RepositoriesListView
    
    init(view: RepositoriesListView) {
        self.view = view
        self.repositories = [
            Repository(name: "OneScore", description: "Making hard decicsions easy"),
            Repository(name: "PupPack", description: "Connect to the World Wide Wag"),
            Repository(name: "GitTracker", description: "Keep up with your projects")
        ]
        view.showRepositories(repositories: repositories)
    }
    
}

extension RepositoriesListPresenter {
    func genDummyData() -> [Repository] {
        return [
            Repository(name: "OneScore", description: "Making hard decicsions easy"),
            Repository(name: "PupPack", description: "Connect to the World Wide Wag"),
            Repository(name: "GitTracker", description: "Keep up with your projects")
        ]
    }
}
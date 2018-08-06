//
//  Navigator.swift
//  GitTracker
//
//  Created by Dustin Howell on 8/6/18.
//  Copyright © 2018 Dustin Howell. All rights reserved.
//

import UIKit

class Navigator {
    
    func createRepositoryListView(withNav nav: UINavigationController? = nil) -> RepositoriesListView {
        let repoList = RepositoriesListTableViewController(nibName: "RepositoriesListTableViewController", bundle: nil)
        nav?.viewControllers = [repoList]
        return repoList
    }
    
    func createRepositoryDetailView(forRepository repo: Repository) -> RepositoryDetailView {
        return RepositoryViewController(repository: repo)
    }
    
    
}

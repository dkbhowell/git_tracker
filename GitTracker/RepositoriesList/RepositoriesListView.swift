//
//  RepositoriesListView.swift
//  GitTracker
//
//  Created by Dustin Howell on 7/22/18.
//  Copyright © 2018 Dustin Howell. All rights reserved.
//

import Foundation

protocol RepositoriesListView: class {
    func showRepositories(repositories: [Repository])
}

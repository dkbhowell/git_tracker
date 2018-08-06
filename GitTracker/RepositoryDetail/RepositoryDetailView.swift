//
//  RepositoryDetailView.swift
//  GitTracker
//
//  Created by Dustin Howell on 8/6/18.
//  Copyright © 2018 Dustin Howell. All rights reserved.
//

import Foundation

protocol RepositoryDetailView {
    func showDetails(forRepository: Repository)
}

//
//  Repository.swift
//  GitTracker
//
//  Created by Dustin Howell on 7/22/18.
//  Copyright © 2018 Dustin Howell. All rights reserved.
//

import Foundation

struct Repository {
    var name: String
    var description: String
    var stars: Int
}

extension Repository {
    init?(dict: [String:Any]) {
        guard
            let name = dict["name"] as? String,
            let desc = dict["description"] as? String,
            let stars = dict["stargazers_count"] as? Int
        else { return nil }
        
        self.init(name: name, description: desc, stars: stars)
    }
}

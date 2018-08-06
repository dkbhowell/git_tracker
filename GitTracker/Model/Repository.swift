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
}

extension Repository {
    init?(dict: [String:Any]) {
        guard
            let name = dict["name"] as? String,
            let desc = dict["description"] as? String
        else { return nil }
        
        self.init(name: name, description: desc)
    }
}

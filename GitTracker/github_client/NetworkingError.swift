//
//  NetworkingError.swift
//  GitTracker
//
//  Created by Dustin Howell on 8/6/18.
//  Copyright © 2018 Dustin Howell. All rights reserved.
//

import Foundation

enum NetworkingError: Error {
    static let genericTitle = "Networking Error"
    case badURL(description: String)
    case parseError(description: String)
}

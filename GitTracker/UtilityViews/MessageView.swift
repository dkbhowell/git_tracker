//
//  MessageView.swift
//  GitTracker
//
//  Created by Dustin Howell on 7/22/18.
//  Copyright © 2018 Dustin Howell. All rights reserved.
//

import UIKit

class MessageView: UIView {
    
    @IBOutlet weak var messageLabel: UILabel!
    
    static func create() -> MessageView {
        let bundle = Bundle(for: RepositoriesListTableViewController.self)
        let firstItem = bundle.loadNibNamed("MessageView", owner: nil, options: nil)?.first
        return firstItem as! MessageView
    }
    
    var message: String = "Message Text" {
        didSet {
            messageLabel.text = message
        }
    }
}

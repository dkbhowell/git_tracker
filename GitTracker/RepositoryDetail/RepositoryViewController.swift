//
//  RepositoryViewController.swift
//  GitTracker
//
//  Created by Dustin Howell on 8/6/18.
//  Copyright © 2018 Dustin Howell. All rights reserved.
//

import UIKit

class RepositoryViewController: UIViewController {
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var starCountLabel: UILabel!
    
    let repository: Repository
    
    init(repository: Repository) {
        self.repository = repository
        super.init(nibName: "RepositoryViewController", bundle: Bundle(for: RepositoryViewController.self))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        showDetails(forRepository: repository)
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension RepositoryViewController: RepositoryDetailView {
    func showDetails(forRepository repo: Repository) {
        nameLabel.text = repo.name
        descriptionLabel.text = repo.description
        starCountLabel.text = "\(repo.stars)"
    }
}

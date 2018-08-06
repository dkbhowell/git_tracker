//
//  RepositoriesListTableViewController.swift
//  GitTracker
//
//  Created by Dustin Howell on 7/22/18.
//  Copyright © 2018 Dustin Howell. All rights reserved.
//

import UIKit

class RepositoriesListTableViewController: UITableViewController {
    let detailCellReuseId = "detailCellReuseId"
    var repositories = [Repository]()
    var presenter: RepositoriesListPresenter!
    var overlay: UIView?
    
    // MARK: View State
    private enum State {
        case loading
        case empty
        case showingRepositories(repos: [Repository])
    }
    private var state: State = .empty {
        didSet {
            switch state {
            case .loading:
                let loadingView = LoadingView()
                showOverlay(overlay: loadingView)
            case .empty:
                showNoRepositoriesOverlay()
            case .showingRepositories(let repos):
                refreshTableView(repos: repos)
            }
        }
    }
        
    override func viewDidLoad() {
        super.viewDidLoad()
//         self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    // MARK: Overlay Functions
    private func showNoRepositoriesOverlay() {
        let messageView = MessageView.create()
        messageView.message = "No Repositories Found"
        showOverlay(overlay: messageView)
    }
    
    private func showOverlay(overlay: UIView) {
        overlay.translatesAutoresizingMaskIntoConstraints = false
        removeOverlay()
        view.addSubview(overlay)
        NSLayoutConstraint.activate([
            overlay.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            overlay.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            overlay.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            overlay.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
        view.bringSubview(toFront: overlay)
        tableView.separatorStyle = .none
        self.overlay = overlay
    }
    
    private func removeOverlay() {
        overlay?.removeFromSuperview()
        tableView.separatorStyle = .singleLine
        overlay = nil
    }

    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return repositories.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let reusedCell = tableView.dequeueReusableCell(withIdentifier: detailCellReuseId)
        let cell = reusedCell ?? UITableViewCell(style: .subtitle, reuseIdentifier: detailCellReuseId)
        let repository = repositories[indexPath.row]
        cell.textLabel?.text = repository.name
        cell.detailTextLabel?.text = repository.description
        return cell
    }
    
    private func refreshTableView(repos: [Repository]) {
        if repos.count > 0 {
            removeOverlay()
        } else {
            showNoRepositoriesOverlay()
        }
        tableView.beginUpdates()
        for i in 0..<self.repositories.count {
            print("DELETING: \(i)")
            let idx = IndexPath(row: i, section: 0)
            tableView.deleteRows(at: [idx], with: .automatic)
        }
        self.repositories = repos
        for i in 0..<self.repositories.count {
            let idx = IndexPath(row: i, section: 0)
            tableView.insertRows(at: [idx], with: .automatic)
        }
        tableView.endUpdates()
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
}

extension RepositoriesListTableViewController: RepositoriesListView {
    func showRepositories(repositories: [Repository]) {
        state = .showingRepositories(repos: repositories)
    }
    func showLoadingView() {
        state = .loading
    }
}

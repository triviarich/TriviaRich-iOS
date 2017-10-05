//
//  LobbiesViewController.swift
//  TriviaRich-iOS
//
//  Created by Matthew Rigdon on 9/20/17.
//  Copyright © 2017 com.rigdon. All rights reserved.
//

import UIKit

class LobbiesViewController: UITableViewController {
    
    private var lobbies = [Lobby]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let backButton = UIBarButtonItem()
        backButton.title = "Cancel"
        navigationItem.backBarButtonItem = backButton
        
        Backend.getLobbies { self.lobbies = $0 }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return lobbies.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "lobbyCell", for: indexPath)

        let lobby = lobbies[indexPath.row]
        cell.textLabel?.font = UIFont.triviarich(style: .medium)
        cell.textLabel?.text = "Play for \(lobby.priceString())"

        return cell
    }

    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "waitSegue" {
            let destination = segue.destination as! WaitingViewController
            destination.lobby = lobbies[tableView.indexPathForSelectedRow!.row]
        }
    }

}

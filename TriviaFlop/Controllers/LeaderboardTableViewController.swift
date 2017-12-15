//
//  LeaderboardTableViewController.swift
//  TriviaFlop
//
//  Created by Dennis Broekhuizen on 12-12-17.
//  Copyright © 2017 Dennis Broekhuizen. All rights reserved.
//
//  This file handles updating the leaderboard in realtime. Userscores are retrieved from firebase.

import UIKit
import FirebaseDatabase

class LeaderboardTableViewController: UITableViewController {
    
    // Declare array to load in all userscores.
    var items: [Userscore] = []
    
    // Refrence to leaderboard table in database.
    let ref = Database.database().reference(withPath: "leaderboard")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Retrieve userscores from database.
        ref.queryOrdered(byChild: "score").observe(.value, with: { snapshot in
            // Create array for new items in database.
            var newItems: [Userscore] = []
            
            for item in snapshot.children {
                // Declare and append elements from database to array
                let userscore = Userscore(snapshot: item as! DataSnapshot)
                newItems.append(userscore)
            }
            
            // Set new items to items array
            self.items = newItems
            self.tableView.reloadData()
        })
        
        tableView.allowsSelection = false
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Declare cell and items.
        let cell = tableView.dequeueReusableCell(withIdentifier: "ItemCell", for: indexPath) as! LeaderboardTableViewCell
        let leaderboardItem = items.reversed()[indexPath.row]
        
        // Set leaderboard items to cell elements.
        cell.numberLabel.text = String(indexPath.row+1)
        cell.nameLabel.text = leaderboardItem.username
        cell.scoreLabel.text = String(leaderboardItem.score)
        return cell
    }
    
}

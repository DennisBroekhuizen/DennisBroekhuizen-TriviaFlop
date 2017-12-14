//
//  LeaderboardTableViewController.swift
//  TriviaFlop
//
//  Created by Dennis Broekhuizen on 12-12-17.
//  Copyright © 2017 Dennis Broekhuizen. All rights reserved.
//

import UIKit
import FirebaseDatabase

class LeaderboardTableViewController: UITableViewController {
    
    // Declare array to load in all userscores.
    var items: [Userscore] = []
    
    // Refrence to leaderboard table in database.
    let ref = Database.database().reference(withPath: "leaderboard")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ref.queryOrdered(byChild: "score").observe(.value, with: { snapshot in
            var newItems: [Userscore] = []
            
            for item in snapshot.children {
                let userscore = Userscore(snapshot: item as! DataSnapshot)
                newItems.append(userscore)
            }
            
            self.items = newItems
            self.tableView.reloadData()
        })
        
        tableView.allowsSelection = false
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return items.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ItemCell", for: indexPath) as! LeaderboardTableViewCell
        
        let leaderboardItem = items.reversed()[indexPath.row]
        
        cell.numberLabel.text = String(indexPath.row+1)
        cell.nameLabel.text = leaderboardItem.username
        cell.scoreLabel.text = String(leaderboardItem.score)
        return cell
    }
    
}

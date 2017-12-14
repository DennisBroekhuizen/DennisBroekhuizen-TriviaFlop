//
//  ResultsViewController.swift
//  TriviaFlop
//
//  Created by Dennis Broekhuizen on 10-12-17.
//  Copyright © 2017 Dennis Broekhuizen. All rights reserved.
//

import UIKit
import FirebaseDatabase
import FirebaseAuth
import SwiftySound

class ResultsViewController: UIViewController {
    
    // Variables.
    var totalScore: Int!
    let user = Auth.auth().currentUser!
    let refLeaderboard = Database.database().reference().child("leaderboard")
    
    // Outlets.
    @IBOutlet weak var totalScoreLabel: UILabel!
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var highscoreLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Hide highscore label and back button.
        highscoreLabel.isHidden = true
        navigationItem.hidesBackButton = true
        
        // Show totalscore.
        totalScoreLabel.text = String(totalScore)
        
        // Play corresponding sounds to earned points.
        if totalScore == 0 {
            messageLabel.text = "Bad luck"
            Sound.play(file: "badluck.mp3")
        } else {
            Sound.play(file: "finish.mp3")
        }
        
        // Check for highscore and update to leaderboard if so.
        checkHighscore()
        updateLeaderboard()
    }
    
    // Check if current score is higher than database score.
    func checkHighscore() {
        guard let displayName = user.displayName else { return }
        
        // Retrieve database scores.
        refLeaderboard.child(displayName).observe(.childAdded, with: { (snapshot) in
            let databaseScore = snapshot.value as! Int
            
            // Show highscore label if highscore is beated and score isn't 0.
            if self.totalScore > databaseScore && self.totalScore != 0 {
                self.highscoreLabel.isHidden = false
            }
        })
        
    }
    
    // Updates users score if current score is higher than database score.
    // Constraints added to database rules.
    func updateLeaderboard(){
        guard let displayName = user.displayName else { return }
        let score = ["score": totalScore as Int]
        
        // Insert value into database.
        self.refLeaderboard.child(displayName).setValue(score)
    }

}

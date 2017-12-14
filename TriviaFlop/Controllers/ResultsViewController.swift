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
    
    var totalScore: Int!
    let user = Auth.auth().currentUser!
    let refLeaderboard = Database.database().reference().child("leaderboard")
    
    @IBOutlet weak var totalScoreLabel: UILabel!
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var highscoreLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        highscoreLabel.isHidden = true
        navigationItem.hidesBackButton = true
        totalScoreLabel.text = String(totalScore)
        if totalScore == 0 {
            messageLabel.text = "Bad luck"
            Sound.play(file: "badluck.mp3")
        } else {
            Sound.play(file: "finish.mp3")
        }
        checkHighscore()
        updateLeaderboard()
    }
    
    // Check if current score is higher than database score.
    func checkHighscore() {
        guard let displayName = user.displayName else { return }
        refLeaderboard.child(displayName).observe(.childAdded, with: { (snapshot) in
            let databaseScore = snapshot.value as! Int
            if self.totalScore > databaseScore {
                if self.totalScore != 0 {
                    self.highscoreLabel.isHidden = false
                }
            }
        })
        
    }
    
    // Updates users score if current score is higher than database score.
    func updateLeaderboard(){
        guard let displayName = user.displayName else { return }
        let score = ["score": totalScore as Int]
        self.refLeaderboard.child(displayName).setValue(score)
    }

}

//
//  LoggedInViewController.swift
//  TriviaFlop
//
//  Created by Dennis Broekhuizen on 10-12-17.
//  Copyright © 2017 Dennis Broekhuizen. All rights reserved.
//

import UIKit
import FirebaseAuth

class LoggedInViewController: UIViewController {
    
    @IBOutlet weak var nameLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Show username in mainscreen.
        let user = Auth.auth().currentUser
        if let user = user {
            if let displayName = user.displayName {
                print(displayName)
                nameLabel.text = displayName + ","
            }
        }
    }
    
    @IBAction func logoutTapped(_ sender: Any) {
        // Try to logout.
        do {
            try Auth.auth().signOut()
        } catch {
            print("Something went wrong while logging out.")
        }
    }
    
    @IBAction func unwindToQuizIntroduction(segue: UIStoryboardSegue) {
    }

}

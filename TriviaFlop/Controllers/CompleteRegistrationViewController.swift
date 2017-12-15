//
//  CompleteRegistrationViewController.swift
//  TriviaFlop
//
//  Created by Dennis Broekhuizen on 11-12-17.
//  Copyright © 2017 Dennis Broekhuizen. All rights reserved.
//
//  This file asks the user for an username so it can be used to show that name in the leaderboard. It also checks if the given username already exists in Firebase. If so the app will print an error to the screen, so the user will choose another username. After that the username will be added to an usernames table in firebase and user displayName will be updated to the given username. In this way the username will be stored twice, but firebase does not have an option to check for unique displayNames, because the currentUser can't retrieve that information from other users.

import UIKit
import FirebaseAuth
import FirebaseDatabase

class CompleteRegistrationViewController: UIViewController {

    let refUsernames = Database.database().reference().child("usernames")
    
    @IBOutlet weak var displayNameTextField: UITextField!
    @IBOutlet weak var errorLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Dismiss keyboard when the user taps the screen.
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tap)))
    }
    
    @objc func tap(sender: UITapGestureRecognizer){
        view.endEditing(true)
    }
    
    @IBAction func confirmTapped(_ sender: Any) {
        // Dismiss keyboard when the button is tapped.
        self.view.endEditing(true)
        
        // Check if displayname field is filled in.
        guard let displayName = displayNameTextField.text, !displayName.isEmpty else { return }
        
        // Retrieve all usernames from database.
        refUsernames.observeSingleEvent(of: .value, with: { (snapshot) in
            // Insert user tot database if the username doesn't exsist.
            if snapshot.hasChild(displayName.lowercased()) == false {
                self.insertUsernameToDatabase(username: displayName)
            } else {
                self.errorLabel.text = "Sorry, this username already exists."
            }
        })
    }
    
    // Inserts user to database.
    func insertUsernameToDatabase(username: String) {
        // Insert username to usernames table.
        self.refUsernames.child(username.lowercased()).setValue(username)
        
        // Set currentUser displayName to username.
        let user = Auth.auth().currentUser
        if let user = user {
            let changeRequest = user.createProfileChangeRequest()
            changeRequest.displayName = username
            changeRequest.commitChanges { error in
                // Go to next screen if everything went right.
                if let error = error {
                    self.errorLabel.text = error as? String
                } else {
                    self.presentLoggedInScreen()
                }
            }
        }
    }

    // Function to send the user to the next screen if they log in successfully.
    func presentLoggedInScreen() {
        let storyboard:UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let loggedInViewController:LoggedInViewController = storyboard.instantiateViewController(withIdentifier: "LoggedInViewController") as! LoggedInViewController
        self.present(loggedInViewController, animated: false, completion: nil)
    }
    
}

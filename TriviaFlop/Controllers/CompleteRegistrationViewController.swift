//
//  CompleteRegistrationViewController.swift
//  TriviaFlop
//
//  Created by Dennis Broekhuizen on 11-12-17.
//  Copyright © 2017 Dennis Broekhuizen. All rights reserved.
//

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
        
        guard let displayName = displayNameTextField.text, !displayName.isEmpty else { return }
        refUsernames.observeSingleEvent(of: .value, with: { (snapshot) in
            if snapshot.hasChild(displayName.lowercased()) == false {
                self.refUsernames.child(displayName.lowercased()).setValue(displayName)
                let user = Auth.auth().currentUser
                if let user = user {
                    let changeRequest = user.createProfileChangeRequest()
                    changeRequest.displayName = displayName
                    changeRequest.commitChanges { error in
                        if let error = error {
                            self.errorLabel.text = error as? String
                        } else {
                            self.presentLoggedInScreen()
                        }
                    }
                }
            } else {
                self.errorLabel.text = "Sorry, this username already exists."
            }
        })
    }

    // Function to send the user to the next screen if they log in successfully.
    func presentLoggedInScreen() {
        let storyboard:UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let loggedInViewController:LoggedInViewController = storyboard.instantiateViewController(withIdentifier: "LoggedInViewController") as! LoggedInViewController
        self.present(loggedInViewController, animated: false, completion: nil)
    }
    
}

//
//  ViewController.swift
//  TriviaFlop
//
//  Created by Dennis Broekhuizen on 08-12-17.
//  Copyright © 2017 Dennis Broekhuizen. All rights reserved.
//
//  This file handles logging in to the app or creating an account. After logging in or registering successfull the user will be send to the next screen.
//
//  Login tutorial from https://www.youtube.com/watch?v=_hHohEa0H-Q.

import UIKit
import FirebaseAuth

class LoginViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var errorLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Dismiss keyboard when the user taps the screen.
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tap)))
    }
    
    override func viewDidAppear(_ animated: Bool) {
        // Show logged in screen if the user is already logged in.
        if Auth.auth().currentUser != nil {
            self.presentLoggedInScreen()
        }
    }
    
    @objc func tap(sender: UITapGestureRecognizer){
        view.endEditing(true)
    }
    
    // Function to send the user to the next screen if they log in successfully.
    func presentLoggedInScreen() {
        let storyboard:UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let loggedInViewController:LoggedInViewController = storyboard.instantiateViewController(withIdentifier: "LoggedInViewController") as! LoggedInViewController
        self.present(loggedInViewController, animated: true, completion: nil)
    }
    
    // Function to send the user to the complete registration screen.
    func presentCompleteRegistrationScreen() {
        let storyboard:UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let completeRegistrationViewController:CompleteRegistrationViewController = storyboard.instantiateViewController(withIdentifier: "CompleteRegistrationViewController") as! CompleteRegistrationViewController
        self.present(completeRegistrationViewController, animated: true, completion: nil)
    }

    @IBAction func createAccountTapped(_ sender: Any) {
        // Check if textfields are filled in.
        if let email = emailTextField.text, let password = passwordTextField.text {
            Auth.auth().createUser(withEmail: email, password: password, completion: { user, error in
                // Check if there might be an error from firebase.
                if let firebaseError = error {
                    print(firebaseError.localizedDescription)
                    self.errorLabel.text = firebaseError.localizedDescription
                    return
                }
                
                // Show next screen when registration is successfull.
                self.presentCompleteRegistrationScreen()
                
                // Clear inputfields and labels after logging in successfully.
                self.errorLabel.text = ""
                self.emailTextField.text = ""
                self.passwordTextField.text = ""
                print("Successfully created an account!")
            })
        }
        // Dismiss keyboard when the button is tapped.
        self.view.endEditing(true)
    }
    
    @IBAction func loginTapped(_ sender: Any) {
        // Check if textfields are filled in.
        if let email = emailTextField.text, let password = passwordTextField.text {
            Auth.auth().signIn(withEmail: email, password: password, completion: { user, error in
                // Check if there might be an error from firebase.
                if let firebaseError = error {
                    print(firebaseError.localizedDescription)
                    self.errorLabel.text = firebaseError.localizedDescription
                    return
                }
                
                // Show next screen when login is successfull.
                self.presentLoggedInScreen()
                
                // Clear inputfields and labels after logging in successfully.
                self.errorLabel.text = ""
                self.emailTextField.text = ""
                self.passwordTextField.text = ""
                print("Successfully logged in!")
            })
        }
        // Dismiss keyboard when the button is tapped.
        self.view.endEditing(true)
    }
    
    // Segue to send user back to loginscreen if they logout.
    @IBAction func unwindToLoginScreen(segue: UIStoryboardSegue) {
    }
}


//
//  LoginViewController.swift
//  FindMyOutfit
//
//  
//

import UIKit
import Firebase

class LoginViewController: UIViewController {

    //MARK: - Properties
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!

    private var authUser: FirebaseAuth.User? {
        Auth.auth().currentUser
    }

    //MARK: - Interaction handlers
    @IBAction func signInButtonPressed(_ sender: UIButton) {
        if let email = emailTextField.text, let password = passwordTextField.text {
            Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
                if let error = error {
                    DuplicateFuncs.alertMessage(title: "ERROR", message: error.localizedDescription, viewController: self)
                } else {
                    if self.isEmailVerified() {
                        DuplicateFuncs.alertMessage(title: "Email not verified", message: "Please verify your e-mail", viewController: self)
                    } else {
                        self.performSegue(withIdentifier: K.Segues.loginToHome, sender: self)
                    }
                }
            }
        }
    }
    
    @IBAction func forgotPasswordPressed(_ sender: UIButton) {
        self.performSegue(withIdentifier: K.Segues.loginToForgot, sender: self)
    }
    
    //MARK: - Functions
    func isEmailVerified() -> Bool {
        if authUser != nil && !authUser!.isEmailVerified {
            // User is available, but their email is not verified.
            return true
        }
        return false
    }
}


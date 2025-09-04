//
//  ForgotPasswordViewController.swift
//  FindMyOutfit
//
//  
//

import UIKit
import Firebase

class ForgotPasswordViewController: UIViewController {

    //MARK: - Properties
    @IBOutlet weak var emailTextField: UITextField!
    
    //MARK: - Interaction handlers
    @IBAction func sendNewPasswordButtonPressed(_ sender: UIButton) {
        if let email = emailTextField.text {
            if email == "" {
                DuplicateFuncs.alertMessage(title: "ERROR", message: "Please enter a valid email", viewController: self)
            } else {
                Auth.auth().sendPasswordReset(withEmail: email) { error in
                    if let error = error {
                        DuplicateFuncs.alertMessage(title: "Network error", message: error.localizedDescription, viewController: self)
                    } else {
                        DuplicateFuncs.alertMessageWithHandler(title: "Success", message: "Please check your email", viewController: self) {
                            self.performSegue(withIdentifier: K.Segues.forgotToLogin, sender: self)
                        }
                    }
                }
            }
        }
    }
}

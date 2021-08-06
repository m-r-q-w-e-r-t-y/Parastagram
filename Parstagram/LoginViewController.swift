//
//  LoginViewController.swift
//  Parstagram
//
//  Created by Anthony Mendez on 8/1/21.
//

import UIKit
import Parse

class LoginViewController: UIViewController {

    // Outlet Setup
    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

        // Do any additional setup after loading the view.
    }
    
    
    // Action Setup
    @IBAction func onSignIn(_ sender: Any) {
        // Obtain Text From Fields
        let username = usernameField.text!
        let password = passwordField.text!
        
        // Login w/ Parse
        PFUser.logInWithUsername(inBackground:username, password:password) { (user, error) in
          if user != nil {
            // Do stuff after successful login
            self.performSegue(withIdentifier: "loginSegue", sender: nil)
          }
          else {
            // The login failed. Check error to see why.
            print("Error: \(error?.localizedDescription)")
          }
        }
    }
    
    
    @IBAction func onSignUp(_ sender: Any) {
        // Create User
        let user = PFUser()
        
        // Configure Properties {.username, .password, .email}
        user.username = usernameField.text
        user.password = passwordField.text
        
        // Put User In Parse Database
        user.signUpInBackground { (success, error) in
            if success {
                // Next Screen
                self.performSegue(withIdentifier: "loginSegue", sender: nil)
            }
            else {
                // Print Error
                print("Error: \(error?.localizedDescription)")
            }
          }
        
    }
    
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

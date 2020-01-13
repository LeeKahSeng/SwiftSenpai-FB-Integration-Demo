//
//  CustomButtonViewController.swift
//  SwiftSenpai-FB-Integration-Demo
//
//  Created by Lee Kah Seng on 10/01/2020.
//  Copyright © 2020 Lee Kah Seng. All rights reserved.
//

import UIKit
import FBSDKLoginKit

class CustomButtonViewController: UIViewController {
    
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var messageLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateButton(isLoggedIn: (AccessToken.current != nil))
        updateMessage(with: Profile.current?.name)
    }
    
    
    @IBAction func loginButtonTapped(_ sender: Any) {
        
        let loginManager = LoginManager()
        
        if let _ = AccessToken.current {
            // Access token available -- user already logged in
            // Perform log out
            
            loginManager.logOut()
            updateButton(isLoggedIn: false)
            updateMessage(with: nil)
            
        } else {
            // Access token not available -- user already logged out
            // Perform log in
            
            loginManager.logIn(permissions: [], from: self) { [weak self] (result, error) in
                
                // Check for error
                guard error == nil else {
                    // Error occurred
                    print(error!.localizedDescription)
                    return
                }
                
                // Check for cancel
                guard let result = result, !result.isCancelled else {
                    print("User cancelled login")
                    return
                }
                
                // Successfully logged in
                self?.updateButton(isLoggedIn: true)
                
                Profile.loadCurrentProfile { (profile, error) in
                    self?.updateMessage(with: Profile.current?.name)
                }
            }
        }
    }
}

// MARK:- Private functions
extension CustomButtonViewController {
    
    private func updateButton(isLoggedIn: Bool) {
        let title = isLoggedIn ? "Log out 👋🏻" : "Log in 👍🏻"
        loginButton.setTitle(title, for: .normal)
    }
    
    private func updateMessage(with name: String?) {
        
        guard let name = name else {
            // User already logged out
            messageLabel.text = "Please log in with Facebook."
            return
        }
        
        // User already logged in
        messageLabel.text = "Hello, \(name)!"
    }
}

//
//  ReusableButtonViewController.swift
//  SwiftSenpai-FB-Integration-Demo
//
//  Created by Lee Kah Seng on 10/01/2020.
//  Copyright © 2020 Lee Kah Seng. All rights reserved.
//

import UIKit
import FBSDKLoginKit

class ReusableButtonViewController: UIViewController {
    
    @IBOutlet weak var loginButton: MYFacebookLoginButton!
    @IBOutlet weak var messageLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateMessage(with: Profile.current?.name)
        
        // Implement login completion handler
        loginButton.loginCompletionHandler = { [weak self] (button, result) in
            switch result {
            case .success(let result):
                print("Access token: \(String(describing: result.token?.tokenString))")
                
                // Show message after login completed
                Profile.loadCurrentProfile { (profile, error) in
                    self?.updateMessage(with: Profile.current?.name)
                }
            case .failure(let error):
                print("Error occurred: \(error.localizedDescription)")
                break
            }
        }
        
        // Implement logout completion handler
        loginButton.logoutCompletionHandler = { [weak self] (button) in
            // Show message after logout completed
            self?.updateMessage(with: nil)
        }
    }
}

// MARK:- Private functions
extension ReusableButtonViewController {
    
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

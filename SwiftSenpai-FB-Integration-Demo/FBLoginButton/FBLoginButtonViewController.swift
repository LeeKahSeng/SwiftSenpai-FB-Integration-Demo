//
//  FBLoginButtonViewController.swift
//  SwiftSenpai-FB-Integration-Demo
//
//  Created by Lee Kah Seng on 07/01/2020.
//  Copyright © 2020 Lee Kah Seng. All rights reserved.
//

import UIKit
import FBSDKLoginKit

class FBLoginButtonViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Add FBLoginButton at center of view controller
        let loginButton = FBLoginButton()
        loginButton.center = view.center
        view.addSubview(loginButton)
        
        // Observe access token changes
        // This will trigger after successfully login / logout
        NotificationCenter.default.addObserver(forName: .AccessTokenDidChange, object: nil, queue: OperationQueue.main) { (notification) in
            
            // Print out access token
            print("FB Access Token: \(String(describing: AccessToken.current?.tokenString))")
        }
    }
}


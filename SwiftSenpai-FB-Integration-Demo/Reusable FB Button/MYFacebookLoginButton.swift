//
//  MYFacebookLoginButton.swift
//  SwiftSenpai-FB-Integration-Demo
//
//  Created by Lee Kah Seng on 10/01/2020.
//  Copyright © 2020 Lee Kah Seng. All rights reserved.
//

import UIKit
import FBSDKLoginKit

class MYFacebookLoginButton: UIButton {
    
    // Closure to handle login / logout event
    var loginCompletionHandler: ((MYFacebookLoginButton, Result<LoginManagerLoginResult, Error>) -> Void)?
    var logoutCompletionHandler: ((MYFacebookLoginButton) -> Void)?
    
    private var responsibleViewController: UIViewController!
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
        commonSetup()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonSetup()
    }

}

// MARK:- Private functions
extension MYFacebookLoginButton {
    
    private func commonSetup() {
        
        // Set button title
        updateButton(isLoggedIn: (AccessToken.current != nil))
        
        responsibleViewController = findResponsibleViewController()
        
        // Overried touch up inside event
        addTarget(self, action: #selector(touchUpInside(sender:)), for: .touchUpInside)
    }
    
    private func updateButton(isLoggedIn: Bool) {
        let title = isLoggedIn ? "Log out 👋🏻" : "Log in 👍🏻"
        setTitle(title, for: .normal)
    }
    
    @objc private func touchUpInside(sender: MYFacebookLoginButton) {
        
        let loginManager = LoginManager()
        
        if let _ = AccessToken.current {
            // Access token available -- user already logged in
            // Perform log out
            
            loginManager.logOut()
            updateButton(isLoggedIn: false)
            
            // Trigger logout completed handler
            logoutCompletionHandler?(self)
            
        } else {
            // Access token not available -- user already logged out
            // Perform log in
            
            loginManager.logIn(permissions: [], from: responsibleViewController) { [weak self] (result, error) in
                
                // Check for error
                guard error == nil else {
                    // Error occured
                    print(error!.localizedDescription)
                    
                    if let self = self {
                        self.loginCompletionHandler?(self, .failure(error!))
                    }
                    
                    return
                }
                
                // Check for cancel
                guard let result = result, !result.isCancelled else {
                    print("User cancelled login")
                    return
                }
                
                // Successfully logged in
                self?.updateButton(isLoggedIn: true)
                
                // Trigger login completed handler
                if let self = self {
                    self.loginCompletionHandler?(self, .success(result))
                }
            }
        }
    }
}

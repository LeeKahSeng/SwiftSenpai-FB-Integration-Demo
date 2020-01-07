//
//  ViewController.swift
//  SwiftSenpai-FB-Integration-Demo
//
//  Created by Lee Kah Seng on 07/01/2020.
//  Copyright © 2020 Lee Kah Seng. All rights reserved.
//

import UIKit
import FBSDKLoginKit


class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let loginButton = FBLoginButton()
        loginButton.center = view.center
        view.addSubview(loginButton)
        
        NotificationCenter.default.addObserver(forName: .AccessTokenDidChange, object: nil, queue: OperationQueue.main) { (notification) in
            
            print("FB Access Token: \(String(describing: AccessToken.current?.tokenString))")
        }
    }


}


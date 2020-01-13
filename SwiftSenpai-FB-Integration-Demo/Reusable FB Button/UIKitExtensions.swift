//
//  UIKitExtensions.swift
//  SwiftSenpai-FB-Integration-Demo
//
//  Created by Lee Kah Seng on 10/01/2020.
//  Copyright © 2020 Lee Kah Seng. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    
    /// Find the view controller that responsible for a particular view
    func findResponsibleViewController() -> UIViewController? {
        if let nextResponder = self.next as? UIViewController {
            return nextResponder
        } else if let nextResponder = self.next as? UIView {
            return nextResponder.findResponsibleViewController()
        } else {
            return nil
        }
    }
}

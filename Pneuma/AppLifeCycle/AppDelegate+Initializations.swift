//
//  AppDelegate+Initializations.swift
//  Pneuma
//
//  Created by Chitra on 24/02/21.
//  Copyright © 2021 iTechnolabs. All rights reserved.
//

import UIKit
import IQKeyboardManagerSwift

///Define any method here which we want to use in app delegate & call it from app delegate class.
extension AppDelegate {
    
    func initializeLibraries() {
        IQKeyboardManager.shared.enable = true
        self.initializeReachability()
    }
    
    
}

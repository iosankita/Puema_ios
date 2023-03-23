//
//  SplashViewModel.swift
//  Pneuma
//
//  Created by MacBook Pro on 31/10/21.
//  Copyright © 2021 Jatin. All rights reserved.
//

import Foundation
import UIKit

class SplashViewModel {
    
    var splashModel: SplashModel!
    var titleText: String!
    var messageText: String!
    
    init(withIndex index: Int) {
        self.splashModel = SplashModel()
        self.splashModel.makeModel(index: index)
        self.titleText = self.splashModel.title
        self.messageText = self.splashModel.message
    }
}

//
//  SplashDataModel.swift
//  Pneuma
//
//  Created by MacBook Pro on 31/10/21.
//  Copyright © 2021 Jatin. All rights reserved.
//

import Foundation
import UIKit

class SplashModel {
    
    var title : String!
    var message : String!
    

    let dataMessage = [
        "Hello, I'm Annie. Your Assistant!",
        "I am able to give you a personalized travel experience",
        "I'd like to know a couple of things about your preference.",
    ]
    
    func makeModel(index: Int) {
        self.message = dataMessage[index]
        
    }
    
}

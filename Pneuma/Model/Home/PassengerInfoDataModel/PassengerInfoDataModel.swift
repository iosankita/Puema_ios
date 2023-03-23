//
//  PassengerInfoDataModel.swift
//  Pneuma
//
//  Created by Jatin on 02/03/21.
//  Copyright © 2021 Jatin. All rights reserved.
//

import Foundation

enum PassengerInfoCurrentStep: Int {
    case personalInfo = 1
    case contactInfo
    case payment
    
    var stepNumberText: String {
        switch self {
        
        case .personalInfo:
            return "Step 1 of 3"
        case .contactInfo:
            return "Step 2 of 3"
        case .payment:
            return "Step 3 of 3"
            
        }
    }
    
    var stepTitleText: String {
        switch self {
        
        case .personalInfo:
            return "Passenger Information 1 - Adult"
        case .contactInfo:
            return "Contact Information"
        case .payment:
            return "Payment Method"
        }
    }
}

class PaymentMethodDataModel: Codable {
    var title: String
    var isSelected: Bool
    var separator: Bool
    
    init(title: String, isSelected: Bool = false, separator: Bool = true) {
        self.title = title
        self.isSelected = isSelected
        self.separator = separator
    }
}

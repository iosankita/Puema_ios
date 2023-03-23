//
//  LocalizedStringEnum.swift
//  Pneuma
//
//  Created by Tina on 02/04/20.
//  Copyright © 2021 Tina. All rights reserved.
//

import Foundation

enum LocalizedStringEnum: String {
    case appName
    case networkNotReachable
    case somethingWentWrong
    case sessionExpired
    
    //MARK:- Alerts
    case ok
    case yes
    case no
    case cancel
    
    //MARK:- VALIDATIONS
    case answerTheQuestion
    case chooseOption
    case confirmLogout
    
    case enterEmailAddress
    case enterPassword
    case enterValidEmailAddress
    case enterFullName
    case enterValidPassword
    case InvalidPassword
    case emptyOTP
    case validOTP
    case enterOldPassword
    case enterConfirmPassword
    case enterValidPhone
    case enterDOB
    case enterNationality
    case enterIssueDate
    case enterExpiryDate
    case enterCountryCode
    case enterPassportNumber
    case enterCitizenshipNUmber

    
 
    var localized: String {
        return NSLocalizedString(self.rawValue, comment: self.rawValue)
    }
}


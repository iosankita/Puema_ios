//
//  MyProfileDataSource.swift
//  Pneuma
//
//  Created by Chitra on 02/03/21.
//  Copyright © 2021 Jatin. All rights reserved.
//

import Foundation

class MyProfileDataSourceModel: NSObject {
    var listArray = [MyProfileModel]()
}

class MyProfileModel {
    var title: String
    var type: ProfileModelType
    
    init(title: String, type: ProfileModelType) {
        self.title = title
        self.type = type
    }
}

enum ProfileModelType {
    case name
    case email
    case password
    case phoneNumber
    case passportData
    
    var displayString: String {
        switch self {
        case .name:
            return "Change Name"
        case .email:
            return "Change Email"
        case .password:
            return "Change Password"
        case .phoneNumber:
            return "Phone Number"
        case .passportData:
            return "Passport Data"
        }
    }
}


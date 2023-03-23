//
//  SettingsModel.swift
//  Pneuma
//
//  Created by Chitra on 05/03/21.
//  Copyright © 2021 Jatin. All rights reserved.
//

import Foundation

class SettingsDataSourceModel: NSObject {
    var listArray = [SettingsType: [SettingsModel]]()
}

enum SettingsType: Int {
    case general
    case notify
    case notifyVia
    
    var displayString: String {
        switch self {
        case .notify:
            return "Notify"
        case .notifyVia:
            return "Notify Via"
        case .general:
            return ""
        }
    }
}

enum SettingsSubType {
    case appLanguage
    case preferredCurrency
    case payment
}

class SettingsModel {
    var title: String
    var infoData: String
    var isSelected: Bool
    var subType: SettingsSubType?
    
    init(title: String, infoData: String = "", isSelected: Bool = false, subType: SettingsSubType? = nil) {
        self.title = title
        self.infoData = infoData
        self.isSelected = isSelected
        self.subType = subType
    }
}

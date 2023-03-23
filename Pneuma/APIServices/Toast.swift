//
//  Toast.swift
//  Prim
//
//  Created by admin on 12/05/20.
//  Copyright © 2021 Prim. All rights reserved.
//

import UIKit
import SwiftEntryKit

enum AlertType: String {
    case success
    case apiFailure
    case validationFailure
    case notification
    
    var title: String {
        return NSLocalizedString(self.rawValue, comment: "")
    }
    
    var color: UIColor {
        return AppColor.themeOrange.getColor()
    }
}

class Toast {
    
    static let shared = Toast()
    
    func showAlert(type: AlertType, message: String) {
        var attributes = EKAttributes()
        attributes.windowLevel = .statusBar
        attributes.position = .top
        attributes.displayDuration = 2.0
        attributes.entryBackground = .color(color: EKColor.init(type.color))
        attributes.positionConstraints.safeArea = .empty(fillSafeArea: true)
        let title = EKProperty.LabelContent.init(text: type.title, style: .init(font: UIFont.systemFont(ofSize: UIFont.systemFontSize), color: EKColor.init(UIColor.white)))
        let description = EKProperty.LabelContent.init(text: message, style: .init(font: UIFont.systemFont(ofSize: UIFont.systemFontSize), color: EKColor.init(UIColor.white)))
        let simpleMessage = EKSimpleMessage.init(title: title, description: description)
        let notificationMessage = EKNotificationMessage.init(simpleMessage: simpleMessage)
        let contentView = EKNotificationMessageView(with: notificationMessage)
        SwiftEntryKit.display(entry: contentView, using: attributes)
    }
}


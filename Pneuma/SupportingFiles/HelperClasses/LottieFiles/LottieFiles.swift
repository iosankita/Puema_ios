//
//  LottieFiles.swift
//  Prim
//
//  Created by admin on 17/05/20.
//  Copyright © 2021 Prim. All rights reserved.
//

import UIKit

enum LottieFiles: String {
    case NextAccessory
    case Dots
    case Uploading
    case Error
    case ErrorEmoji
    case BtnWhiteLoader
    case BtnAppTintLoader
    case LineProgress
    
    func getFileName() -> String {
        if #available(iOS 13.0, *) {
            return UITraitCollection.current.userInterfaceStyle == .dark ? getDarkModeFiles() : getLightModeFiles()
        } else {
            return getLightModeFiles()
        }
    }
    
    private func getLightModeFiles() -> String {
        switch self {
        case .NextAccessory:
            return "BaloonLight"
        case .Dots:
            return "DotsLight"
        case .Uploading:
            return "Uploading"
        case .Error:
            return "NoData"
        case .ErrorEmoji:
            return "ErrorEmoji"
        case .BtnWhiteLoader:
            return "BtnWhiteLoader"
        case .BtnAppTintLoader:
            return "BtnAppTintLoader"
        case .LineProgress:
            return "LineProgress"
        }
    }
    
    private func getDarkModeFiles() -> String {
        switch self {
        case .NextAccessory:
            return "BaloonDark"
        case .Dots:
            return "DotsDark"
        case .Uploading:
            return "Uploading"
        case .Error:
            return "NoData"
        case .ErrorEmoji:
            return "ErrorEmoji"
        case .BtnWhiteLoader:
            return "BtnWhiteLoader"
        case .BtnAppTintLoader:
            return "BtnAppTintLoader"
        case .LineProgress:
            return "LineProgress"
        }
    }
    
}

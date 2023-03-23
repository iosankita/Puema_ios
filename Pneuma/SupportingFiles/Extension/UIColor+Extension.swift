//
//  UIColor+Extension.swift
//  Pneuma
//
//  Created by Chitra on 24/02/21.
//  Copyright © 2021 iTechnolabs. All rights reserved.
//

import UIKit

enum AppColor: String {
    case themeViolet
    case themePink
    case themeYellow
    case themeOrange
    case lightPink
    case darkText
    case questionnaireOrange
    case questionnaireGray
    case darkPink
    case darkViolet
    
    func getColor() -> UIColor {
        switch self {
            
        case .themeYellow:
            return #colorLiteral(red: 0.9803921569, green: 0.6862745098, blue: 0.09019607843, alpha: 1)
        case .themeViolet:
            return #colorLiteral(red: 0.4980392157, green: 0.1411764706, blue: 0.7843137255, alpha: 1)
        case .themePink:
            return #colorLiteral(red: 0.6392156863, green: 0.1137254902, blue: 0.6235294118, alpha: 1)
        case .lightPink:
            return #colorLiteral(red: 0.8392156863, green: 0.2941176471, blue: 0.8862745098, alpha: 1)
        case .themeOrange:
            return #colorLiteral(red: 0.8901960784, green: 0.3490196078, blue: 0.003921568627, alpha: 1)
        case .darkText:
            return UIColor(named: "darkText") ?? UIColor.darkGray
        case .questionnaireOrange:
            return #colorLiteral(red: 0.9542487158, green: 0.4963801873, blue: 0.0431372549, alpha: 1)
        case .questionnaireGray:
            return #colorLiteral(red: 0.8509803922, green: 0.8509803922, blue: 0.8509803922, alpha: 1)
        case .darkPink:
            return #colorLiteral(red: 0.7411764706, green: 0.2117647059, blue: 0.6941176471, alpha: 1)
        case .darkViolet:
            return #colorLiteral(red: 0.5411764706, green: 0.2980392157, blue: 0.8901960784, alpha: 1)
        }
    }
}

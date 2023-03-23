//
//  AppFont.swift
//  Pneuma
//
//  Created by Jatin on 09/04/20.
//  Copyright © 2021 Tina. All rights reserved.
//

import Foundation
import UIKit

//MARK: Enumeration
enum AppFont: String {

    case bold = "Poppins-Bold"
    case light = "Poppins-Light"
    case medium = "Poppins-Medium"
    case semiBold = "Poppins-SemiBold"
    case regular = "Poppins-Regular"
    
    func fontWithSize(_ size: CGFloat) -> UIFont {
        return UIFont(name: rawValue, size: size)!
    }
}


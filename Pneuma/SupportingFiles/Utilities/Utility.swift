//
//  Utility.swift
//  Pneuma
//
//  Created by Tina on 14/04/20.
//  Copyright © 2021 Tina. All rights reserved.
//

import Foundation
import UIKit

class Utility {
class func addEqualConstraints(for view: UIView, inSuperView superView: UIView, isNavigationHidden:Bool = true) {
    view.alpha = 0
     view.translatesAutoresizingMaskIntoConstraints = false
     superView.addSubview(view)
     let bottomConstraint = NSLayoutConstraint(item: view, attribute: .bottom, relatedBy: .equal, toItem: superView, attribute: .bottom, multiplier: 1.0, constant: 0)
     let leftConstraint = NSLayoutConstraint(item: view, attribute: .left, relatedBy: .equal, toItem: superView, attribute: .left, multiplier: 1.0, constant: 0)
     let rightConstraint = NSLayoutConstraint(item: view, attribute: .right, relatedBy: .equal, toItem: superView, attribute: .right, multiplier: 1.0, constant: 0)
     let topConstraint = NSLayoutConstraint(item: view, attribute: .top, relatedBy: .equal, toItem: superView, attribute: .top, multiplier: 1.0, constant: 0)
     superView.addConstraints([topConstraint, bottomConstraint, leftConstraint, rightConstraint])
    UIView.animate(withDuration: 0.3, delay: 0, options: UIView.AnimationOptions.curveEaseIn, animations: {
        view.alpha = 1
    }) { (finish) in
        //
    }
 }

}

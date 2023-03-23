//
//  UIViewController+Extension.swift
//  Pneuma
//
//  Created by Jatin on 02/03/21.
//  Copyright © 2021 Jatin. All rights reserved.
//

import UIKit

extension UIViewController {
    func addChildVC(_ child: UIViewController, toContainerView containerView: UIView) {
        containerView.removeSubviews()
        addChild(child)
        Utility.addEqualConstraints(for: child.view, inSuperView: containerView)
        child.didMove(toParent: self)
    }

  
}

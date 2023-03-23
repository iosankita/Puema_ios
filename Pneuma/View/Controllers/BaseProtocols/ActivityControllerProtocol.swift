//
//  ActivityControllerProtocol.swift
//  Pneuma
//
//  Created by Chitra on 24/02/21.
//  Copyright © 2021 iTechnolabs. All rights reserved.
//

import UIKit

protocol ActivityProtocol {
    
}

extension ActivityProtocol where Self: UIViewController {
    func openShareSheet(with text: String) {
        let shareArray: [Any] = [text]
        let activityViewController = UIActivityViewController(activityItems: shareArray , applicationActivities: nil)
        activityViewController.popoverPresentationController?.sourceView = self.view
        self.present(activityViewController, animated: true, completion: nil)
    }
}

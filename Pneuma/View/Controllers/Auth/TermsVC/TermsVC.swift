//
//  TermsVC.swift
//  Pneuma
//
//  Created by Chitra on 12/03/21.
//  Copyright © 2021 Jatin. All rights reserved.
//

import UIKit

enum TermsPrivacyType: String {
    case termsConditions = "Terms & Conditions"
    case privacyPolicy = "Privacy Policy"
}

class TermsVC: UIViewController {

    @IBOutlet weak var customNav: CustomNavigationView!
    @IBOutlet weak var textView: UITextView!
    
    var type = TermsPrivacyType.termsConditions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        customNav.title = self.type.rawValue
    }

}

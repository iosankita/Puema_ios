//
//  ReportDriverReasonVC.swift
//  Pneuma
//
//  Created by Chitra on 09/03/21.
//  Copyright © 2021 Jatin. All rights reserved.
//

import UIKit

class ReportDriverReasonVC: UIViewController {

    @IBOutlet weak var reasonTF: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func addAction(_ sender: Any) {
    }
    
    @IBAction func cancelAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}

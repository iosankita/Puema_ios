//
//  DriverDetailCompletedRideVC.swift
//  Pneuma
//
//  Created by iTechnolabs on 05/03/21.
//  Copyright © 2021 Jatin. All rights reserved.
//

import UIKit

class DriverDetailCompletedRideVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func reportDriverACtion(_ sender: Any) {
        let vc = UIStoryboard.loadReportDriverReasonVC()
        self.present(vc, animated: true, completion: nil)
    }
    
}

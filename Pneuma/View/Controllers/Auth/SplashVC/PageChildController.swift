//
//  PageChildController.swift
//  Pneuma
//
//  Created by MacBook Pro on 31/10/21.
//  Copyright © 2021 Jatin. All rights reserved.
//


import UIKit

class PageChildController: UIViewController {

    @IBOutlet weak var illustration: UIImageView!
    @IBOutlet weak var messageLabel: UILabel!
    var index: Int!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let index = self.index else {
            return
        }
        let viewModel = SplashViewModel(withIndex: index)
        self.messageLabel.text = viewModel.messageText
    }

}

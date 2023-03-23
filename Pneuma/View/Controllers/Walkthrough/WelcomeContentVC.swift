//
//  WelcomeContentVC.swift
//  Pneuma
//
//  Created by Chitra on 26/02/21.
//  Copyright © 2021 Chitra. All rights reserved.
//

import UIKit

class WelcomeContentVC: UIViewController {
    
    //MARK:- IBOutlet
    @IBOutlet weak var walkthroughImage: UIImageView!
    @IBOutlet weak var headerLabel: UILabel!
    
    //MARK:- Variables
    var index = 0
    var heading = ""
    var imageFile = ""
    
    //MARK:- VIEW LIFE CYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        walkthroughImage.image = UIImage(named: imageFile)
        headerLabel.text = heading
    }
    
    
    
}

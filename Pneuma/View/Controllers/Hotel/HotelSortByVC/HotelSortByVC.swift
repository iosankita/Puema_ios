//
//  HotelSortByVC.swift
//  Pneuma
//
//  Created by Jatin on 04/03/21.
//  Copyright © 2021 Jatin. All rights reserved.
//

import UIKit

class HotelSortByVC: UIViewController {
    // MARK: - IBOUTLETS
    @IBOutlet weak var sortByPriceButton: UIButton!
    @IBOutlet weak var sortByRatingButton: UIButton!
        
    @IBOutlet weak var containerView: UIView!
    
    // MARK: - VARIABLES
    
    // MARK: - VIEW LIFE CYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.containerView.roundCorners([.topLeft, .topRight], radius: 20)
    }
    
    // MARK: - IBACTIONS
    @IBAction func resetButtonAction(_ sender: UIButton) {
    }
        
    @IBAction func applyButtonAction(_ sender: UIButton) {
    }
    
    @IBAction func cancelButtonAction(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func priceButtonAction(_ sender: UIButton) {
        sender.isSelected = true
        self.sortByRatingButton.isSelected = false
    }
    
    @IBAction func ratingButtonAction(_ sender: UIButton) {
        sender.isSelected = true
        self.sortByPriceButton.isSelected = false
    }
    // MARK: - PRIVATE FUNCTIONS
    
}

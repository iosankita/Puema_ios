//
//  TicketFilterVC.swift
//  Pneuma
//
//  Created by Jatin on 03/03/21.
//  Copyright © 2021 Jatin. All rights reserved.
//

import UIKit

class TicketFilterVC: UIViewController {

    // MARK: - IBOUTLETS
    @IBOutlet weak var sortByBestButton: UIButton!
    @IBOutlet weak var sortByPriceButton: UIButton!
    @IBOutlet weak var sortByDurationButton: UIButton!
    
    @IBOutlet weak var maxStopMinusButton: UIButton!
    @IBOutlet weak var maxStopPlusButton: UIButton!
    @IBOutlet weak var maxDurationMinusButton: UIButton!
    @IBOutlet weak var maxDurationPlusButton: UIButton!
    
    @IBOutlet weak var stopCountLabel: UILabel!
    @IBOutlet weak var durationCountLabel: UILabel!
    
    @IBOutlet weak var containerView: UIView!
    var maxLimit = Int()
    var sort = String()
    var max_duration  = 1200
    // MARK: - VARIABLES
    var isSelectedData: ((Int,Int,String) -> Void)?
    // MARK: - VIEW LIFE CYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        stopCountLabel.text = "\(maxLimit)"
        durationCountLabel.text = "\(max_duration)"
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.containerView.roundCorners([.topLeft, .topRight], radius: 20)
    }
    
    // MARK: - IBACTIONS
    @IBAction func resetButtonAction(_ sender: UIButton) {
        maxLimit = 1
        max_duration = 20
        sort = ""
        sortByBestButton.isSelected = false
        sortByPriceButton.isSelected = false
        sortByDurationButton.isSelected = false
        stopCountLabel.text = "\(maxLimit)"
        durationCountLabel.text = "\(max_duration)"
    }
    
    ///Single action for all sort by buttons
    @IBAction func sortButtonAction(_ sender: UIButton) {
        sortByBestButton.isSelected = false
        sortByPriceButton.isSelected = false
        sortByDurationButton.isSelected = false
        sender.isSelected = !sender.isSelected
        sort = sender.titleLabel?.text?.lowercased() ?? ""
       
    }
    
    ///Single action for all filter minus button
    @IBAction func filterMinusButtonAction(_ sender: UIButton) {
        switch sender.tag {
        case 0:
            maxLimit -= 1
            stopCountLabel.text = "\(maxLimit)"
        default:
            max_duration -= 1
            durationCountLabel.text = "\(max_duration)"
        }
    }
    
    ///Single action for all filter plus button
    @IBAction func filterPlusButtonAction(_ sender: UIButton) {
       
        switch sender.tag {
        case 0:
            maxLimit += 1
            stopCountLabel.text = "\(maxLimit)"
        default:
            max_duration += 1
            durationCountLabel.text = "\(max_duration)"
        }
        
    }
    
    @IBAction func applyButtonAction(_ sender: UIButton) {
        isSelectedData?(maxLimit,max_duration,sort)
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func cancelButtonAction(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    // MARK: - PRIVATE FUNCTIONS
    
}

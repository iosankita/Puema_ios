//
//  SearchDriverVC.swift
//  Pneuma
//
//  Created by Chitra on 04/03/21.
//  Copyright © 2021 Jatin. All rights reserved.
//

import UIKit

protocol SearchDriverDelegate: class {
    func didCancelRide()
    func didSearchAgain()
}

class SearchDriverVC: UIViewController {
    
    enum SearchDriverStatus {
        case searching
        case noDriver
        case searchAnother
    }

    //MARK:- IBOUTLETS
    @IBOutlet weak var noDriverImage: UIImageView!
    @IBOutlet weak var searchImage: UIImageView!
    @IBOutlet weak var searchTitleLabel: UILabel!
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var buttonsView: UIView!
    @IBOutlet weak var cancelOrderLargeButton: UIButton!
    @IBOutlet weak var searchButton: UIButton!
    @IBOutlet weak var cancelOrderView: UIView!
    @IBOutlet weak var cancelOrderSmallButton: UIButton!
    
    var status: SearchDriverStatus = .noDriver
    weak var delegate: SearchDriverDelegate?
    
    //MARK:- VIEW LIFECYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupUI()
    }
    
    //MARK:- IBACTIONS
    @IBAction func cancelOrderAction(_ sender: Any) {
        self.delegate?.didCancelRide()
    }
    
    @IBAction func searchAgainAction(_ sender: Any) {
    }
    
    //MARK:- PRIVATE FUNCTIONS
    private func setupUI() {
        
        noDriverImage.isHidden = true
        searchImage.isHidden = true
        searchTitleLabel.isHidden = true
        messageLabel.isHidden = true
        cancelOrderLargeButton.isHidden = true
        searchButton.isHidden = true
        cancelOrderView.isHidden = true
        
        switch status {
        case .searching:
            searchImage.isHidden = false
            searchTitleLabel.isHidden = false
            cancelOrderLargeButton.isHidden = false
        case .searchAnother:
            searchImage.isHidden = false
            searchTitleLabel.isHidden = false
            cancelOrderLargeButton.isHidden = false
            messageLabel.isHidden = false
            messageLabel.text = "The driver refused the order. We are looking for another driver."
        case  .noDriver:
            noDriverImage.isHidden = false
            searchButton.isHidden = false
            cancelOrderView.isHidden = false
            messageLabel.isHidden = false
            messageLabel.text = "There are no drivers in your area according to requested service."
            
        }
    }

}

//
//  RideRouteAndDriverInfoView.swift
//  Pneuma
//
//  Created by Jatin on 16/03/21.
//  Copyright © 2021 Jatin. All rights reserved.
//

import UIKit

protocol RideRouteDriverInfoDelegate: class {
    func didTapDriverView()
}

class RideRouteAndDriverInfoView: UIView {
    
    // MARK: - IBOUTLETS
    @IBOutlet weak var dateTimeLabel: UILabel!
    @IBOutlet weak var driverNameLabel: UILabel!
    @IBOutlet weak var carNameLabel: UILabel!
    @IBOutlet weak var rideTypeLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var distanceLabel: UILabel!
    @IBOutlet weak var originLabel: UILabel!
    @IBOutlet weak var destinationLabel: UILabel!
    @IBOutlet weak var amountLabel: UILabel!
    @IBOutlet weak var currencyTypeLabel: UILabel!
    @IBOutlet weak var cardInfoLabel: UILabel!
    
    @IBOutlet weak var driverStatusButton: UIButton!
    @IBOutlet weak var callDriverButton: UIButton!
    @IBOutlet weak var cancelOrderButton: UIButton!
    
    @IBOutlet weak var rideTypeView: UIView!
    @IBOutlet weak var chatButtonView: UIView!
    @IBOutlet weak var driverInfoView: UIView!
    @IBOutlet weak var driverRatingView: UIView!
    @IBOutlet weak var driverStatusView: UIView!
    @IBOutlet weak var rideRouteView: UIView!
    @IBOutlet weak var routeDottedLineView: UIView!
    @IBOutlet weak var amountView: UIView!
    @IBOutlet weak var ratingContainerView: UIView!
    @IBOutlet weak var ratingView: HCSStarRatingView!

    @IBOutlet weak var driverImageView: UIImageView!
    
    @IBOutlet weak var rideTypeStackView: UIStackView!
    
    weak var delegate: RideRouteDriverInfoDelegate?
    
    // MARK: - VIEW LIFE CYCLE
    override func draw(_ rect: CGRect) {
        // Drawing code
        self.drawDottedLine()
    }
    
    // MARK: - IBACTIONS
    @IBAction func chatButtonAction(_ sender: UIButton) {
    }
    
    @IBAction func callDriverButtonAction(_ sender: UIButton) {
    }
    
    @IBAction func cancelOrderButtonAction(_ sender: UIButton) {
    }
    
    @IBAction func driverInfoButtonAction(_ sender: Any) {
        self.delegate?.didTapDriverView()
    }
    
    // MARK: - INTERNAL FUNCTIONS
    func setupView(model: RideModel) {
        self.driverNameLabel.text = model.rider_name
        self.ratingLabel.text = "\(model.rider_rating ?? 0.0)"
        self.originLabel.text = model.pickup_location
        self.destinationLabel.text = model.drop_location
        self.dateTimeLabel.text = model.pickup_time
        self.amountLabel.text = "\(model.price ?? 0)"
        
        
//        self.driverStatusView.isHidden = model.isDriverStateViewHidden
//        self.rideTypeLabel.text = model.rideState.displayText
//        self.driverInfoView.isHidden = model.rideState.isDriverInfoHidden
//        self.amountView.isHidden = model.rideState.isAmountViewHidden
//        
//        if model.rideState == .inProgress {
//            self.rideTypeView.isHidden = true
//            self.callDriverButton.isHidden = false
//            self.cancelOrderButton.isHidden = false
//        }else {
//            self.chatButtonView.isHidden = true
//            self.callDriverButton.isHidden = true
//            self.cancelOrderButton.isHidden = true
//        }
//        self.ratingContainerView.isHidden = model.rideState != .past
    }
    
    // MARK: - PRIVATE FUNCTIONS
    private func drawDottedLine() {
        let x = self.routeDottedLineView.center.x
        self.routeDottedLineView.drawDottedLine(start: CGPoint(x: x, y: 0), end: CGPoint(x: x, y: self.routeDottedLineView.frame.maxY), color: .lightBlueGrey40Opacity)
    }

}

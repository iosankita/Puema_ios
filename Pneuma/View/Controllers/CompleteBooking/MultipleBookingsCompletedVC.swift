//
//  MultipleBookingsCompletedVC.swift
//  Pneuma
//
//  Created by Jatin on 18/03/21.
//  Copyright © 2021 Jatin. All rights reserved.
//

import UIKit

class MultipleBookingsCompletedVC: UIViewController {

    // MARK: - IBOUTLETS
    @IBOutlet weak var flightView: UIView!
    @IBOutlet weak var logoImageView: UIImageView!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var currencyTypeLabel: UILabel!
    @IBOutlet weak var startDateLabel: UILabel!
    @IBOutlet weak var totalTimeLabel: UILabel!
    @IBOutlet weak var endTimeLabel: UILabel!
    @IBOutlet weak var startingLocationLabel: UILabel!
    @IBOutlet weak var endingLocationLabel: UILabel!
    @IBOutlet weak var flightStopsStackView: UIStackView!
    
    
    @IBOutlet weak var rideView: UIView!
    @IBOutlet weak var rideDateTimeLabel: UILabel!
    @IBOutlet weak var rideOriginLabel: UILabel!
    @IBOutlet weak var rideDestinationLabel: UILabel!
    @IBOutlet weak var ridePriceLabel: UILabel!
    @IBOutlet weak var rideCurrencyLabel: UILabel!
    @IBOutlet weak var ridePaymentInfoLabel: UILabel!
    @IBOutlet weak var rideWayDottedLineView: UIView!
    
    @IBOutlet weak var hotelView: UIView!
    @IBOutlet weak var hotelImageView: UIImageView!
    @IBOutlet weak var hotelNameLabel: UILabel!
    @IBOutlet weak var hotelRatingView: HCSStarRatingView!
    @IBOutlet weak var hotelAmountLabel: UILabel!
    @IBOutlet weak var hotelCurrencyLabel: UILabel!
    @IBOutlet weak var hotelLocationLabel: UILabel!
    @IBOutlet weak var hotelBookingDaysLabel: UILabel!
    
    // MARK: - VARIABLES
    var screentype = BookFlightScreenType.bookFlight
    
    // MARK: - VIEW LIFE CYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupView(model: SearchFlightsDataModel(title: "", imageName: "searchFlightLogo-1"))
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.drawDottedLine()
        if screentype != .planMyTrip {
            self.showCityDiscoverPopup()
        }
    }
    
   
    // MARK: - IBACTIONS
    @IBAction func okButtonAction(_ sender: UIButton) {
        self.gotoHome()
    }
    
    // MARK: - PRIVATE FUNCTIONS
    private func drawDottedLine() {
        
        let rideLineX = self.rideWayDottedLineView.center.x
        self.rideWayDottedLineView.drawDottedLine(start: CGPoint(x: rideLineX, y: 0), end: CGPoint(x: rideLineX, y: self.rideWayDottedLineView.frame.maxY), color: .lightBlueGrey40Opacity)
    }
    
    private func gotoHome() {
        for vc in self.navigationController?.viewControllers ?? [] {
            if vc.isKind(of: HomeVC.self) {
                self.navigationController?.popToViewController(vc, animated: true)
                break
            }
        }
    }
    
    private func showCityDiscoverPopup() {
          let popup: BookingCompleteBottomPopupView = .loadFromNib()
          popup.delegate = self
          popup.roundCorners([.topLeft, .topRight], radius: 20)
          popup.translatesAutoresizingMaskIntoConstraints = false
          self.view.addSubview(popup)
          popup.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
          popup.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
          var topConstraint: NSLayoutConstraint!
          topConstraint = popup.topAnchor.constraint(equalTo: self.view.bottomAnchor, constant: 0)
          topConstraint.isActive = true
          var bottomConstraint: NSLayoutConstraint!
          bottomConstraint = popup.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: 0)
          
          DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
              topConstraint.isActive = false
              bottomConstraint.isActive = true
              UIView.animate(withDuration: 0.8) { [weak self] in
                  self?.view.layoutIfNeeded()
              }
          }
      }
    
    func setupView(model: SearchFlightsDataModel) {
        self.logoImageView.image = model.logo
        self.setupFlightStops(model: model)
    }
    
    private func setupFlightStops(model: SearchFlightsDataModel) {
        for _ in 0..<model.stopsCount {
            let stopView: FlightStopView = .loadFromNib()
            stopView.heightAnchor.constraint(equalToConstant: 15).isActive = true
            self.flightStopsStackView.addArrangedSubview(stopView)
        }
    }
}
// MARK: - BOTTOM POPUP DELEGATE
extension MultipleBookingsCompletedVC: BookingCompleteBottomPopupViewDelegate {
    func view(_ view: BookingCompleteBottomPopupView, didPressOk button: UIButton) {
        let vc = UIStoryboard.loadCityDiscoverVC()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}

//
//  FlightBookingCompletedVC.swift
//  Pneuma
//
//  Created by Jatin on 10/03/21.
//  Copyright © 2021 Jatin. All rights reserved.
//

import UIKit

class FlightBookingCompletedVC: UIViewController {

    // MARK: - IBOUTLETS
    @IBOutlet weak var logoImageView: UIImageView!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var currencyTypeLabel: UILabel!
    @IBOutlet weak var startDateLabel: UILabel!
    @IBOutlet weak var totalTimeLabel: UILabel!
    @IBOutlet weak var endTimeLabel: UILabel!
    @IBOutlet weak var startingLocationLabel: UILabel!
    @IBOutlet weak var endingLocationLabel: UILabel!
    @IBOutlet weak var flightStopsStackView: UIStackView!
    @IBOutlet weak var lblPassengerCount: UILabel!
    @IBOutlet weak var lblClassName: UILabel!
    @IBOutlet weak var containerView: UIView!
    
    // MARK: - VARIABLES
    var viewModel = FlightBookingCompletedVM()
    var popup: BookingCompleteBottomPopupView? = nil
    var createOrderResponse: CreateOrderResponse?
    var objFlightSearchResponseData : FlightSearchResponseData?
    var numberOfAdults : Int?
    var numberOfChildren : Int?
    var numberOfInfants : Int?
    var totalPassangers: Int = 0
    
    // MARK: - VIEW LIFE CYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupView(model: objFlightSearchResponseData ?? FlightSearchResponseData())
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.customizeUI()
        if popup == nil {
            self.showCityDiscoverPopup()
        }
    }
    
    // MARK: - IBACTIONS
    @IBAction func okButtonAction(_ sender: UIButton) {
        self.gotoHome()
    }
    
    // MARK: - PRIVATE FUNCTIONS
    private func gotoHome() {
        for vc in self.navigationController?.viewControllers ?? [] {
            if vc.isKind(of: HomeVC.self) {
                self.navigationController?.popToViewController(vc, animated: true)
                break
            }
        }
    }
    
    private func customizeUI() {
        self.containerView.addShadowWithRoundCorner(radius: 6, color: .paleGreyFour, opacity: 1, offSet: .zero, shadowRadius: 10)
    }
    
    private func setupView(model: FlightSearchResponseData) {
        logoImageView.kf.setImage(with: URL(string: model.flightDict?.flightsList?.first?.airline_logo ?? ""))
        self.priceLabel.text = model.priceTotal
        self.totalTimeLabel.text = model.flightDict?.totalDuration
        self.currencyTypeLabel.text = model.priceCurrency
        self.startDateLabel.text = model.flightDict?.flightsList?.first?.departureDatetime?.getDate()?.getStringFullDate(format: .FlightTime, timeZone: .current)
        self.endTimeLabel.text = model.flightDict?.flightsList?.last?.arrivalDatetime?.getDate()?.getStringFullDate(format: .FlightTime, timeZone: .current)
        self.startingLocationLabel.text = model.flightDict?.flightsList?.first?.departureIataCode
        self.endingLocationLabel.text = model.flightDict?.flightsList?.last?.arrivalIataCode
        self.lblPassengerCount.text = "\(totalPassangers) Passenger"
        self.lblClassName.text = "\(model.flightDict?.flightsList?.first?.cabin?.capitalizingFirstLetter() ?? "") Class"
        self.setupFlightStops(model: model)
    }
    
    private func setupFlightStops(model: FlightSearchResponseData) {
        for view in self.flightStopsStackView.subviews {
            view.removeFromSuperview()
        }
        guard let stop = model.flightDict?.numberOfStops else {
            return
        }
        if stop == 0 {
            for _ in 0..<1 {
                let stopView: FlightStopView = .loadFromNib()
                stopView.heightAnchor.constraint(equalToConstant: 15).isActive = true
                self.flightStopsStackView.addArrangedSubview(stopView)
            }
        }else {
            for _ in 0..<stop {
                let stopView: FlightStopView = .loadFromNib()
                stopView.heightAnchor.constraint(equalToConstant: 15).isActive = true
                self.flightStopsStackView.addArrangedSubview(stopView)
            }
        }
    }
    
    private func showCityDiscoverPopup() {
        popup = .loadFromNib()
        popup?.delegate = self
        popup?.roundCorners([.topLeft, .topRight], radius: 20)
        popup?.translatesAutoresizingMaskIntoConstraints = false
        if let popup = popup {
            self.view.addSubview(popup)
        }
        popup?.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        popup?.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        var topConstraint: NSLayoutConstraint!
        topConstraint = popup?.topAnchor.constraint(equalTo: self.view.bottomAnchor, constant: 0)
        topConstraint.isActive = true
        var bottomConstraint: NSLayoutConstraint!
        bottomConstraint = popup?.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: 0)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            topConstraint.isActive = false
            bottomConstraint.isActive = true
            UIView.animate(withDuration: 0.8) { [weak self] in
                self?.view.layoutIfNeeded()
            }
        }
    }
}

// MARK: - BOTTOM POPUP DELEGATE
extension FlightBookingCompletedVC: BookingCompleteBottomPopupViewDelegate {
    func view(_ view: BookingCompleteBottomPopupView, didPressOk button: UIButton) {
        let vc = UIStoryboard.loadCityDiscoverVC()
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

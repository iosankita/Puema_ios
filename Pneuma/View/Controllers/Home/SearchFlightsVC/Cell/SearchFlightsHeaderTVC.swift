//
//  SearchFlightsTableCell.swift
//  Pneuma
//
//  Created by Jatin on 01/03/21.
//  Copyright © 2021 Jatin. All rights reserved.
//

import UIKit

class SearchFlightsHeaderTVC: UITableViewCell {

    // MARK: - IBOUTLETS
    @IBOutlet weak var logoImageView: UIImageView!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var currencyTypeLabel: UILabel!
    @IBOutlet weak var btnExpand: UIButton!
    @IBOutlet weak var startDateLabel: UILabel!
    @IBOutlet weak var totalTimeLabel: UILabel!
    @IBOutlet weak var endTimeLabel: UILabel!
    @IBOutlet weak var startingLocationLabel: UILabel!
    @IBOutlet weak var endingLocationLabel: UILabel!
    @IBOutlet weak var flightStopsStackView: UIStackView!
    @IBOutlet weak var stopCount: UILabel!
    @IBOutlet weak var imgDrop: UIImageView!
    var actionBlock: ((Int,Bool) -> Void)? = nil
    var model :  SearchResultModel?

    // MARK: - CLASS LIFE CYCLE
    override func prepareForReuse() {
        super.prepareForReuse()
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        btnExpand.setTitle("", for: .normal)
        btnExpand.isHidden = false
    }


    // MARK: - INTERNAL FUNCTIONS
    func setupCell(model: SearchResultModel,isReturn : Bool = false) {
        
        logoImageView.kf.setImage(with: URL(string: "http://pics.avs.io/250/250/\(/model.AirItinerary?.first?.FlightSegment?.first?.MarketingAirline?.Code).png"))
        self.priceLabel.text = "\(model.AirItineraryPricingInfo?.first?.ItinTotalFare?.TotalFare?.Amount ?? 0.0)"
        self.currencyTypeLabel.text = /model.AirItineraryPricingInfo?.first?.ItinTotalFare?.TotalFare?.CurrencyCode
        if isReturn == true{
            setupAirCell(model: model.AirItinerary?.last ?? AirItineraryModel())
        }else {
            setupAirCell(model: model.AirItinerary?.first ?? AirItineraryModel())
        }
    }
    // MARK: - INTERNAL FUNCTIONS
    func setupAirCell(model: AirItineraryModel) {
        
        self.setupFlightStops(model: model.FlightSegment)
       
        let interval: TimeInterval =  TimeInterval(/model.ElapsedTime)
        let date =   interval.stringFromDurationInterval()
        self.totalTimeLabel.text = "\(/date.replacingOccurrences(of: "ago", with: ""))"
        self.startDateLabel.text = model.FlightSegment?.first?.DepartureDateTime?.getDate()?.getStringFullDate(format: .FlightTime, timeZone: .current)
        self.endTimeLabel.text = model.FlightSegment?.last?.ArrivalDateTime?.getDate()?.getStringFullDate(format: .FlightTime, timeZone: .current)
        self.startingLocationLabel.text = /model.FlightSegment?.first?.DepartureDetails?.LocationCode
        self.endingLocationLabel.text = /model.FlightSegment?.last?.ArrivalDetails?.LocationCode
        setupFlightStops(model: model.FlightSegment)
       
    }
    
    
    // MARK: - PRIVATE FUNCTIONS
    private func setupFlightStops(model: [FlightSegment]?, stop : Int? = 0 ) {
        for view in self.flightStopsStackView.subviews {
            view.removeFromSuperview()
        }
      
        guard var stop = model?.count else {
            return
        }
        stopCount.text = stop == 1 ? "Non-Stop" : "\(stop-1)-Stop"
        stop =  stop == 1 ? 0 : stop-1
        if stop == 0 {
            let stopView: FlightStopView = .loadFromNib()
            stopView.plane.isHidden =  stop == 0 ? true : false
            stopView.heightAnchor.constraint(equalToConstant: 15).isActive = true
            self.flightStopsStackView.addArrangedSubview(stopView)

        }else {
            for i in 0..<stop {
                let stopView: FlightStopView = .loadFromNib()
                stopView.heightAnchor.constraint(equalToConstant: 15).isActive = true
                self.flightStopsStackView.addArrangedSubview(stopView)
            }
        }
    }
    
    @IBAction func didTapButton(sender: UIButton) {
        sender.isSelected = !sender.isSelected
        actionBlock?(sender.tag, sender.isSelected)
    }
}

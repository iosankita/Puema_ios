//
//  FlightHeaderTVC.swift
//  Pneuma
//
//  Created by Ankita Thakur on 17/03/23.
//  Copyright © 2023 Kamaljeet Punia. All rights reserved.
//

import UIKit

class FlightHeaderTVC: UITableViewCell {

    // MARK: - IBOUTLETS
    @IBOutlet weak var logoImageView: UIImageView!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var btnExpand: UIButton!
    @IBOutlet weak var startDateLabel: UILabel!
    @IBOutlet weak var totalTimeLabel: UILabel!
    @IBOutlet weak var endTimeLabel: UILabel!
    @IBOutlet weak var startingLocationLabel: UILabel!
    @IBOutlet weak var endingLocationLabel: UILabel!
    @IBOutlet weak var stopCount: UILabel!
    @IBOutlet weak var lblKg: UILabel!
    @IBOutlet weak var currencyName: UILabel!
    @IBOutlet weak var emmisionsLabel: UILabel!
    @IBOutlet weak var lblStopLocation: UILabel!
    // MARK: - Variable
    var actionBlock: ((Int,Bool) -> Void)? = nil
    var model :  SearchResultModel?

    
    // MARK: - INTERNAL FUNCTIONS
  
    func setupCell(model: SearchResultModel) {
        
        logoImageView.kf.setImage(with: URL(string: "http://pics.avs.io/50/50/\(/model.AirItinerary?.first?.FlightSegment?.first?.MarketingAirline?.Code).png"))
        self.priceLabel.text = "\(model.AirItineraryPricingInfo?.first?.ItinTotalFare?.TotalFare?.Amount ?? 0.0) \(/model.AirItineraryPricingInfo?.first?.ItinTotalFare?.TotalFare?.CurrencyCode)"
      
    }
    
    func setupCell(model: AirItineraryModel) {
      
        let time = model.FlightSegment?.first?.DepartureDateTime?.getDate()?.offsetFrom(model.FlightSegment?.last?.ArrivalDateTime?.getDate())
        self.totalTimeLabel.text = "\(/time?.replacingOccurrences(of: "ago", with: ""))"
        self.startDateLabel.text = model.FlightSegment?.first?.DepartureDateTime?.getDate()?.getStringFullDate(format: .FlightTime, timeZone: .current)
        self.endTimeLabel.text = model.FlightSegment?.last?.ArrivalDateTime?.getDate()?.getStringFullDate(format: .FlightTime, timeZone: .current)
        self.startingLocationLabel.text = /model.FlightSegment?.first?.DepartureDetails?.LocationCode
        self.endingLocationLabel.text = /model.FlightSegment?.last?.ArrivalDetails?.LocationCode
        self.stopCount.text = "\(/model.FlightSegment?.count)"
        
    }
    
    
}

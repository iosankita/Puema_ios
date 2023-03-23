//
//  SearchFlightsTableCell.swift
//  Pneuma
//
//  Created by Jatin on 01/03/21.
//  Copyright © 2021 Jatin. All rights reserved.
//

import UIKit

class SearchFlightsDetailsTVC: UITableViewCell {

    // MARK: - IBOUTLETS
    @IBOutlet weak var lblOrigin: UILabel!
    @IBOutlet weak var lblArrival: UILabel!
    @IBOutlet weak var lblStartTime: UILabel!
    @IBOutlet weak var lblEndTime: UILabel!
    @IBOutlet weak var lblTravelTime: UILabel!
    @IBOutlet weak var lblLaover: UILabel!
    @IBOutlet var lblInformation: [UILabel]!
    @IBOutlet  var vwInformation: [UIView]!
    @IBOutlet weak var vwStack: UIStackView!
    var objSearchFlightsVM = SearchFlightsVM()
    var actionBlock: ((Int) -> Void)? = nil
    var model :  SearchResultModel?
    @IBOutlet weak var dottedLineView: UIView!
    // MARK: - CLASS LIFE CYCLE
    override func prepareForReuse() {
        super.prepareForReuse()
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        drawDottedLine()
     
    }
    private func drawDottedLine() {
 
        let x = self.dottedLineView.center.x
        self.dottedLineView.drawDottedLine(start: CGPoint(x: x, y: 0), end: CGPoint(x: x, y: self.dottedLineView.frame.maxY), color: .lightBlueGrey40Opacity)
    }
    func handleData(_ model : FlightSegment?, isReturn : Bool = false, searchResult: SearchResultModel?){
        let interval: TimeInterval =  TimeInterval(/model?.ElapsedTime)
        let time =   interval.stringFromDurationInterval()
        let startDate  = model?.DepartureDateTime?.getDate()?.getStringFullDate(format: .FlightTime, timeZone: .current)
        let endDate = model?.ArrivalDateTime?.getDate()?.getStringFullDate(format: .FlightTime, timeZone: .current)
        let objname =  objSearchFlightsVM.tableDataSource.arrSearchCityData.filter({ $0.AirportCode == model?.DepartureDetails?.LocationCode ?? "" }).first
        lblTravelTime.text = "Travel Time: \(/time)"
        let arrivalName =  objSearchFlightsVM.tableDataSource.arrSearchCityData.filter({ $0.AirportCode == model?.ArrivalDetails?.LocationCode ?? ""  }).first
        lblOrigin.text =  "\(objname?.AirportName ?? "") "
        lblArrival.text = "\(arrivalName?.AirportName ?? "")"
        lblStartTime.text = startDate
        lblEndTime.text = endDate
        let code =  model?.ArrivalDetails?.LocationCode ?? ""
        lblLaover.text = "\(/time) Layover .\(code) "
        let objAirline =  objSearchFlightsVM.tableDataSource.arrAirlineInfoModel?.filter({ $0.AirlineCode == model?.MarketingAirline?.Code ?? "" }).first
        lblInformation[0].text = "\(/objAirline?.AirlineName) . \(/model?.MarketingAirline?.Code)\(/model?.FlightNumber?.value)"
       
        let type = model?.OtherDetails?.CabinType?.capitalized == SeatTitle.S.rawValue ? SeatTitle.S.title : model?.OtherDetails?.CabinType?.capitalized == SeatTitle.C.rawValue ? SeatTitle.C.title : /model?.OtherDetails?.CabinType?.capitalized == SeatTitle.F.rawValue ? SeatTitle.F.title : SeatTitle.Y.title
        lblInformation[1].text = "\(type)"
        lblInformation[2].text =  searchResult?.AirItineraryPricingInfo?.first?.IsRefundable ==  true  ? "Refundable": "Non-Refundable"
        lblInformation[2].textColor = searchResult?.AirItineraryPricingInfo?.first?.IsRefundable ==  true ? .green : .red
        lblInformation[3].text = "\(searchResult?.AirItineraryPricingInfo?.first?.FareBreakdown?.first?.BaggageInfo?.first ?? "") (per person carriage)"

    }
}

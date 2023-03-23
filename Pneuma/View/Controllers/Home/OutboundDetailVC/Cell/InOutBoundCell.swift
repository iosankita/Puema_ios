//
//  InOutBoundCell.swift
//  Pneuma
//
//  Created by Infinity S on 12/01/22.
//  Copyright © 2022 Jatin. All rights reserved.
//

import UIKit

class InOutBoundCell: UICollectionViewCell {

    @IBOutlet weak var viewBG: UIView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var viewOriginDetail: UIView!
    @IBOutlet weak var viewOriginInnerDetail: UIView!
    @IBOutlet weak var lblOriginAirpotName: UILabel!
    @IBOutlet weak var lblAirpotShortName: UILabel!
    @IBOutlet weak var lblDepartureTime: UILabel!
    @IBOutlet weak var viewDestinationDetail: UIView!
    @IBOutlet weak var viewDestinationInnerDetail: UIView!
    @IBOutlet weak var lblDestinationAirpotName: UILabel!
    @IBOutlet weak var lblDestinationAirpotShortName: UILabel!
    @IBOutlet weak var lblArrivalTime: UILabel!

    var flightData: FlightDict?
    var flightSegmentData:AirItineraryModel? //[FlightSegment]?
    var returnFlightData: ReturnFlightDict?
    var returnAirItineraryModel: AirItineraryModel?
    var isFromRoundTrip : Bool = false
    var objModel = OutboundDetailVM()
    var title :String = ""
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code

     
        self.tableView.register(UINib(nibName: "SearchFlightsDetailsTVC", bundle: nil), forCellReuseIdentifier: "SearchFlightsDetailsTVC")
        self.tableView.delegate = self
        self.tableView.dataSource = self
    }

    func setUpData(_ item:Any?) {
       if let data = item as? AirItineraryModel {
            returnAirItineraryModel = data
            let objname =  objModel.tableDataSource.arrSearchCityData.filter({ $0.AirportCode == data.FlightSegment?.first?.DepartureDetails?.LocationCode ?? "" }).first
        
                let arrivalName =  objModel.tableDataSource.arrSearchCityData.filter({ $0.AirportCode == data.FlightSegment?.last?.ArrivalDetails?.LocationCode ?? "" }).first
            
           lblDestinationAirpotName.text = arrivalName?.AirportName
            lblOriginAirpotName.text = objname?.AirportName
            
            lblAirpotShortName.text = data.FlightSegment?.first?.DepartureDetails?.LocationCode
            lblDestinationAirpotShortName.text = data.FlightSegment?.last?.ArrivalDetails?.LocationCode
            lblDepartureTime.text = "Departure : \(data.FlightSegment?.first?.DepartureDateTime?.getDate()?.getStringFullDate(format: .boundFlightTime, timeZone: .current) ?? "")"
            lblArrivalTime.text = "Arrival : \(data.FlightSegment?.last?.ArrivalDateTime?.getDate()?.getStringFullDate(format: .boundFlightTime, timeZone: .current) ?? "")"
            isFromRoundTrip = false
            flightSegmentData = data
            
            self.tableView.reloadData()
        }
    }

    func setUpData2(_ item:Any?) {
        if let data = item as? AirItineraryModel {
            let objname =  objModel.tableDataSource.arrSearchCityData.filter({ $0.AirportCode == data.FlightSegment?.first?.DepartureDetails?.LocationCode ?? "" }).first
            lblOriginAirpotName.text = objname?.AirportName ?? ""
            lblAirpotShortName.text = data.FlightSegment?.first?.DepartureDetails?.LocationCode
            let arrivalName =  objModel.tableDataSource.arrSearchCityData.filter({ $0.AirportCode == data.FlightSegment?.first?.ArrivalDetails?.LocationCode ?? "" }).first
            
            lblDestinationAirpotName.text = arrivalName?.AirportName
            
            //data.FlightSegment?.last?.ArrivalDetails?.LocationName
            lblDestinationAirpotShortName.text = data.FlightSegment?.last?.ArrivalDetails?.LocationCode
            lblDepartureTime.text = "Departure : \(data.FlightSegment?.first?.DepartureDateTime?.getDate()?.getStringFullDate(format: .boundFlightTime, timeZone: .current) ?? "")"
            lblArrivalTime.text = "Arrival : \(data.FlightSegment?.last?.ArrivalDateTime?.getDate()?.getStringFullDate(format: .boundFlightTime, timeZone: .current) ?? "")"
            isFromRoundTrip = true
            returnAirItineraryModel = data
           self.tableView.reloadData()
        }
    }
}

extension InOutBoundCell: UITableViewDataSource, UITableViewDelegate {

    func numberOfSections(in tableView: UITableView) -> Int {
//        if isFromRoundTrip == true {
//            return  returnAirItineraryModel?.FlightSegment?.count ?? 0
//        }else {
//            return flightSegmentData?.FlightSegment?.count ?? 0
//        }
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isFromRoundTrip == true {
            return returnAirItineraryModel?.FlightSegment?.count ?? 0
        }else {
            return flightSegmentData?.FlightSegment?.count  ?? 0
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell : SearchFlightsDetailsTVC = tableView.dequeueReusableCell(withIdentifier: "SearchFlightsDetailsTVC") as? SearchFlightsDetailsTVC else {
            return UITableViewCell()
        }
        if isFromRoundTrip == true {
           
            cell.objSearchFlightsVM.tableDataSource.arrSearchCityData = objModel.tableDataSource.arrSearchCityData
            cell.objSearchFlightsVM.tableDataSource.arrAirlineInfoModel = objModel.tableDataSource.airlineModel
            cell.handleData(returnAirItineraryModel?.FlightSegment?[indexPath.row], searchResult: objSelectedFlightData?.last ?? SearchResultModel())
        }else {
            cell.objSearchFlightsVM.tableDataSource.arrSearchCityData = objModel.tableDataSource.arrSearchCityData
            cell.objSearchFlightsVM.tableDataSource.arrAirlineInfoModel = objModel.tableDataSource.airlineModel
            cell.handleData(flightSegmentData?.FlightSegment?[indexPath.row], searchResult: objSelectedFlightData?.first)
        }
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}

//
//  SearchFlightsVC+TableDataSource.swift
//  Pneuma
//
//  Created by Jatin on 01/03/21.
//  Copyright © 2021 Jatin. All rights reserved.
//

import UIKit

class SearchFlightsTableDataSource: SearchFlightsTableDataSourceModel, UITableViewDataSource {
    
    // MARK: - VARIABLES
    private let cellIdentifier = "SearchFlightsDetailsTVC"
    var actionBlock: ((_ code:String?) -> Void)? = nil
    // MARK: - TABLE DATA SOURCE
  
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if /self.listArray2.count != 0 &&  self.selectSection == section{
            return self.isReturn == true ? self.listArray2[section].AirItinerary?.last?.FlightSegment?.count ?? 0 : self.listArray2[section].AirItinerary?.first?.FlightSegment?.count ?? 0
        }else {
            return 0
        }
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.listArray2.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: self.cellIdentifier) as! SearchFlightsDetailsTVC
        cell.objSearchFlightsVM.tableDataSource.arrSearchCityData = self.arrSearchCityData
        cell.objSearchFlightsVM.tableDataSource.arrAirlineInfoModel = self.arrAirlineInfoModel
        cell.vwInformation[0].isHidden = /self.listArray2[indexPath.section].AirItinerary?.first?.FlightSegment?.count == 1 ? true : false
        if self.isReturn == true {
            cell.handleData(self.listArray2[indexPath.section].AirItinerary?.first?.FlightSegment?[indexPath.row], searchResult: self.listArray2[indexPath.section])
        }else {
            cell.handleData(self.listArray2[indexPath.section].AirItinerary?.first?.FlightSegment?[indexPath.row], searchResult: self.listArray2[indexPath.section])
        }
       
        return cell
    }
   
    func appendLocationNameTitle(arr : [FlightSegment])-> String{
        var keyStr = String()
        var parentTitle = String()
        for i in 0 ..< arr.count  {
            keyStr = "\(/arr[i].DepartureDetails?.LocationCode)"
            if !parentTitle.contains(keyStr){
                parentTitle = parentTitle.count > 0 ? "\(parentTitle),\(keyStr)" :  "\(keyStr)"
            }
        }
        for i in 0 ..< arr.count  {
            keyStr = "\(/arr[i].ArrivalDetails?.LocationCode)"
            if !parentTitle.contains(keyStr){
                parentTitle = parentTitle.count > 0 ? "\(parentTitle),\(keyStr)" :  "\(keyStr)"
            }
        }
        return parentTitle
    }
}

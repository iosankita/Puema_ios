//
//  SearchFlightsVC+TableDelegate.swift
//  Pneuma
//
//  Created by Jatin on 01/03/21.
//  Copyright © 2021 Jatin. All rights reserved.
//

import UIKit
var objSelectedFlightData : [SearchResultModel]?
extension SearchFlightsVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
       
        return  self.viewModel.tableDataSource.selectSection == indexPath.section ? UITableView.automaticDimension : 0
    }
   
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        guard let cell : SearchFlightsHeaderTVC = tableView.dequeueReusableCell(withIdentifier: "SearchFlightsHeaderTVC") as? SearchFlightsHeaderTVC else {
            return UITableViewCell()
        }
        cell.setupCell(model: self.viewModel.tableDataSource.listArray2[section],isReturn: self.viewModel.tableDataSource.isReturn)
        if self.viewModel.tableDataSource.selectSection == section {
            cell.imgDrop.rotate(degrees: 180)
            cell.btnExpand.isSelected = true
            
        }else {
            cell.imgDrop.rotate(degrees: 0)
            cell.btnExpand.isSelected = false
        }
        cell.btnExpand.tag =  section
        cell.actionBlock = { index, selected in
            if selected {
                self.viewModel.tableDataSource.selectSection = index
                cell.imgDrop.rotate(degrees: 180)
                cell.btnExpand.isSelected = true
                let code =  self.appendLocationNameTitle(arr: self.viewModel.tableDataSource.listArray2[section].AirItinerary?.first?.FlightSegment ?? [])
                self.getSearchName(code, tableView) { result in
                    tableView.reloadData()
                }
                self.handleAirlineInfo( self.appendParamTitle(arr: self.viewModel.tableDataSource.listArray2[section].AirItinerary?.first?.FlightSegment ?? []))
            }else {
                cell.btnExpand.isSelected = false
                self.viewModel.tableDataSource.selectSection = -1
                cell.imgDrop.rotate(degrees: 0)
                tableView.reloadData()
            }
        }
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.handleTap(_:)))
        tap.view?.tag = section
        tap.numberOfTapsRequired = 1
       
        cell.contentView.tag = section
        cell.contentView.addGestureRecognizer(tap)
        return cell
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 190
    }
    @objc func handleTap(_ sender: UITapGestureRecognizer) {
     
        guard let index = sender.view?.tag else { return }
            print("getTag == \(index)")
        if viewModel.tableDataSource.isRoundTrip {
            if self.viewModel.tableDataSource.isReturn == true{
                if  objSelectedFlightData?.count == 2 {
                    objSelectedFlightData?.removeLast()
                }
                objSelectedFlightData?.append(self.viewModel.tableDataSource.listArray2[index])
                let vc = UIStoryboard.loadOutboundDetailVC()
                vc.title = Flight
                vc.numberOfBookSeat = self.totalPassangers
                vc.numberOfAdults = self.numberOfAdults
                vc.numberOfChildren = self.numberOfChildren
                vc.numberOfInfants = self.numberOfInfants
                self.navigationController?.pushViewController(vc, animated: true)
            }else{
                objSelectedFlightData = []
                objSelectedFlightData?.append(self.viewModel.tableDataSource.listArray2[index])
                 btnDropDown.setTitle("Returning Flights", for: .normal)
                self.viewModel.tableDataSource.isReturn = true
                self.viewModel.tableDataSource.isRoundTrip = true
                self.viewModel.tableDataSource.selectSection = -1
                tableView.reloadData()
            }
        } else {
            objSelectedFlightData = []
            objSelectedFlightData?.append(self.viewModel.tableDataSource.listArray2[index])
            self.viewModel.tableDataSource.selectSection = -1
            tableView.reloadData()
            let vc = UIStoryboard.loadOutboundDetailVC()
            vc.title = Flight
            vc.numberOfBookSeat = self.totalPassangers
            vc.numberOfAdults = self.numberOfAdults
            vc.numberOfChildren = self.numberOfChildren
            vc.numberOfInfants = self.numberOfInfants
            self.navigationController?.pushViewController(vc, animated: true)
            
        }
    }

   
    func handleAirlineInfo(_ code : String?){
                if code != "" {
                    viewModel.getAirlineDetails(code: code ?? ""){ result in
                        switch result {
                        case .success(_):
                            DispatchQueue.main.async {
                                self.tableView.reloadData()
                            }
                            break
                        case .failure(let error):
                            print(error)
                            break
                        }
                    }
                }
    }
    func getSearchName( _ name : String, _ tableView : UITableView? ,_ completion: @escaping (_ result:Bool) -> Void){
        self.viewModel.getSearchAirportName(search: name ?? ""){ result in
            switch result {
            case .success(_):
//                DispatchQueue.main.async {
//                    tableView?.reloadData()
//                }
                completion(true)
                break
            case .failure(let error):
                print(error)
                break
            }
        }
    }
}
class DictionaryEncoder {
    private let jsonEncoder = JSONEncoder()

    /// Encodes given Encodable value into an array or dictionary
    func encode<T>(_ value: T) throws -> Any where T: Encodable {
        let jsonData = try jsonEncoder.encode(value)
        return try JSONSerialization.jsonObject(with: jsonData, options: .allowFragments)
    }
}

class DictionaryDecoder {
    private let jsonDecoder = JSONDecoder()

    /// Decodes given Decodable type from given array or dictionary
    func decode<T>(_ type: T.Type, from json: Any) throws -> T where T: Decodable {
        let jsonData = try JSONSerialization.data(withJSONObject: json, options: [])
        return try jsonDecoder.decode(type, from: jsonData)
    }
}

extension UIView {


    func rotate(degrees: CGFloat) {

        let degreesToRadians: (CGFloat) -> CGFloat = { (degrees: CGFloat) in
            return degrees / 180.0 * CGFloat.pi
        }
        self.transform =  CGAffineTransform(rotationAngle: degreesToRadians(degrees))

        // If you like to use layer you can uncomment the following line
        //layer.transform = CATransform3DMakeRotation(degreesToRadians(degrees), 0.0, 0.0, 1.0)
    }
}
extension UIViewController{
    func appendParamTitle(arr : [FlightSegment])-> String{
        var keyStr = String()
        var parentTitle = String()
        for i in 0 ..< arr.count  {
            keyStr = "\(/arr[i].MarketingAirline?.Code)"
            if !parentTitle.contains(keyStr){
                parentTitle = parentTitle.count > 0 ? "\(parentTitle), \(keyStr)" :  "\(keyStr)"
            }
        }
        
        return parentTitle
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

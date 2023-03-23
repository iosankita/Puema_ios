//
//  AskAnnieVC+TableViewDelegate.swift
//  Pneuma
//
//  Created by MacBook Pro on 13/11/21.
//  Copyright © 2021 Jatin. All rights reserved.
//

import UIKit

extension AskAnnieVC: UITableViewDelegate, AlertProtocol {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let model = self.viewModel.tableDataSource.listArray[indexPath.row]
        if model.isFrom == .BOOK { //Multiple scenario check
            print("BOOK")
            //call detail data from here
            switch self.reservationTypeAnnie {
            case .flight:
                CustomLoader.shared.show()
                print(self.annieSearchParams)
                let params = ["id":self.annieSearchParams.flight_id ?? "", "origin":self.annieSearchParams.originLocation ?? "", "destination":self.annieSearchParams.destinationLocation ?? "", "departure_date":self.annieSearchParams.departureDate ?? ""]
                self.viewModel.apiServices.searchFlightAnnie(params) {result in
                    CustomLoader.shared.hide()
                    switch result {
                    case .success(let response):
                        print(response)
                        guard let data = response.resultData as? Data else {
                            return
                        }
                        if let model: FlightSearchAnnieResponse? = JSONDecoder().convertDataToModel(data) {
                            if let data = model?.data {
                                let vc = UIStoryboard.loadOutboundDetailVC()
                                vc.objFlightSearchResponseData = data
                                vc.numberOfBookSeat = 1
                                vc.numberOfAdults = 1
                                vc.numberOfChildren = 0
                                vc.numberOfInfants = 0
                                self.navigationController?.pushViewController(vc, animated: true)
                            }
                        }
                        return
                    case .failure(let error):
                        print(error)
                        return
                    }
                }
                break
            case .hotel:
                print("Book Hotel")
                self.showAlertWithText("Hotel booking under meinatainace service.")
                CustomLoader.shared.show()
                print(self.annieSearchParams)
                let params = ["hotel_code":self.annieHotelSearchParams.hotel_code ?? "", "location":self.annieHotelSearchParams.location ?? "", "checkin_date":self.annieHotelSearchParams.checkin_date ?? "", "checkout_date":self.annieHotelSearchParams.checkout_date ?? ""]
//                              , "number_of_rooms":self.annieHotelSearchParams.number_of_rooms ?? "", "adults":self.annieHotelSearchParams.adults ?? ""]
                self.viewModel.apiServices.searchHotelAnnie(params) { result in
                    CustomLoader.shared.hide()
                    switch result {
                    case .success(let response):
                        print(response)
                        guard let data = response.resultData as? Data else {
                            return
                        }
                        if let json = try! JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                            // try to read out a dictionary
                            print(json)
                        }
                        if let model: FlightSearchAnnieResponse? = JSONDecoder().convertDataToModel(data) {
                            if let data = model?.data {
                                let vc = UIStoryboard.loadOutboundDetailVC()
                                vc.objFlightSearchResponseData = data
                                vc.numberOfBookSeat = 1
                                vc.numberOfAdults = 1
                                vc.numberOfChildren = 0
                                vc.numberOfInfants = 0
                                self.navigationController?.pushViewController(vc, animated: true)
                            }
                        }
                        return
                    case .failure(let error):
                        print(error)
                        return
                    }
                }
                break
            case .ride:
                print("Book Ride")
                self.showAlertWithText("Ride booking under meinatainace service")
                break
            }

        }
    }
}

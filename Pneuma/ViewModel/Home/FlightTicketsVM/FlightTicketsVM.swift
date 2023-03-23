//
//  FlightTicketsVM.swift
//  Pneuma
//
//  Created by Jatin on 12/03/21.
//  Copyright © 2021 Jatin. All rights reserved.
//

import Foundation

class FlightTicketsVM: NSObject {
    
    // MARK: - VARIABLES
    let tableDataSource = FlightTicketsTableDataSource()
    var apiServices: FlightApiServices
    var responseModel: GetFlightBookingsDetail?
    
    // MARK: - INITIALIZER
    override init() {
        self.apiServices = FlightApiServices()
        self.responseModel = GetFlightBookingsDetail()
        super.init()
    }
    
    func getList(completion: @escaping ApiResponseCompletion) {
        self.apiServices.getAllFlightBookings { (result) in
            switch result {
            case .success(let response):
                guard let data = response.resultData as? Data else {
                    completion(.failure(ApiResponseErrorBlock(message: LocalizedStringEnum.somethingWentWrong.localized)))
                    return
                }
                let model: GetFlightBookingsDetail? = JSONDecoder().convertDataToModel(data)
                self.responseModel = model
                if let model = self.responseModel , let array = model.data  {
                    self.tableDataSource.listArray = array
                }
                completion(.success(response))
            case .failure(let error):
                ///Handle failure response
                completion(.failure(error))
            }
        }
    }
    
    func getUpcomingFlightBooking(completion: @escaping ApiResponseCompletion){
        self.apiServices.getUpcomingFlightBooking { (result) in
            switch result {
            case .success(let response):
                guard let data = response.resultData as? Data else {
                    completion(.failure(ApiResponseErrorBlock(message: LocalizedStringEnum.somethingWentWrong.localized)))
                    return
                }
                let model: GetFlightBookingsDetail? = JSONDecoder().convertDataToModel(data)
                self.responseModel = model
                if let model = self.responseModel , let array = model.data  {
                    self.tableDataSource.listArray = array
                }
                completion(.success(response))
            case .failure(let error):
                ///Handle failure response
                completion(.failure(error))
            }
        }
    }
    
    func getPastFlightBooking(completion: @escaping ApiResponseCompletion){
        self.apiServices.getPastFlightBookings { (result) in
            switch result {
            case .success(let response):
                guard let data = response.resultData as? Data else {
                    completion(.failure(ApiResponseErrorBlock(message: LocalizedStringEnum.somethingWentWrong.localized)))
                    return
                }
                let model: GetFlightBookingsDetail? = JSONDecoder().convertDataToModel(data)
                self.responseModel = model
                if let model = self.responseModel , let array = model.data  {
                    self.tableDataSource.listArray = array
                }
                completion(.success(response))
            case .failure(let error):
                ///Handle failure response
                completion(.failure(error))
            }
        }
    }
}


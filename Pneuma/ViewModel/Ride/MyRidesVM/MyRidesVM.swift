//
//  MyRidesVM.swift
//  Pneuma
//
//  Created by Jatin on 16/03/21.
//  Copyright © 2021 Jatin. All rights reserved.
//

import Foundation

class MyRidesVM: NSObject {
    
    // MARK: - VARIABLES
    let tableDataSource = MyRidesTableDataSource()
    var apiServices: RideApiServices
    var responseModel: GetRideBookingsResponseModel?
    
    // MARK: - INITIALIZER
    override init() {
        self.apiServices = RideApiServices()
        self.responseModel = GetRideBookingsResponseModel()
        super.init()
    }
    
    func getList(completion: @escaping ApiResponseCompletion) {
        self.apiServices.getAllRideBookings { (result) in
            switch result {
            case .success(let response):
                guard let data = response.resultData as? Data else {
                    completion(.failure(ApiResponseErrorBlock(message: LocalizedStringEnum.somethingWentWrong.localized)))
                    return
                }
                let model: GetRideBookingsResponseModel? = JSONDecoder().convertDataToModel(data)
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
    
    func getUpcomingRide(completion: @escaping ApiResponseCompletion) {
        self.apiServices.getUpcomingRideBooking{ (result) in
            switch result {
            case .success(let response):
                guard let data = response.resultData as? Data else {
                    completion(.failure(ApiResponseErrorBlock(message: LocalizedStringEnum.somethingWentWrong.localized)))
                    return
                }
                let model: GetRideBookingsResponseModel? = JSONDecoder().convertDataToModel(data)
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
    
    func getPastRide(completion: @escaping ApiResponseCompletion) {
        self.apiServices.getPastRideBookings{ (result) in
            switch result {
            case .success(let response):
                guard let data = response.resultData as? Data else {
                    completion(.failure(ApiResponseErrorBlock(message: LocalizedStringEnum.somethingWentWrong.localized)))
                    return
                }
                let model: GetRideBookingsResponseModel? = JSONDecoder().convertDataToModel(data)
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


//
//  HotelBookingsVM.swift
//  Pneuma
//
//  Created by Jatin on 11/03/21.
//  Copyright © 2021 Jatin. All rights reserved.
//

import Foundation

class HotelBookingsVM: NSObject {
    
    // MARK: - VARIABLES
    let tableDataSource = HotelBookingsTableDataSource()
    var apiServices: HotelApiServices
    var responseModel: GetHotelBookingsResponseModel?
    
    // MARK: - INITIALIZER
    override init() {
        self.apiServices = HotelApiServices()
        self.responseModel = GetHotelBookingsResponseModel()
        super.init()
    }
    
    func getList(completion: @escaping ApiResponseCompletion) {
        self.apiServices.getAllHotelBookings { (result) in
            switch result {
            case .success(let response):
                guard let data = response.resultData as? Data else {
                    completion(.failure(ApiResponseErrorBlock(message: LocalizedStringEnum.somethingWentWrong.localized)))
                    return
                }
                let model: GetHotelBookingsResponseModel? = JSONDecoder().convertDataToModel(data)
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
    
    func getUpcomingHotel(completion: @escaping ApiResponseCompletion){
        self.apiServices.getUpcomingHotelBooking{ (result) in
            switch result {
            case .success(let response):
                guard let data = response.resultData as? Data else {
                    completion(.failure(ApiResponseErrorBlock(message: LocalizedStringEnum.somethingWentWrong.localized)))
                    return
                }
                let model: GetHotelBookingsResponseModel? = JSONDecoder().convertDataToModel(data)
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
    
    func getPastHotel(completion: @escaping ApiResponseCompletion){
        self.apiServices.getPastHotelBookings { (result) in
            switch result {
            case .success(let response):
                guard let data = response.resultData as? Data else {
                    completion(.failure(ApiResponseErrorBlock(message: LocalizedStringEnum.somethingWentWrong.localized)))
                    return
                }
                let model: GetHotelBookingsResponseModel? = JSONDecoder().convertDataToModel(data)
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


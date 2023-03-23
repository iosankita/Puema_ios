//
//  MyTripsVM.swift
//  Pneuma
//
//  Created by Chitra on 10/03/21.
//  Copyright © 2021 Jatin. All rights reserved.
//

import Foundation
class MyTripsVM: NSObject {
    
    // MARK: - VARIABLES
    let tableDataSource = MyTripsDataSource()
    var apiServices: FlightApiServices
    var responseModel: MyTripsResponseModel?
    
    // MARK: - INITIALIZER
    override init() {
     
        self.apiServices = FlightApiServices()
        self.responseModel = MyTripsResponseModel()
        super.init()
    }
    

    
    // MARK: - PRIVATE FUNCTIONS
    func getList(completion: @escaping ApiResponseCompletion) {
        self.apiServices.getAllFlightBookings { (result) in
            switch result {
            case .success(let response):
                guard let data = response.resultData as? Data else {
                    completion(.failure(ApiResponseErrorBlock(message: LocalizedStringEnum.somethingWentWrong.localized)))
                    return
                }
                let model: MyTripsResponseModel? = JSONDecoder().convertDataToModel(data)
                self.responseModel = model
                if let model = self.responseModel , let array = model.data  {
                    self.tableDataSource.listArray = array
                    
                }
                completion(.success(response))
                
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
}

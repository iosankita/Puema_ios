//
//  BookRideVM.swift
//  Pneuma
//
//  Created by MacBook Pro on 25/10/21.
//  Copyright © 2021 Jatin. All rights reserved.
//

import Foundation

class BookRideVM: NSObject {
    
    // MARK: - VARIABLES
    var requestModel: RideBookRequestModel
    var apiServices: RideApiServices
    var responseModel: RideBookResponseModel?
    
    // MARK: - INITIALIZER
    override init() {
        self.apiServices = RideApiServices()
        self.requestModel = RideBookRequestModel()
        self.responseModel = RideBookResponseModel()
        super.init()
    }
    
    
    func bookRide(completion: @escaping ApiResponseCompletion) {
        ///Converting Codable type model to dictionary
      let params: [String: Any] = JSONEncoder().convertToDictionary(self.requestModel) ?? [:]
        
        ///Calling api service method
        self.apiServices.book(params) { (result) in
            switch result {
            case .success(let response):
                guard let data = response.resultData as? Data else {
                    completion(.failure(ApiResponseErrorBlock(message: LocalizedStringEnum.somethingWentWrong.localized)))
                    return
                }
                let model: RideBookResponseModel? = JSONDecoder().convertDataToModel(data)
                self.responseModel = model
                completion(.success(response))
            case .failure(let error):
                ///Handle failure response
                completion(.failure(error))
            }
        }
    }
    
    ///Validating the data that all the api parameters are completed or not.
    func validation() -> String? {
        return nil
    }
}

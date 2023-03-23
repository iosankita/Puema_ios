//
//  BookHotelVM.swift
//  Pneuma
//
//  Created by MacBook Pro on 25/10/21.
//  Copyright © 2021 Jatin. All rights reserved.
//

import Foundation

class BookHotelVM: NSObject {
    
    // MARK: - VARIABLES
    var requestModel: HotelBookRequestModel
    var apiServices: HotelApiServices
    var responseModel: HotelBookResponseModel?
    
    // MARK: - INITIALIZER
    override init() {
        self.apiServices = HotelApiServices()
        self.requestModel = HotelBookRequestModel()
        self.responseModel = HotelBookResponseModel()
        super.init()
    }
    
    
    func bookHotel(completion: @escaping ApiResponseCompletion) {
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
                let model: HotelBookResponseModel? = JSONDecoder().convertDataToModel(data)
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

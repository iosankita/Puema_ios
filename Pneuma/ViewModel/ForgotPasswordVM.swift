//
//  ForgotPasswordVM.swift
//  Pneuma
//
//  Created by iTechnolabs on 19/03/21.
//  Copyright © 2021 Jatin. All rights reserved.
//

import Foundation

class ForgotPasswordVM: NSObject {
    
    // MARK: - VARIABLES
    var apiServices: AuthApiServices
    var responseModel: ForgotPasswordResponseModel?
    var requestModel: ForgotPasswordRequestModel?

    // MARK: - CLASS LIFE CYCLE
    override init() {
         self.apiServices = AuthApiServices()
         self.requestModel = ForgotPasswordRequestModel()
         self.responseModel = ForgotPasswordResponseModel()
         super.init()
    }
    
    // MARK: - CUSTOM FUNCTIONS
    func forgotPassword(completion: @escaping ApiResponseCompletion) {
        
        ///Converting Codable type model to dictionary
        let params: [String: Any] = JSONEncoder().convertToDictionary(self.requestModel) ?? [:]
        
        ///Calling api service method
        self.apiServices.forgotPassword(params) { (result) in
            switch result {
            case .success(let response):
                guard let data = response.resultData as? Data else {
                    completion(.failure(ApiResponseErrorBlock(message: LocalizedStringEnum.somethingWentWrong.localized)))
                    return
                }
                
                self.responseModel = JSONDecoder().convertDataToModel(data)
                completion(.success(response))
            case .failure(let error):
                ///Handle failure response
                completion(.failure(error))
            }
        }
    }
    
    ///Validating the data that all the api parameters are completed or not.
    func validation() -> String? {
        if self.requestModel?.email?.isEmptyWithTrimmedSpace ?? true {
            return LocalizedStringEnum.enterEmailAddress.localized
        }
        if !(self.requestModel?.email?.isValidEmail() ?? false){
            return LocalizedStringEnum.enterValidEmailAddress.localized
        }
        return nil
    }
    
}

//
//  LoginVM.swift
//  Pneuma
//
//  Created by Chitra on 24/02/21.
//  Copyright © 2021 iTechnolabs. All rights reserved.
//

import Foundation

class LoginVM: NSObject {
    
    // MARK: - VARIABLES
     var requestModel: LoginRequestModel
     var apiServices: AuthApiServices
     var responseModel: LoginResponseModel?
    
    // MARK: - CLASS LIFE CYCLE
    override init() {
        self.apiServices = AuthApiServices()
        self.requestModel = LoginRequestModel()
        self.responseModel = LoginResponseModel()
        super.init()
    }
    
    // MARK: - CUSTOM FUNCTIONS
    ///login api call
    func login(completion: @escaping ApiResponseCompletion) {
        ///Converting Codable type model to dictionary
      let params: [String: String] = JSONEncoder().convertToDictionary(self.requestModel) ?? [:]
        
        ///Calling api service method
        self.apiServices.login(params) { (result) in
            switch result {
            case .success(let response):
                guard let data = response.resultData as? Data else {
                    completion(.failure(ApiResponseErrorBlock(message: LocalizedStringEnum.somethingWentWrong.localized)))
                    return
                }
                let model: LoginResponseModel? = JSONDecoder().convertDataToModel(data)
                self.responseModel = model
                AppCache.shared.currentUser = self.responseModel?.data
                AppCache.shared.authToken = self.responseModel?.token
                completion(.success(response))
            case .failure(let error):
                ///Handle failure response
                completion(.failure(error))
            }
        }
    }
    
    ///Validating the data that all the api parameters are completed or not.
    func validation() -> String? {
        if self.requestModel.email?.isEmptyWithTrimmedSpace ?? true {
            return LocalizedStringEnum.enterEmailAddress.localized
        }
        if !(self.requestModel.email?.checkIsValidEmail() ?? false) {
            return LocalizedStringEnum.enterValidEmailAddress.localized
        }
        if self.requestModel.password?.isEmptyWithTrimmedSpace ?? true {
            return LocalizedStringEnum.enterPassword.localized
        }
        if !(self.requestModel.password?.isValidPassword() ?? false) {
            return LocalizedStringEnum.InvalidPassword.localized
        }
       
        return nil
    }
    
}

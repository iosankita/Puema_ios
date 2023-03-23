//
//  SignupVM.swift
//  Pneuma
//
//  Created by iTechnolabs on 19/03/21.
//  Copyright © 2021 Jatin. All rights reserved.
//

import Foundation
import Alamofire

class SignupVM: NSObject {
    
    // MARK: - VARIABLES
    var requestModel: SignupRequestModel
    var apiServices: AuthApiServices
    var responseModel: SignupResponseModel?
   
    // MARK: - CLASS LIFE CYCLE
    override init() {
        self.apiServices = AuthApiServices()
        self.requestModel = SignupRequestModel()
        self.responseModel = SignupResponseModel()
        super.init()
    }
    
    // MARK: - CUSTOM FUNCTIONS
    func signup(completion: @escaping ApiResponseCompletion) {

        ///Converting Codable type model to dictionary
        let params: [String: Any] = JSONEncoder().convertToDictionary(self.requestModel) ?? [:]

        ///Calling api service method
        self.apiServices.register(params, completionBlock:  { (result) in
            switch result {
            case .success(let response):
                guard let data = response.resultData as? Data else {
                    completion(.failure(ApiResponseErrorBlock(message: LocalizedStringEnum.somethingWentWrong.localized)))
                    return
                }
                ///Converting api Data response to LoginResponseModel. Which is Codable type.
                self.responseModel = JSONDecoder().convertDataToModel(data)
                AppCache.shared.authToken = self.responseModel?.token
                AppCache.shared.currentUser = self.responseModel?.data
                completion(.success(response))
            case .failure(let error):
                ///Handle failure response
                completion(.failure(error))
            }
        })
    }
    
    ///Validating the data that all the api parameters are completed or not.
    func validation() -> String? {
        
        if self.requestModel.name?.isEmptyWithTrimmedSpace ?? true {
            return LocalizedStringEnum.enterFullName.localized
        }
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
        if self.requestModel.password_confirmation?.isEmptyWithTrimmedSpace ?? true {
            return LocalizedStringEnum.enterPassword.localized
        }
        if self.requestModel.password != self.requestModel.password_confirmation {
            return LocalizedStringEnum.enterValidPassword.localized
        }
       
        return nil
    }
  
    
}

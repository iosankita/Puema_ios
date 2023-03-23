//
//  ResetPasswordVM.swift
//  Pneuma
//
//  Created by iTechnolabs on 19/03/21.
//  Copyright © 2021 Jatin. All rights reserved.
//

import Foundation

class ResetPasswordVM: NSObject {
    
    // MARK: - VARIABLES
    var requestModel: ResetPasswordRequestModel
    var apiServices: AuthApiServices
    var responseModel: CommonResponseModel?
    var userID: String

    // MARK: - CLASS LIFE CYCLE
    init(userID: String) {
        self.userID = userID
        self.apiServices = AuthApiServices()
        self.requestModel = ResetPasswordRequestModel()
        self.requestModel.user_id = userID
        super.init()
    }
    
    // MARK: - CUSTOM FUNCTIONS
    func resetPassword(completion: @escaping ApiResponseCompletion) {
        
        ///Converting Codable type model to dictionary
        let params: [String: Any] = JSONEncoder().convertToDictionary(self.requestModel) ?? [:]
        
        ///Calling api service method
        self.apiServices.resetPassword(params) { (result) in
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
        if self.requestModel.reset_password_otp?.isEmptyWithTrimmedSpace ?? true {
            return LocalizedStringEnum.emptyOTP.localized
        }
        if self.requestModel.reset_password_otp!.count <= 3{
            return LocalizedStringEnum.validOTP.localized
        }
        if self.requestModel.password?.isEmptyWithTrimmedSpace ?? true {
            return LocalizedStringEnum.enterPassword.localized
        }
        if !(self.requestModel.password?.isValidPassword() ?? false) {
            return LocalizedStringEnum.InvalidPassword.localized
        }
        if self.requestModel.confirm_password?.isEmptyWithTrimmedSpace ?? true {
            return LocalizedStringEnum.enterConfirmPassword.localized
        }
        if self.requestModel.password != self.requestModel.confirm_password {
            return LocalizedStringEnum.enterValidPassword.localized
        }
        return nil
    }
    
}

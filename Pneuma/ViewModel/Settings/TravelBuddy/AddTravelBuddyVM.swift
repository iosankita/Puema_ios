//
//  AddTravelBuddyVM.swift
//  Pneuma
//
//  Created by MacBook Pro on 25/10/21.
//  Copyright © 2021 Jatin. All rights reserved.
//

import Foundation

class AddTravelBuddyVM: NSObject {
    
    // MARK: - VARIABLES
    var apiServices: TravelBuddiesApiServices
    var requestModel: StoreTravelBuddyRequestModel
    var responseModel: StoreTravelBuddyResponseModel?
    
    // MARK: - INITIALIZER
    override init() {
        self.apiServices = TravelBuddiesApiServices()
        self.requestModel = StoreTravelBuddyRequestModel()
        self.responseModel = StoreTravelBuddyResponseModel()
        super.init()
    }
    
    func addTravelBuddy(completion: @escaping ApiResponseCompletion) {
        let params: [String: Any] = JSONEncoder().convertToDictionary(self.requestModel) ?? [:]
          
        self.apiServices.storeTravelBuddy(params) { (result) in
            switch result {
            case .success(let response):
                guard let data = response.resultData as? Data else {
                    completion(.failure(ApiResponseErrorBlock(message: LocalizedStringEnum.somethingWentWrong.localized)))
                    return
                }
                let model: StoreTravelBuddyResponseModel? = JSONDecoder().convertDataToModel(data)
                self.responseModel = model
                completion(.success(response))
            case .failure(let error):
                ///Handle failure response
                completion(.failure(error))
            }
        }
    }
    
    func validation() -> String? {
//        if self.requestModel.first_name?.isEmptyWithTrimmedSpace ?? true {
//            return LocalizedStringEnum.enterFullName.localized
//        }
//        if self.requestModel.middle_name?.isEmptyWithTrimmedSpace ?? true {
//            return LocalizedStringEnum.enterFullName.localized
//        }
//        if self.requestModel.last_name?.isEmptyWithTrimmedSpace ?? true {
//            return LocalizedStringEnum.enterFullName.localized
//        }
        if self.requestModel.email?.isEmptyWithTrimmedSpace ?? true {
            return LocalizedStringEnum.enterEmailAddress.localized
        }
        if !(self.requestModel.email?.isValidEmail() ?? false){
            return LocalizedStringEnum.enterValidEmailAddress.localized
        }
//        if self.requestModel.dob?.isEmptyWithTrimmedSpace ?? true {
//            return LocalizedStringEnum.enterDOB.localized
//        }

        return nil
    }
}

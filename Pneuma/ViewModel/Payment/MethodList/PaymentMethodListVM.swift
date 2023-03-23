//
//  PaymentMethodListVM.swift
//  Pneuma
//
//  Created by Chitra on 15/03/21.
//  Copyright © 2021 Jatin. All rights reserved.
//

import Foundation

class PaymentMethodListVM: NSObject {
    
    // MARK: - VARIABLES
    let tableDataSource = PaymentMethodListDataSource()
    var apiServices: UserPreferencesApiServices
    var requestModel: AddPaymentMethodRequestModel
    var responseModel: AddPayemntMethodResponseModel?
    var updateRequestModel: UpdatePaymentMethodRequestModel
    var updateResponseModel: UpdatePayemntMethodResponseModel?
    
    // MARK: - INITIALIZER
    override init() {
        self.apiServices = UserPreferencesApiServices()
        self.requestModel = AddPaymentMethodRequestModel()
        self.responseModel = AddPayemntMethodResponseModel()
        self.updateRequestModel = UpdatePaymentMethodRequestModel()
        self.updateResponseModel = UpdatePayemntMethodResponseModel()
        super.init()
        self.getList()
    }
    
    // MARK: - PRIVATE FUNCTIONS
    private func getList() {
        self.tableDataSource.listArray = [PaymentMethodModel(title: "Visa - 4578"),
                                          PaymentMethodModel(title: "MasterCard - 4571", isExpired: true)]
    }
    
    
    func addPaymentMethod(completion: @escaping ApiResponseCompletion) {
        let params: [String: Any] = JSONEncoder().convertToDictionary(self.requestModel) ?? [:]
          
        self.apiServices.storePaymentMethod(params) { (result) in
            switch result {
            case .success(let response):
                guard let data = response.resultData as? Data else {
                    completion(.failure(ApiResponseErrorBlock(message: LocalizedStringEnum.somethingWentWrong.localized)))
                    return
                }
                let model: AddPayemntMethodResponseModel? = JSONDecoder().convertDataToModel(data)
                self.responseModel = model
                completion(.success(response))
            case .failure(let error):
                ///Handle failure response
                completion(.failure(error))
            }
        }
    }
    
    func validation() -> String? {
        return nil
    }
    
    func updatePaymentMethod(completion: @escaping ApiResponseCompletion) {
        let params: [String: Any] = JSONEncoder().convertToDictionary(self.updateRequestModel) ?? [:]
          
        self.apiServices.updatePaymentMethod(params) { (result) in
            switch result {
            case .success(let response):
                guard let data = response.resultData as? Data else {
                    completion(.failure(ApiResponseErrorBlock(message: LocalizedStringEnum.somethingWentWrong.localized)))
                    return
                }
                let model: UpdatePayemntMethodResponseModel? = JSONDecoder().convertDataToModel(data)
                self.updateResponseModel = model
                completion(.success(response))
            case .failure(let error):
                ///Handle failure response
                completion(.failure(error))
            }
        }
    }
}


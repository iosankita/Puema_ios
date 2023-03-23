//
//  PaymentMethodVM.swift
//  Pneuma
//
//  Created by Jatin on 17/03/21.
//  Copyright © 2021 Jatin. All rights reserved.
//

import Foundation

class PaymentMethodVM: NSObject {
    
    // MARK: - VARIABLES
    let tableDataSource = ExistingPaymentMethodTableDataSource()
    var apiServices: UserPreferencesApiServices
    var requestModel: AddPaymentMethodRequestModel
    var responseModel: AddPayemntMethodResponseModel?
    
    // MARK: - INITIALIZER
    override init() {
        self.apiServices = UserPreferencesApiServices()
        self.requestModel = AddPaymentMethodRequestModel()
        self.responseModel = AddPayemntMethodResponseModel()
        super.init()
        self.getList()
    }
    
    // MARK: - PRIVATE FUNCTIONS
    private func getList() {
        let model1 = ExistingPaymentMethodDataModel(title: "Visa-4578", selected: true)
        let model2 = ExistingPaymentMethodDataModel(title: "MasterCard - 1236")
        let model3 = ExistingPaymentMethodDataModel(title: "Google Pay", separator: false)
        self.tableDataSource.listArray = [model1, model2, model3]
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
}


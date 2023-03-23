//
//  PaymentInfoVM.swift
//  Pneuma
//
//  Created by Jatin on 10/03/21.
//  Copyright © 2021 Jatin. All rights reserved.
//

import Foundation

class PaymentInfoVM: NSObject {
    
    // MARK: - VARIABLES
    var paymentMethods = [PaymentMethodDataModel]()
    
    var requestModel: FlightBookRequestModel
    var apiServices: FlightApiServices
    var responseModel: FlightBookResponseModel?
    
    // MARK: - INITIALIZER
    override init() {
        self.apiServices = FlightApiServices()
        self.requestModel = FlightBookRequestModel()
        self.responseModel = FlightBookResponseModel()
        super.init()
        self.getData()
    }
    
    // MARK: - PRIVATE FUNCTIONS
    private func getData() {
        let model1 = PaymentMethodDataModel(title: "Visa-4578")
        let model2 = PaymentMethodDataModel(title: "MasterCard - 1236")
        let model3 = PaymentMethodDataModel(title: "Google Pay", separator: false)
        self.paymentMethods = [model1, model2, model3]
    }
    
    func bookFlight(completion: @escaping ApiResponseCompletion) {
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
                let model: FlightBookResponseModel? = JSONDecoder().convertDataToModel(data)
                self.responseModel = model
                completion(.success(response))
            case .failure(let error):
                ///Handle failure response
                completion(.failure(error))
            }
        }
    }

    func createCustomer(completion: @escaping ApiResponseCompletion) {
        self.apiServices.createStripeCustomer { (result) in
            switch result {
            case .success(let response):
                completion(.success(response))
            case .failure(let error):
                ///Handle failure response
                completion(.failure(error))
            }
        }
    }

    func createPaymentIndent(params: [String:Any], completion: @escaping ApiResponseCompletion) {
        self.apiServices.createPaymentInetent(params) { (result) in
            switch result {
            case .success(let response):
                completion(.success(response))
                break
            case .failure(let error):
                completion(.failure(error))
                break
            }
        }
    }

    func createEphemeralKey(params: [String:Any], completion: @escaping ApiResponseCompletion) {
        self.apiServices.createEphemeralKey(params) { (result) in
            switch result {
            case .success(let response):
                completion(.success(response))
                break
            case .failure(let error):
                completion(.failure(error))
                break
            }
        }
    }

    func createFareSummary(params: [String:Any], completion: @escaping ApiResponseCompletion) {
        self.apiServices.createFareSummary(params) { (result) in
            switch result {
            case .success(let response):
                completion(.success(response))
            case .failure(let error):
                ///Handle failure response
                completion(.failure(error))
            }
        }
    }

    func createOrder(params: [String:Any], completion: @escaping ApiResponseCompletion) {
        self.apiServices.createOrder(params) { (result) in
            switch result {
            case .success(let response):
                completion(.success(response))
                break
            case .failure(let error):
                completion(.failure(error))
                break
            }
        }
    }
    
    ///Validating the data that all the api parameters are completed or not.
    func validation() -> String? {
        return nil
    }
}



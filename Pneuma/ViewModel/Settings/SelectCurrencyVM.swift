//
//  SelectCurrencyVM.swift
//  Pneuma
//
//  Created by Chitra on 10/03/21.
//  Copyright © 2021 Jatin. All rights reserved.
//

import Foundation

class SelectCurrencyVM: NSObject {
    
    // MARK: - VARIABLES
    let tableDataSource = SelectCurrencyDataSource()
    var apiServices: CurrencyApiServices
    var userPrefApiServices: UserPreferencesApiServices
    var responseModel: GetCurrenciesResponseModel?
    var storeRequestModel: StoreCurrencyPreferenceRequestModel
    var storeResponseModel: StoreCurrencyPreferenceResponseModel?
    
    // MARK: - INITIALIZER
    override init() {
        self.apiServices = CurrencyApiServices()
        self.responseModel = GetCurrenciesResponseModel()
        self.userPrefApiServices = UserPreferencesApiServices()
        self.storeRequestModel = StoreCurrencyPreferenceRequestModel()
        self.storeResponseModel = StoreCurrencyPreferenceResponseModel()
        super.init()
    }
    func getList(completion: @escaping ApiResponseCompletion) {
        self.apiServices.getAllCurrencies { (result) in
            switch result {
            case .success(let response):
                guard let data = response.resultData as? Data else {
                    completion(.failure(ApiResponseErrorBlock(message: LocalizedStringEnum.somethingWentWrong.localized)))
                    return
                }
                let model: GetCurrenciesResponseModel? = JSONDecoder().convertDataToModel(data)
                self.responseModel = model
                self.tableDataSource.listArray = [CurrencyModel]()
                if let model = self.responseModel , let array = model.data  {
                    for currency in array {
                        let dataModel = CurrencyModel(title: currency.name ?? "")
                        self.tableDataSource.listArray.append(dataModel)
                    }
                }
                
                completion(.success(response))
            case .failure(let error):
                ///Handle failure response
                completion(.failure(error))
            }
        }
    }
   
}

// MARK: - TABLE FUNCTIONS
extension SelectCurrencyVM {
    func selectItem(at indexPath: IndexPath) {
        self.tableDataSource.listArray.forEach() { item in
            item.isSelected = false
        }
        for (i, item) in self.tableDataSource.listArray.enumerated()  {
            if i == indexPath.row {
                item.isSelected = true
            }
        }
        print(tableDataSource.listArray)
    }
}

extension SelectCurrencyVM {
    func addPreferredCurrency(completion: @escaping ApiResponseCompletion) {
        let params: [String: Any] = JSONEncoder().convertToDictionary(self.storeRequestModel) ?? [:]
          
        self.userPrefApiServices.currencyPreference(params) { (result) in
            switch result {
            case .success(let response):
                guard let data = response.resultData as? Data else {
                    completion(.failure(ApiResponseErrorBlock(message: LocalizedStringEnum.somethingWentWrong.localized)))
                    return
                }
                let model: StoreCurrencyPreferenceResponseModel? = JSONDecoder().convertDataToModel(data)
                self.storeResponseModel = model
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

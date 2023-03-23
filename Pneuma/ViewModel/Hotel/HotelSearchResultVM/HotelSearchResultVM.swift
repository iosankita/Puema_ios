//
//  HotelSearchResultVM.swift
//  Pneuma
//
//  Created by Jatin on 04/03/21.
//  Copyright © 2021 Jatin. All rights reserved.
//

import Foundation

struct SearchHotelModelParam {

    var checkin_date : String?
    var checkout_date : String?
    var location : String?

    init(checkin_date : String?, checkout_date : String?, location : String?) {
        self.checkin_date = checkin_date
        self.checkout_date = checkout_date
        self.location = location
    }
}

class HotelSearchResultVM: NSObject {
    
    // MARK: - VARIABLES
    let tableDataSource = HotelSearchResultTableDataSource()
    var apiServices: HotelApiServices
    var responseModel: HotelSearchResponse?
    
    // MARK: - INITIALIZER
    override init() {
        self.apiServices = HotelApiServices()
        super.init()
    }
    
    // MARK: - PRIVATE FUNCTIONS
    func getList(_ parameters: SearchHotelModelParam?, completion: @escaping ApiResponseCompletion) {
        let params : [String:Any] = ["checkin_date":parameters!.checkin_date!,"checkout_date":parameters!.checkout_date!,"location":parameters!.location!]
        self.apiServices.getHotelSearch(params) { (result) in
            switch result {
            case .success(let response):
                guard let data = response.resultData as? Data else {
                    completion(.failure(ApiResponseErrorBlock(message: LocalizedStringEnum.somethingWentWrong.localized)))
                    return
                }
                do {
                    let jsonObj = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
                       // try to read out a dictionary
                   print("JSON ::::",jsonObj)
                } catch let error {
                    print("Error:::::",error)
                }
                let model: HotelSearchResponse? = JSONDecoder().convertDataToModel(data)
                self.responseModel = model
                if let model = self.responseModel , model.data!.count > 0  {
                    self.tableDataSource.listArray = model.data!
                }
                completion(.success(response))
            case .failure(let error):
                ///Handle failure response
                completion(.failure(error))
            }
        }
    }
}


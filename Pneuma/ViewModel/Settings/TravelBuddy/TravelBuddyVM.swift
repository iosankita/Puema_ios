//
//  TravelBuddyVM.swift
//  Pneuma
//
//  Created by Chitra on 04/03/21.
//  Copyright © 2021 Jatin. All rights reserved.
//

import Foundation

class TravelBuddyVM: NSObject {
    
    // MARK: - VARIABLES
    let tableDataSource = TravelBuddyTableDataSource()
    var apiServices: TravelBuddiesApiServices
    var responseModel: GetTravelBuddiesResponseModel?
    
    // MARK: - INITIALIZER
    override init() {
        self.apiServices = TravelBuddiesApiServices()
        self.responseModel = GetTravelBuddiesResponseModel()
        super.init()
    }
    
    func getList(completion: @escaping ApiResponseCompletion) {
        self.apiServices.getAllBuddies { (result) in
            switch result {
            case .success(let response):
                guard let data = response.resultData as? Data else {
                    completion(.failure(ApiResponseErrorBlock(message: LocalizedStringEnum.somethingWentWrong.localized)))
                    return
                }
                let model: GetTravelBuddiesResponseModel? = JSONDecoder().convertDataToModel(data)
                self.responseModel = model
                if let model = self.responseModel , let array = model.data  {
                    self.tableDataSource.listArray = array
                }
                
                completion(.success(response))
            case .failure(let error):
                ///Handle failure response
                completion(.failure(error))
            }
        }
        
//        self.tableDataSource.listArray = [TravelBuddyModel(title: "Me (B. Simmons)"), TravelBuddyModel(title: "Jane Simmons"), TravelBuddyModel(title: "Steve Bishop")]
    }
}

// MARK: - TABLE FUNCTIONS
extension TravelBuddyVM {
    func selectItem(at indexPath: IndexPath) {
        
    }
}

//
//  OutboundDetailVM.swift
//  Pneuma
//
//  Created by Jatin on 01/03/21.
//  Copyright © 2021 Jatin. All rights reserved.
//

import Foundation

class OutboundDetailVM: NSObject {
    
    // MARK: - VARIABLES
    let tableDataSource = OutboundDetailTableDataSource()
   
    // MARK: - INITIALIZER
    override init() {
        super.init()
        self.getList()
       // self.apiServices = FlightApiServices()
     
    }
    
    // MARK: - PRIVATE FUNCTIONS
    private func getList() {
        let model1 = OutboundDetailDataModel(title: "")
        let model2 = OutboundDetailDataModel(title: "", hideBottomOval: false)
        self.tableDataSource.listArray = [model1, model2]
    }
    
//    func getFlightDetails(id:String,dataSource:String,completion: @escaping ApiResponseCompletion) {
//        self.tableDataSource.listArray.removeAll()
//        CustomLoader.shared.show()
//      
//        FlightApiServices().getFlightDetails(id,dataSource) { [weak self] (result) in
//            CustomLoader.shared.hide()
//            guard let `self` = self else {
//                return
//            }
//            switch result {
//            case .success(let response):
//                guard let data = response.resultData as? Data else {
//                    completion(.failure(ApiResponseErrorBlock(message: LocalizedStringEnum.somethingWentWrong.localized)))
//                    return
//                }
//                let model: [AirItineraryModel]? = JSONDecoder().convertDataToModel(data)
//                guard let data = model else {  return  }
//                if data.count > 0 {
//                   // self.tableDataSource.airlineModel = data
//                }
//                completion(.success(response))
//            case .failure(let error):
//                completion(.failure(error))
//            }
//        }
//    }

//    func getAirlineDetails(code:String,completion: @escaping ApiResponseCompletion) {
//        CustomLoader.shared.show()
//      
//        FlightApiServices().getAirlineDetails(code) { [weak self] (result) in
//            CustomLoader.shared.hide()
//            guard let `self` = self else {
//                return
//            }
//            switch result {
//            case .success(let response):
//                guard let data = response.resultData as? Data else {
//                    completion(.failure(ApiResponseErrorBlock(message: LocalizedStringEnum.somethingWentWrong.localized)))
//                    return
//                }
//                let model: AirItineraryDataModel? = JSONDecoder().convertDataToModel(data)
//                guard let data = model else {  return  }
//                if data.data!.count > 0 {
//                    self.tableDataSource.airlineModel = data.data ?? []
//                  //  self.tableDataSource.listAirItineraryMode = data.data ?? []
//                }
//                completion(.success(response))
//            case .failure(let error):
//                completion(.failure(error))
//            }
//        }
//    }
   

}


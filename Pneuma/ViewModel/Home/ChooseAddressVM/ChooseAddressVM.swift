//
//  ChooseAddressVM.swift
//  Pneuma
//
//  Created by Jatin on 01/03/21.
//  Copyright © 2021 Jatin. All rights reserved.
//

import Foundation
import Amadeus

class ChooseAddressVM: NSObject {
    
    // MARK: - VARIABLES
    let tableDataSource = ChooseAddressTableDataSource()
    var locationType: ChooseAddressTypeEnum
    var amadeus: Amadeus!
    var arrList: [AirportsList] = [AirportsList]()
    var arrCustomList: [SearchCityData] = [SearchCityData]()
    var apiResponse:Response?
    var objCity = SearchCity()
    var apiServices: FlightApiServices
    var responseModel: GetFlightBookingsResponseModel?

    // MARK: - INITIALIZER
    init(locationType: ChooseAddressTypeEnum) {
        self.locationType = locationType
        self.apiServices = FlightApiServices()
        self.responseModel = GetFlightBookingsResponseModel()
        super.init()
    }
    
    // MARK: - PRIVATE FUNCTIONS
    func getList(lat:Double,long:Double,completion: @escaping (_ errorMessage:String) -> Void) {
        arrList = [AirportsList]()
        amadeus = Amadeus(
            client_id: "hqHmjsbm1TJ2hdgsYKAoSGP6ydtfsgPL",
            client_secret: "7RcopP0jIf18VZzJ",
            environment: ["log_level" : "debug"])
        amadeus.referenceData.locations.airports.get(params:["longitude": "\(long)","latitude": "\(lat)"]) { result in
            switch result {
            case .success(let response):
                self.apiResponse = response
                print(response.result)
                let stringValue = response.body
                print("stringValue",stringValue)
                if let data = stringValue.data(using: .utf8) {
                    let model: AirportsSearchResponseModel? = JSONDecoder().convertDataToModel(data)
                    if model?.data == nil{
                        completion(LocalizedStringEnum.somethingWentWrong.localized)
                    }else{
                        for dataAirports in model?.data ?? [AirportsList](){
                            self.arrList.append(dataAirports)
                        }
                        self.tableDataSource.listArray = self.arrList
                        self.tableDataSource.VM = self
                        completion("")
                    }
                }
                break
            case .failure(let error):
                completion(error.localizedDescription)
                break
            }
        }
    }

    
    func getCityList(city:String,completion: @escaping ApiResponseCompletion) {
        self.tableDataSource.listArray2.removeAll()
        CustomLoader.shared.show()
        self.apiServices.searchCity(city) { [weak self] (result) in
            CustomLoader.shared.hide()
            guard let `self` = self else {
                return
            }
            switch result {
            case .success(let response):
                guard let data = response.resultData as? Data else {
                    completion(.failure(ApiResponseErrorBlock(message: LocalizedStringEnum.somethingWentWrong.localized)))
                    return
                }
                let model: SearchCity? = JSONDecoder().convertDataToModel(data)
                guard let data = model else {  return  }
                self.objCity = data
                //if let model = self.responseModel , let array = model.data  {
                if self.objCity.data!.count > 0 {
                    self.tableDataSource.listArray2 = self.objCity.data!
                }
                //}
                completion(.success(response))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }


    func moreDataList(completion: @escaping (_ errorMessage:String) -> Void){
//        amadeus.next(response: response, onCompletion: { result in
//                        switch result {
//                            case .success(let response):
        amadeus.next(response: self.apiResponse!) { result in
            switch result {
            case .success(let response):
                self.apiResponse = response
                let stringValue = response.body
                if let data = stringValue.data(using: .utf8) {
                    let model: AirportsSearchResponseModel? = JSONDecoder().convertDataToModel(data)
                    if model?.data == nil{
                        completion(LocalizedStringEnum.somethingWentWrong.localized)
                    }else{
                        for dataAirports in model?.data ?? [AirportsList](){
                            self.arrList.append(dataAirports)
                        }
                        self.tableDataSource.listArray = self.arrList
                        completion("")
                    }
                }
                break
            case .failure(let error):
                completion(error.localizedDescription)
                break
            }
        }

    }
}


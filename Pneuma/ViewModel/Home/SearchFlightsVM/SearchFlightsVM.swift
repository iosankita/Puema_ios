//
//  SearchFlightsVM.swift
//  Pneuma
//
//  Created by Jatin on 01/03/21.
//  Copyright © 2021 Jatin. All rights reserved.
//

import Foundation
import AVFoundation

struct SearchFlightModelParam {

    var origin : String?
    var destination : String?
    var departureDate : String?
    var returnDate : String?
    var cabin : String?
    var adults : Int?
    var children : Int?
    var children_age : Array<Any>?
    var max_stop : Int?
    var max_duration:Int?
    var pagination : [String:Int]?
    var sort_by :String?
    init(origin : String?, destination : String?, departureDate : String?, returnDate : String?, cabin : String?, adults : Int?, children : Int?, children_age : Array<Any>?,max_stop: Int?,max_duration:Int?,pagination:[String:Int]?,sort_by:String?) {
        self.origin = origin
        self.destination = destination
        self.departureDate = departureDate
        self.returnDate = returnDate ?? nil
        self.cabin = cabin
        self.adults = adults
        self.children = children
        self.children_age = children_age ?? []
        self.max_stop = max_stop
        self.max_duration = max_duration == 0 ? 1200 : max_duration
        self.pagination = pagination
        self.sort_by = sort_by
        
    }
}

class SearchFlightsVM: NSObject {
    
    // MARK: - VARIABLES
    let tableDataSource = SearchFlightsTableDataSource()
    var apiServices: FlightApiServices
    var responseModel: FlightSearchResponse2?
    var objSearchFlightsTableDataSourceModel = SearchFlightsTableDataSourceModel()
    
    // MARK: - INITIALIZER
    override init() {
        self.apiServices = FlightApiServices()
        super.init()
    }
    
    // MARK: - PRIVATE FUNCTIONS
    func getFlightSearch(_ parameters: SearchFlightModelParam?, completion: @escaping ApiResponseCompletion) {
        
        let params : [String:Any]?
        if parameters?.returnDate != nil {
            params   = ["origin":parameters!.origin!,"destination":parameters!.destination!,"departure_date":parameters!.departureDate!, "return_date": parameters!.returnDate!, "cabin_type":parameters!.cabin!, "adults":parameters!.adults!, "children":parameters!.children!, "children_age":parameters?.children_age ?? [],"max_stops":parameters!.max_stop ?? 0,"max_duration":parameters?.max_duration ?? 1200 ,"pagination":parameters!.pagination!,"sort_by":parameters!.sort_by ?? ""]
        }else {
            params   = ["origin":parameters!.origin!,"destination":parameters!.destination!,"departure_date":parameters!.departureDate!, "cabin_type":parameters!.cabin!, "adults":parameters!.adults!, "children":parameters!.children!, "children_age":parameters?.children_age ?? [],"max_stops":parameters!.max_stop ?? 0,"max_duration":parameters?.max_duration ?? 1200 ,"pagination":parameters!.pagination!,"sort_by":parameters!.sort_by ?? ""]
        }
        self.apiServices.getFlightSearch(params!) { (result) in
            switch result {
            case .success(let response):
                guard let data = response.resultData as? Data else {
                    completion(.failure(ApiResponseErrorBlock(message: LocalizedStringEnum.somethingWentWrong.localized)))
                    return
                }
                let model: FlightSearchResponse2? = JSONDecoder().convertDataToModel(data)
                self.responseModel = model
                
                self.objSearchFlightsTableDataSourceModel.offset = model?.RecordOffset ?? 0
                self.objSearchFlightsTableDataSourceModel.limit = model?.RecordLimit ?? 0
                self.objSearchFlightsTableDataSourceModel.totalPage = model?.TotalRecords ?? 0
                guard let data = model?.data as?  SearchResult else {
                    let error = "No Data Available. Please try again later."
                    //Toast.shared.showAlert(type: .apiFailure, message:error )
                    completion(.failure(ApiResponseErrorBlock.init(message: error)))
                    return
                }
                var data1 = data.SearchResult
                if let _ = self.responseModel , data1?.count ?? 0 > 0  {
                    if self.objSearchFlightsTableDataSourceModel.limit == 1 {
                        self.tableDataSource.listArray2 = data1 ?? []
                    }else {
                        self.tableDataSource.listArray2 =  self.tableDataSource.listArray2 + (data1 ?? [])
                    }
                    //self.objSearchFlightsTableDataSourceModel.listArray2 = data1 ?? []
                   
                }
                completion(.success(response))
            case .failure(let error):
             
                completion(.failure(error))
            }
        }
    }
    
//    func getFlightDetailsModel(_ model : [String:Any],completion: @escaping ApiResponseCompletion) {
//        self.tableDataSource.listArray.removeAll()
//        CustomLoader.shared.show()
//
//        FlightApiServices().getFlightDetailsModel(model) { [weak self] (result) in
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
//                let model: [AirlineInfoModel]? = JSONDecoder().convertDataToModel(data)
//                guard let data = model else {  return  }
//                if data.count > 0 {
//                    self.objSearchFlightsTableDataSourceModel.arrAirlineInfoModel = data
//                }
//                completion(.success(response))
//            case .failure(let error):
//                completion(.failure(error))
//            }
//        }
//    }
    func getAirlineDetails(code:String,completion: @escaping ApiResponseCompletion) {
        //CustomLoader.shared.show()
      
        FlightApiServices().getAirlineDetails(code) { [weak self] (result) in
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
                let model: AirItineraryDataModel? = JSONDecoder().convertDataToModel(data)
                guard let data = model else {  return  }
                if data.data!.count > 0 {
                    self.tableDataSource.arrAirlineInfoModel = data.data ?? []
                }
                completion(.success(response))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func getSearchAirportName(search:String,completion: @escaping ApiResponseCompletion) {
       // CustomLoader.shared.show()
      
        FlightApiServices().getAirportName(search) { [weak self] (result) in
            self?.tableDataSource.arrSearchCityData = []
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
                if /data.data?.count > 0 {
                    self.tableDataSource.arrSearchCityData = data.data ?? []
                }
                completion(.success(response))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
}


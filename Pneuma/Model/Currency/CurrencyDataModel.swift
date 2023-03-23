//
//  CurrencyDataModel.swift
//  Pneuma
//
//  Created by MacBook Pro on 31/10/21.
//  Copyright © 2021 Jatin. All rights reserved.
//

import Foundation

class CurrencyDataModel : Codable {
    var id: Int?
    var name: String?
    var created_at: String?
    var updated_at: String?
    
}

struct GetCurrenciesResponseModel: Codable {
    var message: String?
    var data: [CurrencyDataModel]?
}


struct StoreCurrencyRequestModel: Codable {
    var name: String?
}

struct StoreCurrencyResponseModel: Codable {
    //var status: String?
    var message: String?
    var data: CurrencyDataModel?
    
}
struct DeleteCurrencyRequestModel: Codable {
    var name: String?
}

struct DeleteCurrencyResponseModel: Codable {
    //var status: String?
    var message: String?
    
}

struct StoreCurrencyPreferenceRequestModel: Codable {
    var currency_id: Int?
}

struct StoreCurrencyPreferenceResponseModel: Codable {
    //var status: String?
    var message: String?
    
}

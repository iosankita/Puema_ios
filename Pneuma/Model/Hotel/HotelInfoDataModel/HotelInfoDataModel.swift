//
//  HotelInfoDataModel.swift
//  Pneuma
//
//  Created by Jatin on 15/03/21.
//  Copyright © 2021 Jatin. All rights reserved.
//

import Foundation

class HotelInfoCollectionDataSourceModel: NSObject {
    var listArray = [HotelInfoDataModel]()
    var listArray2 = [String]()
}

struct HotelInfoDataModel {
    var title: String?
}




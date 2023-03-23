//
//  AddPaymentMethodDataModel.swift
//  Pneuma
//
//  Created by Jatin on 09/03/21.
//  Copyright © 2021 Jatin. All rights reserved.
//

import UIKit

class AddPaymentMethodCollectionDataSourceModel: NSObject {
    var listArray = [AddPaymentMethodDataModel]()
}

struct AddPaymentMethodDataModel {
    var imageName: String?
    var image: UIImage? {
        if let name = self.imageName {
            return UIImage(named: name)
        }
        return nil
    }
}

class PaymentModel : Codable {
    var id: Int?
    var name: String?
    var created_at: String?
    var updated_at: String?
    var pivot: PivotModel?
    
}

class PivotModel : Codable {
    var user_id: Int?
    var payment_method_id: Int?
    var card_number: Int?
    var cvv: Int?
    var created_at: String?
    var updated_at: String?
    
}


struct AddPaymentMethodRequestModel: Codable {
    var payment_method_id, card_number , cvv: Int?
    var expiry_date: String?
}

struct AddPayemntMethodResponseModel: Codable {
    //var status: String?
    var message: String?
    var data: PaymentModel?
    
}
struct UpdatePaymentMethodRequestModel: Codable {
    var payment_method_id, card_number , cvv: Int?
    var expiry_date: String?
}

struct UpdatePayemntMethodResponseModel: Codable {
    //var status: String?
    var message: String?
    var data: PaymentModel?
    
}

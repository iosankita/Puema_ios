//
//  AddPaymentMethodVM.swift
//  Pneuma
//
//  Created by Jatin on 09/03/21.
//  Copyright © 2021 Jatin. All rights reserved.
//

import Foundation

class AddPaymentMethodVM: NSObject {
    
    // MARK: - VARIABLES
    let collectionDataSource = AddPaymentMethodCollectionDataSource()
    
    // MARK: - INITIALIZER
    override init() {
        super.init()
        self.getList()
    }
    
    // MARK: - PRIVATE FUNCTIONS
    private func getList() {
        let model1 = AddPaymentMethodDataModel(imageName: "ic-visa")
        let model2 = AddPaymentMethodDataModel(imageName: "ic-mastercard")
        let model3 = AddPaymentMethodDataModel(imageName: "ic-gpay")
        let model4 = AddPaymentMethodDataModel(imageName: "ic-apple-pay")
        let model5 = AddPaymentMethodDataModel(imageName: "ic-stripe")
        let model6 = AddPaymentMethodDataModel(imageName: "ic-paypal")
        self.collectionDataSource.listArray = [model1, model2, model3, model4, model5, model6]
    }
}


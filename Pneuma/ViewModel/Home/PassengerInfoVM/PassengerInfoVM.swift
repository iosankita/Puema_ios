//
//  PassengerInfoVM.swift
//  Pneuma
//
//  Created by Jatin on 02/03/21.
//  Copyright © 2021 Jatin. All rights reserved.
//

import Foundation

struct CreateOrderParam : Codable {
    var passengers : String?
    var email_address : String?
    var country_calling_code : String?
    var mobile_number : String?
    var flight_search : String?
    var first_name : String?
    var last_name : String?
    var date_of_birth : String?
    var gender : String?
    var first_name1 : String?
    var last_name1 : String?
    var date_of_birth1 : String?
    var gender1 : String?
    var first_name2 : String?
    var last_name2 : String?
    var date_of_birth2 : String?
    var gender2 : String?
    var first_name3 : String?
    var last_name3 : String?
    var date_of_birth3 : String?
    var gender3 : String?
    var first_name4 : String?
    var last_name4 : String?
    var date_of_birth4 : String?
    var gender4 : String?

    init(passengers : String?, email_address : String?, country_calling_code : String?, mobile_number : String?, flight_search : String?, first_name : String?, last_name : String?, date_of_birth : String?, gender : String?, first_name1 : String? = "", last_name1 : String? = "", date_of_birth1 : String? = "", gender1 : String? = "", first_name2 : String? = "", last_name2 : String? = "", date_of_birth2 : String? = "", gender2 : String? = "", first_name3 : String? = "", last_name3 : String? = "", date_of_birth3 : String? = "", gender3 : String? = "", first_name4 : String? = "", last_name4 : String? = "", date_of_birth4 : String? = "", gender4 : String? = "") {
        self.passengers = passengers
        self.email_address = email_address
        self.country_calling_code = country_calling_code
        self.mobile_number = mobile_number
        self.flight_search = flight_search
        self.last_name = last_name
        self.date_of_birth = date_of_birth
        self.gender = gender
        self.first_name1 = first_name1
        self.last_name1 = last_name1
        self.date_of_birth1 = date_of_birth1
        self.gender1 = gender1
        self.first_name2 = first_name2
        self.last_name2 = last_name2
        self.date_of_birth2 = date_of_birth2
        self.gender2 = gender2
        self.first_name3 = first_name1
        self.last_name3 = last_name1
        self.date_of_birth3 = date_of_birth1
        self.gender3 = gender1
        self.first_name4 = first_name4
        self.last_name4 = last_name4
        self.date_of_birth4 = date_of_birth4
        self.gender4 = gender4
    }
}

class PassengerInfoVM: NSObject {
    
    // MARK: - VARIABLES
    var currentStep: PassengerInfoCurrentStep = .personalInfo
    
    // MARK: - INTERNAL FUNCTIONS
    func gotoNextStep() {
        if let nextStep = PassengerInfoCurrentStep(rawValue: self.currentStep.rawValue + 1) {
            self.currentStep = nextStep
        }
    }
    
    func gotoPreviousStep() {
        if let previousStep = PassengerInfoCurrentStep(rawValue: self.currentStep.rawValue - 1) {
            self.currentStep = previousStep
        }
    }
}

extension String {
    static func stringify(json: Any, prettyPrinted: Bool = false) -> String {
        var options: JSONSerialization.WritingOptions = []
        if prettyPrinted {
          options = JSONSerialization.WritingOptions.prettyPrinted
        }

        do {
          let data = try JSONSerialization.data(withJSONObject: json, options: options)
          if let string = String(data: data, encoding: String.Encoding.utf8) {
            return string
          }
        } catch {
          print(error)
        }

        return ""
    }
}

//
//  String+Extension.swift
//  Pneuma
//
//  Created by Chitra on 24/02/21.
//  Copyright © 2021 iTechnolabs. All rights reserved.
//

import Foundation

extension String {
    var isEmptyWithTrimmedSpace: Bool {
        return self.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }
    
    func capitalizingFirstLetter() -> String {
        return prefix(1).capitalized + dropFirst()
    }
    
    mutating func capitalizeFirstLetter() {
        self = self.capitalizingFirstLetter()
    }
    
    func getDate() -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        dateFormatter.timeZone = TimeZone.current
        dateFormatter.locale = Locale.current
        return dateFormatter.date(from: self) // replace Date String
    }
    
    func getDate2() -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSSSS'Z'"
        dateFormatter.timeZone = TimeZone.current
        dateFormatter.locale = Locale.current
        return dateFormatter.date(from: self) // replace Date String
    }
  
        
        //MARK:- Convert UTC To Local Date by passing date formats value
        func UTCToLocal(incomingFormat: String, outGoingFormat: String) -> String {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = incomingFormat
            dateFormatter.timeZone = Foundation.TimeZone(abbreviation: "UTC")
            
            let dt = dateFormatter.date(from: self)
            dateFormatter.timeZone = Foundation.TimeZone.current
            dateFormatter.dateFormat = outGoingFormat
            
            return dateFormatter.string(from: dt ?? Date())
        }
    
}

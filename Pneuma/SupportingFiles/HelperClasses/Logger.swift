//
//  Logger.swift
//  Pneuma
//
//  Created by Chitra on 24/02/21.
//  Copyright © 2021 iTechnolabs. All rights reserved.
//

import UIKit


enum LogType: String {
    case error
    case warning
    case success
}

class Logger {

 static func printLog(_ logType: LogType,_ message: String){
        switch logType {
        case LogType.error:
            print("\n🛑 Error: \(message)\n")
        case LogType.warning:
            print("\n⚠️ Warning: \(message)\n")
        case LogType.success:
            print("\n📗 Success: \(message)\n")
        }
    }

}

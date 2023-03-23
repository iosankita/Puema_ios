//
//  AskAnnieApiServices.swift
//  Pneuma
//
//  Created by Infinity S on 12/02/22.
//  Copyright © 2022 Jatin. All rights reserved.
//

import Foundation

fileprivate enum AskAnnieApiServicesEndPoints: APIService {

    case searchFlightAnnie(_ parameters: [String: Any])

    case searchHotelAnnie(_ parameters: [String: Any])

    //Return path according to api case
    var path: String {
        switch self {
        case .searchFlightAnnie:
            return "http://ec2-34-220-61-139.us-west-2.compute.amazonaws.com:8082/"
        case .searchHotelAnnie:
            return "http://ec2-34-220-61-139.us-west-2.compute.amazonaws.com:5051/"
        }
    }
    //Return resource according to api case
    var resource: Resource {

        let headers: [String: Any] = [
            "Content-Type": "application/json",
            "Authorization": "Bearer \(AppCache.shared.authToken ?? "")"
        ]

        switch self {
        case .searchFlightAnnie(let params):
            return Resource(method: .get, parameters: params, encoding: .QUERY, headers: headers, validator: APIDataResultValidator(), responseType: .data)
        case .searchHotelAnnie(let params):
            return Resource(method: .get, parameters: params, encoding: .QUERY, headers: headers, validator: APIDataResultValidator(), responseType: .data)
        }
    }
}

struct AskAnnieApiServices {

    func searchFlightAnnie(_ parameters: [String: Any], completionBlock: @escaping ApiResponseCompletion) {
        AskAnnieApiServicesEndPoints.searchFlightAnnie(parameters).urlRequest(completionBlock: completionBlock)
    }

    func searchHotelAnnie(_ parameters: [String: Any], completionBlock: @escaping ApiResponseCompletion) {
        AskAnnieApiServicesEndPoints.searchHotelAnnie(parameters).urlRequest(completionBlock: completionBlock)
    }

    static func getPostString(params:[String:Any]) -> String {
        var data = [String]()
        for(key, value) in params
        {
            data.append(key + "=\(value)")
        }
        return data.map { String($0) }.joined(separator: "&")
    }
}


//
//  FlightApiServices.swift
//  Pneuma
//
//  Created by MacBook Pro on 25/10/21.
//  Copyright © 2021 Jatin. All rights reserved.
//

import Foundation

fileprivate enum FlightApiServicesEndPoints: APIService {
    //Define cases according to API's
    case book(_ parameters: [String: Any])
    case comment(_ parameters: [String: Any])
    case getAllFlightBookings
    case getCurrentFlightBooking
    case getPastFlightBookings
    case getUpcomingFlightBooking
    case getFlightSearch(_ parameters: [String: Any])
    case createStripeCustomer
    case createPaymentInetent(_ parameters: [String: Any])
    case createEphemeralKey(_ parameters: [String: Any])
    case createOrder(_ parameters: [String: Any])
    case searchCity(_ city: String)
    case recentSearch(_ searchType: String)
    case createFareSummary(_ parameters: [String: Any])
    case getFlightDetails(_ id: String, _ dataSource:String)
    case getFlightDetailsModel(_ model :[String: Any]?)
    case getAirlineDetails(_ airLineCode:String)
    case getAirportName (_ search : String)
    //Return path according to api case
    var path: String {
        switch self {
        case .book:
            return AppConstants.Urls.apiBaseUrl + "api/flight/book"
            
        case .comment:
            return AppConstants.Urls.apiBaseUrl + "api/flight/comment"

        case .getAllFlightBookings:
            return AppConstants.Urls.apiBaseUrl + "api/bookings/flights"
            
        case .getCurrentFlightBooking:
            return AppConstants.Urls.apiBaseUrl + "api/flight/ongoing"

        case .getPastFlightBookings:
            return AppConstants.Urls.apiBaseUrl + "api/bookings/past/flight"

        case .getUpcomingFlightBooking:
            return AppConstants.Urls.apiBaseUrl + "api/bookings/upcoming/flight"
            
        case .getFlightSearch:
            return AppConstants.Urls.apiBaseUrl + "api/search-flights" //AppConstants.Urls.exnternalApiUrl
        case .getFlightDetails(let id , let dataSource):
            return AppConstants.Urls.apiBaseUrl + "api/flight-details?id=\(id)&data_source=\(dataSource)"
        case .recentSearch(let search):
            return AppConstants.Urls.apiBaseUrl + "api/recent-search-history?search_type=\(search)"
            //"api/search-flights"
        case .createStripeCustomer:
            return AppConstants.Urls.stripeAPI + "customers"

        case .createPaymentInetent:
            return AppConstants.Urls.stripeAPI + "payment_intents" //AppConstants.Urls.apiBaseUrl + "api/stripe/create-intent"

        case .createEphemeralKey:
            return AppConstants.Urls.stripeAPI + "ephemeral_keys" //AppConstants.Urls.apiBaseUrl + "api/stripe/ephemeral-key"

        case .createOrder:
            return "http://ec2-34-220-61-139.us-west-2.compute.amazonaws.com:8085/"

        case .searchCity(let city):
            return  AppConstants.Urls.apiBaseUrl + "api/search-airport?search=" + city //"http://ec2-34-220-61-139.us-west-2.compute.amazonaws.com:8888/?loc_name=\(city)"

        case .createFareSummary:
            return "http://ec2-34-220-61-139.us-west-2.compute.amazonaws.com:8081/"
        case .getAirlineDetails(let code):
            return AppConstants.Urls.apiBaseUrl + "api/airline-details?airline_code=" + code
        case .getFlightDetailsModel:
            return AppConstants.Urls.apiBaseUrl + "api/flight-details"
        case .getAirportName(let code):
            return AppConstants.Urls.apiBaseUrl + "api/search-airport?airport_code=" + code

        }
   
    }
    
    //Return resource according to api case
    var resource: Resource {
      print("Bearer \(AppCache.shared.authToken ?? "")")
        var headers: [String: Any] = [
            "Content-Type": "application/json",
            "Authorization": "Bearer \(AppCache.shared.authToken ?? "")"
        ]
        
        switch self {
        case .book(let params):

            let boundary = "Boundary-\(UUID().uuidString)"
            let newHeaders: [String: Any] = [
                "Accept": "application/json",
                "Authorization": "Bearer \(AppCache.shared.authToken ?? "")",
                "Content-Type": "multipart/form-data; boundary=\(boundary)"
            ]
            return Resource(method: .post, parameters: params, encoding: .QUERY, headers: newHeaders, validator: APIDataResultValidator(), responseType: .data)

        case .comment(let params):
            return Resource(method: .post, parameters: params, encoding: .QUERY, headers: headers, validator: APIDataResultValidator(), responseType: .data)

        case .getAllFlightBookings:
            return Resource(method: .get, parameters: nil, encoding: .QUERY, headers: headers, validator: APIDataResultValidator(), responseType: .data)

        case .getCurrentFlightBooking:
            return Resource(method: .get, parameters: nil, encoding: .QUERY, headers: headers, validator: APIDataResultValidator(), responseType: .data)

        case .getPastFlightBookings:
            return Resource(method: .get, parameters: nil, encoding: .QUERY, headers: headers, validator: APIDataResultValidator(), responseType: .data)
            
        case .getUpcomingFlightBooking:
            return Resource(method: .get, parameters: nil, encoding: .QUERY, headers: headers, validator: APIDataResultValidator(), responseType: .data)
            
        case .getFlightSearch(let params):
            return Resource(method: .post, parameters: params, encoding: .QUERY, headers: headers, validator: APIDataResultValidator(), responseType: .data)
        case .getFlightDetailsModel(let params):
            return Resource(method: .post, parameters: params, encoding: .QUERY, headers: headers, validator: APIDataResultValidator(), responseType: .data)

        case .createStripeCustomer:

            let username = AppConstants.Urls.stripeSecretKey
            let password = ""
            let loginString = String(format: "%@:%@", username, password)
            let loginData = loginString.data(using: String.Encoding.utf8)!
            let base64LoginString = loginData.base64EncodedString()

            headers["Authorization"] = "Basic \(base64LoginString)"

            return Resource(method: .post, parameters: nil, encoding: .QUERY, headers: headers, validator: APIDataResultValidator(), responseType: .data)

        case .createPaymentInetent(let params):

            let username = AppConstants.Urls.stripeSecretKey
            let password = ""
            let loginString = String(format: "%@:%@", username, password)
            let loginData = loginString.data(using: String.Encoding.utf8)!
            let base64LoginString = loginData.base64EncodedString()

            headers["Authorization"] = "Basic \(base64LoginString)"

            return Resource(method: .post, parameters: params, encoding: .QUERY, headers: headers, validator: APIDataResultValidator(), responseType: .data)

        case .createEphemeralKey(let params):

            let username = AppConstants.Urls.stripeSecretKey
            let password = ""
            let loginString = String(format: "%@:%@", username, password)
            let loginData = loginString.data(using: String.Encoding.utf8)!
            let base64LoginString = loginData.base64EncodedString()

            headers["Authorization"] = "Basic \(base64LoginString)"
            headers["Stripe-Version"] = "2020-08-27"

            return Resource(method: .post, parameters: params, encoding: .QUERY, headers: headers, validator: APIDataResultValidator(), responseType: .data)

        case .createOrder(let params):

            let newHeaders: [String: Any] = [
                "Content-Type": "application/json"
            ]

            return Resource(method: .get, parameters: params, encoding: .QUERY, headers: newHeaders, validator: APIDataResultValidator(), responseType: .data)

        case .searchCity,.recentSearch,.getAirlineDetails,.getFlightDetails,.getAirportName:
            return Resource(method: .get, parameters: nil, encoding: .QUERY, headers: headers, validator: APIDataResultValidator(), responseType: .data)
 
        case .createFareSummary(let params):

            let newHeaders: [String: Any] = [
                "Content-Type": "application/json"
            ]

            return Resource(method: .get, parameters: params, encoding: .QUERY, headers: newHeaders, validator: APIDataResultValidator(), responseType: .data)
        }
    }
}

struct FlightApiServices {
    
    func book(_ parameters: [String: Any], completionBlock: @escaping ApiResponseCompletion) {
        FlightApiServicesEndPoints.book(parameters).urlRequest(completionBlock: completionBlock)
    }
    
    func comment(_ parameters: [String: Any], completionBlock: @escaping ApiResponseCompletion) {
        FlightApiServicesEndPoints.comment(parameters).urlRequest(completionBlock: completionBlock)
    }
    
    func getAllFlightBookings(completionBlock: @escaping ApiResponseCompletion) {
        FlightApiServicesEndPoints.getAllFlightBookings.request(completionBlock: completionBlock)
    }
    
    func getCurrentFlightBooking(completionBlock: @escaping ApiResponseCompletion) {
        FlightApiServicesEndPoints.getCurrentFlightBooking.request(completionBlock: completionBlock)
    }
    
    func getPastFlightBookings(completionBlock: @escaping ApiResponseCompletion) {
        FlightApiServicesEndPoints.getPastFlightBookings.request(completionBlock: completionBlock)
    }
    
    func getUpcomingFlightBooking(completionBlock: @escaping ApiResponseCompletion) {
        FlightApiServicesEndPoints.getUpcomingFlightBooking.request(completionBlock: completionBlock)
    }
    
    func getFlightSearch(_ parameters: [String: Any], completionBlock: @escaping ApiResponseCompletion) {
        FlightApiServicesEndPoints.getFlightSearch(parameters).request(completionBlock: completionBlock)
    }

    func createStripeCustomer(completionBlock: @escaping ApiResponseCompletion) {
        FlightApiServicesEndPoints.createStripeCustomer.request(completionBlock: completionBlock)
    }

    func createPaymentInetent(_ parameters: [String: Any], completionBlock: @escaping ApiResponseCompletion) {
        FlightApiServicesEndPoints.createPaymentInetent(parameters).request(completionBlock: completionBlock)
    }

    func createEphemeralKey(_ parameters: [String: Any], completionBlock: @escaping ApiResponseCompletion) {
        FlightApiServicesEndPoints.createEphemeralKey(parameters).request(completionBlock: completionBlock)
    }

    func createOrder(_ parameters: [String: Any], completionBlock: @escaping ApiResponseCompletion) {
        FlightApiServicesEndPoints.createOrder(parameters).request(completionBlock: completionBlock)
    }

    func searchCity(_ city: String, completionBlock: @escaping ApiResponseCompletion) {
        FlightApiServicesEndPoints.searchCity(city).request(completionBlock: completionBlock)
    }
    func getFlightDetails(_ id: String, _ sourceData:String, completionBlock: @escaping ApiResponseCompletion) {
        FlightApiServicesEndPoints.getFlightDetails(id, sourceData).request(completionBlock: completionBlock)
    }
    
    func getFlightDetailsModel( _ parameters: [String: Any], completionBlock: @escaping ApiResponseCompletion) {
        FlightApiServicesEndPoints.getFlightDetailsModel(parameters).request(completionBlock: completionBlock)
    }
    func getAirlineDetails(_ code: String, completionBlock: @escaping ApiResponseCompletion) {
        FlightApiServicesEndPoints.getAirlineDetails(code).request(completionBlock: completionBlock)
    }
    func getAirportName(_ search: String, completionBlock: @escaping ApiResponseCompletion) {
        FlightApiServicesEndPoints.getAirportName(search).request(completionBlock: completionBlock)
    }
    func recentSearchCity(_ sreachType: String, completionBlock: @escaping ApiResponseCompletion) {
        FlightApiServicesEndPoints.recentSearch(sreachType).request(completionBlock: completionBlock)
    }
    func createFareSummary(_ parameters: [String: Any], completionBlock: @escaping ApiResponseCompletion) {
        FlightApiServicesEndPoints.createFareSummary(parameters).request(completionBlock: completionBlock)
    }

    static func getPostString(params:[String:Any]) -> String
        {
            var data = [String]()
            for(key, value) in params
            {
                data.append(key + "=\(value)")
            }
            return data.map { String($0) }.joined(separator: "&")
        }
}


//
//  APIResultValidator.swift
//  Pneuma
//
//  Created by Jatin on 22/09/20.
//  Copyright © 2021 Jatin. All rights reserved.
//

import Foundation
import UIKit

struct ApiResponseSuccessBlock{
    var message: String
    var statusCode: Int
    var resultData: Any?
    var error: ApiResponseErrorBlock?
}

struct ApiResponseErrorBlock: Error {
    var message: String
  //  var statusCode: String
}

typealias ApiResponseCompletion = ((Result<ApiResponseSuccessBlock, ApiResponseErrorBlock>) -> ())
typealias SocketResponseCompletion = ((Result<[String: Any], ApiResponseErrorBlock>) -> ())

protocol APIResultValidatorApi{
    func validateResponse(statusCode: Int, response: Any?, completionBlock: @escaping ApiResponseCompletion)
    func getApiError(result:String?) -> ApiResponseErrorBlock
    func getApiResponse(result:Any?, statusCode: Int) -> ApiResponseSuccessBlock
}

extension APIResultValidatorApi{
    
    func getApiError(result:String?) -> ApiResponseErrorBlock{
        let apiError = ApiResponseErrorBlock.init(message: result ?? "Error description not available")
        return apiError
    }
    
    func getApiResponse(result:Any?, statusCode: Int) -> ApiResponseSuccessBlock{
        var apiResponse = ApiResponseSuccessBlock.init(message: "", statusCode: statusCode, resultData: result)
        if let responseDict = result as? [String:AnyObject] {
            print("responseDict:",responseDict)
            if let msg = responseDict["message"] as? String {
                apiResponse.message = msg
            }

            apiResponse.resultData = responseDict as Any
        }
        return apiResponse
    }
}

struct APIJSONResultValidator: APIResultValidatorApi{
    
    func validateResponse(statusCode: Int, response: Any?, completionBlock: @escaping ApiResponseCompletion) {

        if statusCode == 200 || statusCode == 0  {
            if let response = response  as? [String: Any] { //For response as dictionary
                print("responseDict:",response)
                completionBlock(.success(self.getApiResponse(result: response, statusCode: statusCode)))
            } else if let response = response as? [[String: Any]] { //For response as array of dictionary
                print("responseDict:",response)
                completionBlock(.success(self.getApiResponse(result: response, statusCode: statusCode)))
            } else {
                Toast.shared.showAlert(type: AlertType.apiFailure, message: "Invalid JSON. Line: 63. Class: APIResultValidator")
              
                completionBlock(.failure(self.getApiError(result: "Invalid JSON. Line: 63. Class: APIResultValidator")))
            }
        } else {
            if let response = response  as? [String: Any] {
                let message = response["message"] as? String ?? LocalizedStringEnum.somethingWentWrong.localized
                Toast.shared.showAlert(type: .apiFailure, message: message)
              
                completionBlock(.failure(self.getApiError(result: message)))
            }else {
                Toast.shared.showAlert(type: .apiFailure, message: "Invalid JSON. Line: 70. Class: APIResultValidator")
                completionBlock(.failure(self.getApiError(result: "Invalid JSON. Line: 70. Class: APIResultValidator")))
            }
        }
    }
}

struct APIDataResultValidator: APIResultValidatorApi {
    
    func validateResponse(statusCode: Int, response: Any?, completionBlock: @escaping ApiResponseCompletion) {
        CustomLoader.shared.hide()
        var jsonResponse: [String: Any]?
        
        if let data = response as? Data {
            do {
                jsonResponse = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
                debugPrint("API response is: ", jsonResponse ?? [:])
            }catch {
                debugPrint("Error converting data to JSON: ", error.localizedDescription)
            }
        }
        
        if statusCode == 200 || statusCode == 201 || statusCode == 0  {
            if jsonResponse != nil {
                var apiResponse = self.getApiResponse(result: jsonResponse, statusCode: statusCode)
                apiResponse.resultData = response
                completionBlock(.success(apiResponse))
            }else {
                Toast.shared.showAlert(type: .apiFailure, message: "Invalid JSON. Line: 97. Class: APIResultValidator")
                completionBlock(.failure(self.getApiError(result: "Invalid JSON. Line: 97. Class: APIResultValidator")))
            }
        } else {
            if jsonResponse != nil {
                let message = jsonResponse?["message"] as? String ?? LocalizedStringEnum.somethingWentWrong.localized
                Toast.shared.showAlert(type: AlertType.apiFailure, message: message)
                completionBlock(.failure(self.getApiError(result: message)))
            }else {
                Toast.shared.showAlert(type: .apiFailure, message: "Invalid JSON. Line: 104. Class: APIResultValidator")
                completionBlock(.failure(self.getApiError(result: "Invalid JSON. Line: 104. Class: APIResultValidator")))
            }
        }
    }
    
}

//
//  OnboardingQuestionsApiServices.swift
//  Pneuma
//
//  Created by MacBook Pro on 28/10/21.
//  Copyright © 2021 Jatin. All rights reserved.
//

import Foundation

fileprivate enum OnboardingQuestionsApiServicesEndPoints: APIService {
    //Define cases according to API's
    case getAllQuestions
    case storeAnswers(_ parameters: [String: Any])
    case getAllAnswers
    
    //Return path according to api case
    var path: String {
        switch self {
        case .getAllQuestions:
            return AppConstants.Urls.apiBaseUrl + "api/get-signup-questions"
        case .storeAnswers:
            return AppConstants.Urls.apiBaseUrl + "api/save-signup-answers"
            //"api/store/answer"
            
        case .getAllAnswers:
            return AppConstants.Urls.apiBaseUrl + "api/get-signup-answers"
            //"api/onboarding/answers"
    }
}
    
    //Return resource according to api case
    var resource: Resource {
        
        let headers: [String: Any] = [
            "Content-Type": "application/json",
            "Authorization": "Bearer \(AppCache.shared.authToken ?? "")"
        ]
        
        switch self {
        case .getAllQuestions:
            return Resource(method: .get, parameters: nil, encoding: .QUERY, headers: headers, validator: APIDataResultValidator(), responseType: .data)
        case .storeAnswers(let params):
            return Resource(method: .post, parameters: params, encoding: .FORM, headers: headers, validator: APIDataResultValidator(), responseType: .data)
        case .getAllAnswers:
            let nHeaders: [String: Any] = [
                "Accept": "application/json",
                "Authorization": "Bearer \(AppCache.shared.authToken ?? "")"
            ]
            print(nHeaders)
            return Resource(method: .get, parameters: nil, encoding: .QUERY, headers: nHeaders, validator: APIDataResultValidator(), responseType: .data)
        }
        
    }
    
}

struct OnboardingQuestionsApiServices {
    
    func getAllQuestions(completionBlock: @escaping ApiResponseCompletion) {
        OnboardingQuestionsApiServicesEndPoints.getAllQuestions.request(completionBlock: completionBlock)
    }
    func storeAnswers(_ parameters: [String: Any], completionBlock: @escaping ApiResponseCompletion) {
        OnboardingQuestionsApiServicesEndPoints.storeAnswers(parameters).urlRequest(completionBlock: completionBlock)
    }
    func getAllAnswers(completionBlock: @escaping ApiResponseCompletion) {
        OnboardingQuestionsApiServicesEndPoints.getAllAnswers.request(completionBlock: completionBlock)
    }
    
}

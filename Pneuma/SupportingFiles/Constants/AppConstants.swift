//
//  AppConstants.swift
//  Pneuma
//
//  Created by Chitra on 24/02/21.
//  Copyright © 2021 iTechnolabs. All rights reserved.
//

import Foundation

enum APIEnvironment{
    case development
    case production
    case staging
}

struct AppConstants {
    //App environment
    static let environment: APIEnvironment = .development
    static let deviceType = 1 // 0 for android, 1 for ios
    
    //Base url
    struct Urls {
        static var apiBaseUrl: String {
            switch AppConstants.environment {
            case .development:
                return "http://34.200.242.60/"
//                return "http://ec2-3-145-217-61.us-east-2.compute.amazonaws.com/"//"http://ec2-18-220-40-34.us-east-2.compute.amazonaws.com/"//"http://ec2-3-143-181-81.us-east-2.compute.amazonaws.com/"
            case .production:
                return "http://ec2-3-145-217-61.us-east-2.compute.amazonaws.com/"//"http://ec2-18-220-40-34.us-east-2.compute.amazonaws.com/"//"http://ec2-3-143-181-81.us-east-2.compute.amazonaws.com/"
            case .staging:
                return "http://ec2-3-145-217-61.us-east-2.compute.amazonaws.com/"//"http://ec2-18-220-40-34.us-east-2.compute.amazonaws.com/"//"http://ec2-3-143-181-81.us-east-2.compute.amazonaws.com/"
            }
        }
        
        //FIXME:- Replace with valid urls
        static var aboutUsUrl: String {
//            return "\(AppConstants.Urls.apiBaseUrl)/about-us"
            return "https://www.google.com"
        }
        
        static var termsUrl: String {
//            return "\(AppConstants.Urls.apiBaseUrl)/terms-and-condition"
            return "https://www.google.com"
        }
        
        static var privacyUrl: String {
//            return "\(AppConstants.Urls.apiBaseUrl)/privacy-policy"
            return "https://www.google.com"
        }

        static var exnternalApiUrl : String {
            return "http://ec2-34-220-61-139.us-west-2.compute.amazonaws.com:8000/"
        }

        static var externalHotelSearchUrl : String {
            return "http://ec2-34-220-61-139.us-west-2.compute.amazonaws.com:5555/"
        }

        static var stripeAPI: String {
            return "https://api.stripe.com/v1/"
        }

        static var stripePublishableKey:  String {
            //return "pk_live_EfzgP09PReug4nCQKVjFi8Y600WNDHNZji" //Live
            return "pk_test_s8vCjjvL2VXnLli30tMI9gSG006t0YXBst" //Test
         }

        static var stripeSecretKey:  String {
            //return "sk_live_OmQxcTFtXFfUmAP2erjcrCMK00ru7RaSqr" //Live
            return "sk_test_qlgTeG1YEc8zLqaDQhbJr6Te00pY5mZBgR" //Test
        }
        
        static var checkCharge: String {
            return "https://loveworldnext.space/"
        }
    }
    
    //FIXME:- development mode uses another projects API Key
    static var kGoogleAPIKey: String {
        switch AppConstants.environment {
        case .development:
            return "AIzaSyDRZ71eKOvpHVZ7IzRrb2PVBEIO8ejtKB4"
        case .staging:
            return "AIzaSyDF9mTSVWN6xWuEe2sSICcZSCBKKCII8cY"
        case .production:
            return "AIzaSyDF9mTSVWN6xWuEe2sSICcZSCBKKCII8cY"
        }
    }
    
    //User default keys
    struct UserDefault {
        static let currentUser = "currentUser"
        static let authToken = "authToken"
        static let walkthroughShown = "walkthroughShown"
        static let initialQuestionsAnswered = "initialQuestionsAnswered"
    }
}

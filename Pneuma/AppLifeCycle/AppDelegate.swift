//
//  AppDelegate.swift
//  Pneuma
//
//  Created by Chitra on 24/02/21.
//  Copyright © 2021 iTechnolabs. All rights reserved.
//

import UIKit

import AWSCore
import AWSMobileClient
import AWSLex
import Firebase
import Stripe

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var networkAlertLabel: UILabel?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        self.initializeLibraries()
        let credentialProvider = AWSCognitoCredentialsProvider(regionType: .USWest2, identityPoolId: "us-west-2:15fbad0c-4a8c-4336-9e71-58b1106bd518")
        let configuration = AWSServiceConfiguration(region: .USWest2, credentialsProvider: credentialProvider)
        
        AWSServiceManager.default().defaultServiceConfiguration = configuration
        
        let chatConfig = AWSLexInteractionKitConfig.defaultInteractionKitConfig(withBotName: "BookTrip", botAlias: "$LATEST")
        AWSLexInteractionKit.register(with: configuration!, interactionKitConfiguration: chatConfig, forKey: "AWSLexVoiceButton")
        chatConfig.autoPlayback = true
        AWSLexInteractionKit.register(with: configuration!, interactionKitConfiguration: chatConfig, forKey: "chatConfig")
        //self.setRootVC()
        FirebaseApp.configure()
        return true
    }

    // This method handles opening native URLs (for example, "your-app://")
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey: Any] = [:]) -> Bool {
        let stripeHandled = StripeAPI.handleURLCallback(with: url)
        if (stripeHandled) {
            return true
        } else {
            // This was not a stripe url – do whatever url handling your app
            // normally does, if any.
        }
        return false
    }

    // This method handles opening universal link URLs (for example, "https://example.com/stripe_ios_callback")
    func application(_ application: UIApplication, continue userActivity: NSUserActivity, restorationHandler: @escaping ([UIUserActivityRestoring]?) -> Void) -> Bool {
        if userActivity.activityType == NSUserActivityTypeBrowsingWeb {
            if let url = userActivity.webpageURL {
                let stripeHandled = StripeAPI.handleURLCallback(with: url)
                if (stripeHandled) {
                    return true
                } else {
                    // This was not a stripe url – do whatever url handling your app
                    // normally does, if any.
                }
            }
        }
        return false
    }

}


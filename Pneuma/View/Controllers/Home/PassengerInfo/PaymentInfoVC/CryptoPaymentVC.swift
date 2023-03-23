//
//  CryptoPaymentVC.swift
//  Pneuma
//
//  Created by Jatin on 22/03/22.
//  Copyright © 2022 Jatin. All rights reserved.
//

import UIKit
import WebKit

class CryptoPaymentVC: UIViewController {

    //MARK: - Outlets
    @IBOutlet var webView: WKWebView!
    
    //MARK: - Variables
    var chargeID : String!
    var hostedUrl : String!
    
    //MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        webView.load(URLRequest(url:(URL(string: hostedUrl))!))
        callAPI(chargeID: chargeID)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //checkCharge
        callAPI(chargeID: chargeID)
    }

    //MARK: - Button Action Methods
    @IBAction func btnBack(_ sender: Any) {
        
    }
    
    //MARK: - Call API
    func callAPI(chargeID: String) {

        guard let serviceUrl = URL(string: AppConstants.Urls.checkCharge + chargeID) else { return }
        var request = URLRequest(url:serviceUrl)
        request.httpMethod = "GET"
        let session = URLSession.shared
        session.dataTask(with: request) { (data, response, error) in
            DispatchQueue.main.async {
                if let response = response {
                    print(response)
                    if let httpResponse = response as? HTTPURLResponse {
                        print("Full HTTP Response: \(httpResponse)")
                        print("StatusCode : \(httpResponse.statusCode)")
                        print("StatusMessage : \(HTTPURLResponse.localizedString(forStatusCode: httpResponse.statusCode))")
                        DispatchQueue.main.async {
                            if httpResponse.statusCode == 201 || httpResponse.statusCode == 200 {

                            }else {

                            }
                        }
                    }
                }
                if let data = data {
                    print(data)
                    print(String(data: data, encoding: .utf8))
                }
            }
        }.resume()
    }
}

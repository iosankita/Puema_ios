//
//  IntroVC.swift
//  Pneuma
//
//  Created by MacBook Pro on 2/11/21.
//  Copyright © 2021 Jatin. All rights reserved.
//

import UIKit
import AVFoundation

class IntroVC: UIViewController {
    
    @IBOutlet weak var splashImageView: UIImageView!
    var player : AVPlayer?

    override func viewDidLoad() {
        super.viewDidLoad()
        

        // Do any additional setup after loading the view.
    }
    
    private func loadVideo() {
        do {
            try AVAudioSession.sharedInstance().setCategory(AVAudioSession.Category.ambient)
            } catch { }

        let path = Bundle.main.path(forResource: "VID-20210825-WA0005", ofType:"mp4")

        player = AVPlayer.init(url: URL(fileURLWithPath: path!))
        let playerLayer = AVPlayerLayer(player: player)
        

        playerLayer.frame = self.view.frame
        playerLayer.videoGravity = AVLayerVideoGravity.resizeAspectFill
        playerLayer.zPosition = -1
        //splashImageView.isHidden = true

        
        
        NotificationCenter.default.addObserver(self, selector: #selector(playerDidFinishPlaying), name: .AVPlayerItemDidPlayToEndTime, object: nil)

        player?.seek(to: CMTime.zero)
        
        player?.play()
        self.splashImageView.layer.addSublayer(playerLayer)
        
        
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        loadVideo()
        
    }
    @objc func playerDidFinishPlaying(note: NSNotification) {
        print("Video Finished")
        setRootVC()
    }
    
    deinit {
        self.removeNotificationObserver(name: .AVPlayerItemDidPlayToEndTime)
    }
    
    func setRootVC() {
        if AppCache.shared.authToken != nil && AppCache.shared.currentUser != nil {
            
            print("LOGIN TOKEN: Bearer \(AppCache.shared.authToken ?? "")")
            
            if !(AppCache.shared.isInitialQuestionAnswered) {
                self.setSplashRoot()
            } else {
                self.setHomeRoot()
            }
            
        } else if !(AppCache.shared.isWalkthroughShown) {
            self.setWelcomeRoot()
        } else {
            self.setLoginRoot()
        }
    }
    
    private func setLoginRoot() {
        let vc = UIStoryboard.loadLoginVC()
//        let vc = UIStoryboard.loadDiscoverRouteVC()
        let nc = UINavigationController(rootViewController: vc)
        nc.setNavigationBarHidden(true, animated: false)
        UIApplication.shared.delegate?.window??.rootViewController = nc
    }

    private func setWelcomeRoot() {
        let vc = UIStoryboard.loadWelcomeVC()
        let nc = UINavigationController(rootViewController: vc)
        nc.setNavigationBarHidden(true, animated: false)
        UIApplication.shared.delegate?.window??.rootViewController = nc
    }
    
    private func setHomeRoot() {
        if let date = UserDefaults.standard.value(forKey: "chargeDate") as? Date, let earlyDate = Calendar.current.date(byAdding: .hour, value: 1, to: date) ?? Date(), earlyDate > Date(){
            if let data = UserDefaults.standard.data(forKey: "chargeResponse"){
                do {
                    // Create JSON Decoder
                    let decoder = JSONDecoder()

                    // Decode carSubData
                    let chargeResponse = try decoder.decode(ChargeResponse.self, from: data)
                    
                    callAPI(chargeID: chargeResponse.data?.id ?? "", chargeResponse:chargeResponse)
                } catch {
                    print("Unable to Decode Note (\(error))")
                }
            }
        }else {
            UserDefaults.standard.removeObject(forKey: "chargeDate")
            UserDefaults.standard.removeObject(forKey: "chargeResponse")
            UserDefaults.standard.removeObject(forKey: "passengerList")
            UserDefaults.standard.synchronize()
            let vc = UIStoryboard.loadHomeVC()
            let nc = UINavigationController(rootViewController: vc)
            nc.setNavigationBarHidden(true, animated: false)
            UIApplication.shared.delegate?.window??.rootViewController = nc
        }
    }
    
    private func setSplashRoot() {
        let vc = UIStoryboard.loadSplashVC()
        let nc = UINavigationController(rootViewController: vc)
        nc.setNavigationBarHidden(true, animated: false)
        UIApplication.shared.delegate?.window??.rootViewController = nc
    }
    
    //MARK: - Call API
    func callAPI(chargeID: String, chargeResponse:ChargeResponse) {

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
                    do {
                        let chargeTransaction = try? JSONDecoder().decode(Charge.self, from: data)
                        print(chargeTransaction)
                        if chargeTransaction![0].type == "charge:failed" {
                            UserDefaults.standard.removeObject(forKey: "chargeDate")
                            UserDefaults.standard.removeObject(forKey: "chargeResponse")
                            UserDefaults.standard.removeObject(forKey: "passengerList")
                            UserDefaults.standard.synchronize()
                            let vc = UIStoryboard.loadHomeVC()
                            let nc = UINavigationController(rootViewController: vc)
                            nc.setNavigationBarHidden(true, animated: false)
                            UIApplication.shared.delegate?.window??.rootViewController = nc
                        }else {
                            let vc = UIStoryboard.loadCryptoPaymentVC()
                            vc.chargeID = chargeResponse.data?.id ?? ""
                            vc.hostedUrl = chargeResponse.data?.hostedurl ?? ""
                            let nc = UINavigationController(rootViewController: vc)
                            nc.setNavigationBarHidden(true, animated: false)
                            UIApplication.shared.delegate?.window??.rootViewController = nc
                        }
                    } catch let error {
                        print(error.localizedDescription)
                        UserDefaults.standard.removeObject(forKey: "chargeDate")
                        UserDefaults.standard.removeObject(forKey: "chargeResponse")
                        UserDefaults.standard.removeObject(forKey: "passengerList")
                        UserDefaults.standard.synchronize()
                        let vc = UIStoryboard.loadHomeVC()
                        let nc = UINavigationController(rootViewController: vc)
                        nc.setNavigationBarHidden(true, animated: false)
                        UIApplication.shared.delegate?.window??.rootViewController = nc
                    }
                }
            }
        }.resume()
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

//   let welcome = try? newJSONDecoder().decode(ChargeTransaction.self, from: jsonData)

// MARK: - ChargeTransaction
struct ChargeTransaction: Codable {
    let id: Int
    let eventID, type, chargeID, chargeCode: String

    enum CodingKeys: String, CodingKey {
        case id = "ID"
        case eventID = "eventId"
        case type
        case chargeID = "chargeId"
        case chargeCode
    }
}

typealias Charge = [ChargeTransaction]

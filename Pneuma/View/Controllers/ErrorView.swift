//
//  ErrorView.swift
//  Peyza
//
//  Created by Chitresh Goyal on 22/05/20.
//  Copyright © 2021 CodebrewLabs. All rights reserved.
//

import UIKit
import Lottie

enum NoDataType {
    case NoRequests
  //  case NoAddress
   // case NoCart
  //  case NoData

    var property: (mainTitle: VCLiteral, desc: VCLiteral, img: UIImage) {
        switch self {
        case .NoRequests:
            return (.ErrorTitle, .ErrorDecs, #imageLiteral(resourceName: "ic_logo"))
        }
    }
}

class ErrorView: UIView {
    @IBOutlet weak var lottieView: UIView!
    @IBOutlet weak var lblText: UILabel!
    @IBOutlet weak var btn: UIButton!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var imgView: UIImageView!
    
    private var btnTapped: (() -> Void)?
    private let animationView = AnimationView()
    
    private lazy var uploadingAnimation: AnimationView = {
        let anView = AnimationView()
        anView.backgroundColor = UIColor.clear
        anView.animation = Animation.named(LottieFiles.Uploading.getFileName(), bundle: .main, subdirectory: nil, animationCache: nil)
        anView.loopMode = .loop
        anView.contentMode = .scaleAspectFit
        return anView
    }()
    
    
    @IBAction func btnAction(_ sender: UIButton) {
        animationView.stop()
        animationView.removeFromSuperview()
        btnTapped?()
    }
    
    public func showNoDataWithImage(type: NoDataType) {
        btn.isHidden = true
        lottieView.isHidden = true
        imgView.isHidden = false
        lblText.isHidden = false
        lblTitle.isHidden = false
        lblTitle.text = type.property.mainTitle.localized
        lblText.text = type.property.desc.localized
        imgView.image = type.property.img
    }
    
    public func handleErrorView(animation: LottieFiles, text: String?, btnTitle: String?, _btnTapped: (() -> Void)?) {
        lottieView.isHidden = false
        lblText.isHidden = false
        btn.isHidden = false
        lblTitle.isHidden = false
        imgView.isHidden = true
        
        btnTapped = _btnTapped
        lblText.text = /text
        btn.setTitle(/btnTitle, for: .normal)
        lottieView.backgroundColor = UIColor.clear
        lblTitle.text = ""
        
        lottieView.subviews.forEach({
            $0.removeFromSuperview()
        })
        
        animationView.backgroundColor = UIColor.clear
        animationView.animation = Animation.named(animation.getFileName(), bundle: .main, subdirectory: nil, animationCache: nil)
        animationView.loopMode = .loop
        animationView.contentMode = .scaleAspectFit
        
        let frameAnimation = self.lottieView.bounds
        let widthHeight = UIScreen.main.bounds.width - (80.0 * 2)
        animationView.frame = CGRect.init(x: frameAnimation.minX, y: frameAnimation.minY, width: widthHeight, height: widthHeight)
        let widthOfLottieView = UIScreen.main.bounds.width - (32.0 * 2)
        let heightOfLottieView = 0.75 * widthOfLottieView
        animationView.center = CGPoint.init(x: widthOfLottieView / 2, y: heightOfLottieView / 2)
        lottieView.addSubview(animationView)
        animationView.play()
    }
}
enum VCLiteral: String {
    
    case ErrorTitle = "No Requests";
    case ErrorDecs = "Unfortunately we don't have any request to show you here";
    var localized: String {
        return self.rawValue
        //language(key: self.rawValue)
    }
 
}

//
//  Image+Extension.swift
//  Pneuma
//
//  Created by Chitra on 24/02/21.
//  Copyright © 2021 iTechnolabs. All rights reserved.
//

import UIKit
import Kingfisher

extension UIImageView {
    ///Download and show the image on image view from the given url/
    func setImageWithKF(_ imageURLString: String?, completion: ((UIImage?) -> ())? = nil) {
        if let imageURL = imageURLString,
            let url = URL(string: imageURL) {
            let resource = ImageResource(downloadURL: url)
            var kf = self.kf
            kf.indicatorType = .activity
            kf.setImage(with: resource, placeholder: UIImage(named: "placeholderImage"), options: [.transition(.fade(1)), .cacheOriginalImage], completionHandler: { result in
                switch result {
                case .success(let imageResult):
                    completion?(imageResult.image)
                case .failure(let error):
                    debugPrint(error.localizedDescription)
                    completion?(nil)
                }
            })
        }else {
            completion?(nil)
        }
    }
    
    ///Firstly download & show the thumbnail on image view from the given thunbnailUrlString. After that automatically download & show the image from the imageUrlString.
    func setImageWith(thunbnailUrlString: String?, imageUrlString: String?, completion: ((Bool) -> ())? = nil) {

        if let urlString = thunbnailUrlString, urlString != "" {
            guard let url = URL.init(string: urlString) else {
                return
            }
            let resource = ImageResource(downloadURL: url)
            var kf = self.kf
            kf.indicatorType = .activity
            self.kf.setImage(with: resource, placeholder: #imageLiteral(resourceName: "placeholderImage"), options: [.transition(.fade(1)), .cacheOriginalImage]){ [weak self] (result) in
                switch result {
                    
                case .success(_):
                    if let urlString = imageUrlString, urlString != "" {
                        self?.getFullImageAndSet(with: urlString) { [weak self] (image) in
                            completion?(true)
                        }
                    }else {
                        completion?(true)
                    }
                case .failure(_):
                    completion?(false)
                }
            }
        }else if let urlString = imageUrlString, urlString != "" {
            self.getFullImageAndSet(with: urlString) { [weak self] (image) in
                completion?(true)
            }
        }else {
            completion?(false)
        }
    }
    
    private func getFullImageAndSet(with urlString: String, completion: @escaping (UIImage?) -> ()) {

        if urlString == "" {
            return
        }
        
        guard let url = URL.init(string: urlString) else {
            return
        }
        let resource = ImageResource(downloadURL: url)
        let tempImageView = UIImageView()
        tempImageView.kf.setImage(with: resource, options: [.cacheOriginalImage]){ (result) in
            switch result {
                
            case .success(_):
                completion(tempImageView.image)
                if let image = tempImageView.image {
                    UIView.transition(with: self, duration: 0.50, options: .transitionCrossDissolve, animations: {
                        self.image = image
                    }, completion: nil)
                }
            case .failure(_):
                completion(nil)
            }
        }
    }
    
}

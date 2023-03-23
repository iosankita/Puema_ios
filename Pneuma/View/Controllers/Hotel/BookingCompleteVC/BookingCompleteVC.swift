//
//  BookingCompleteVC.swift
//  Pneuma
//
//  Created by Jatin on 03/03/21.
//  Copyright © 2021 Jatin. All rights reserved.
//

import UIKit

class BookingCompleteVC: UIViewController {

    // MARK: - IBOUTLETS
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var currencyTypeLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    
    @IBOutlet weak var hotelImageView: UIImageView!
    @IBOutlet weak var ratingView: HCSStarRatingView!
    @IBOutlet weak var navigation: CustomNavigationView!
    @IBOutlet weak var containerView: UIView!
    
    // MARK: - VARIABLES
    var hotelData : HotelSearchData!
    
    // MARK: - VIEW LIFE CYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigation.delegate = self
        self.setData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.customizeUI()
    }
    
    // MARK: - IBACTIONS
    @IBAction func okButtonAction(_ sender: UIButton) {
        self.gotoHome()
    }
    
    // MARK: - PRIVATE FUNCTIONS
    private func customizeUI() {
        self.containerView.addShadowWithRoundCorner(radius: 6, color: .paleGreyFour, opacity: 1, offSet: .zero, shadowRadius: 10)
        self.hotelImageView.roundCorners([.topLeft, .topRight], radius: 6)
    }
    
    private func gotoHome() {
        for vc in self.navigationController?.viewControllers ?? [] {
            if vc.isKind(of: HomeVC.self) {
                self.navigationController?.popToViewController(vc, animated: true)
                break
            }
        }
    }

    private func setData() {
        hotelImageView.kf.setImage(with: URL(string: self.hotelData.hotelImages?[0]))
        nameLabel.text = self.hotelData.hotelName
        locationLabel.text = self.hotelData.hotelAddress
        ratingView.value = CGFloat(Float(self.hotelData.hotelSabreRating ?? "0.0") ?? 0.0)
        if let price = hotelData.rooms?.first?.roomRate {
            priceLabel.text = "\(price)"
        }
        if let currencyCode = hotelData.rooms?.first?.currencyCode {
            currencyTypeLabel.text = currencyCode
        }
    }
}

// MARK: - NAVIGATION DELEGATE
extension BookingCompleteVC: CustomNavigationViewDelegate {
    func view(_ view: CustomNavigationView, didPressLeft button: UIButton) {
        //
    }
}

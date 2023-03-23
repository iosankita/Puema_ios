//
//  BookingCompleteBottomPopupView.swift
//  Pneuma
//
//  Created by Jatin on 11/03/21.
//  Copyright © 2021 Jatin. All rights reserved.
//

import UIKit

protocol BookingCompleteBottomPopupViewDelegate: class {
    func view(_ view: BookingCompleteBottomPopupView, didPressOk button: UIButton)
}

class BookingCompleteBottomPopupView: UIView {

    // MARK: - IBOUTLETS
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var okButton: UIButton!
    
    // MARK: - VARIABLES
    weak var delegate: BookingCompleteBottomPopupViewDelegate?
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    // MARK: - INTERNAL FUNCTIONS
    func setupView(image: UIImage? = nil, title: String?, time: String?, description: String?, buttonTitle: String? = nil) {
        if image != nil {
            self.imageView.image = image
        }
        if buttonTitle != nil {
            self.okButton.setTitle(buttonTitle, for: .normal)
        }
        if title != nil {
            self.titleLabel.text = title
        }
        if description != nil {
            self.descriptionLabel.text = description
        }
        if time != nil {
            self.timeLabel.text = time
        }
    }

    // MARK: - IBACTIONS
    @IBAction func okButtonAction(_ sender: UIButton) {
       self.delegate?.view(self, didPressOk: sender)
    }
}

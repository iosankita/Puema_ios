//
//  CustomListCell.swift
//  Pneuma
//
//  Created by Chitra on 03/03/21.
//  Copyright © 2021 Jatin. All rights reserved.
//

import UIKit

enum CellType {
    case radioButton
    case customImage
    case myProfile
    case generalSettings
}

class CustomListCell: UITableViewCell {
    
    enum ArrowHeight: CGFloat {
        case standard = 16.0
        case compressed = 12.0
    }

    @IBOutlet weak var customImage: UIImageView!
    @IBOutlet weak var radioButton: UIButton!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var infoLabel: UILabel!
    @IBOutlet weak var detailImageView: UIImageView!
    @IBOutlet weak var separatorLabel: UILabel!
    @IBOutlet weak var arrowHeight: NSLayoutConstraint!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        self.radioButton.isSelected = selected
    }
    
    func prepareUI(type: CellType) {
        switch type {
        case .radioButton:
            customImage.isHidden = true
            radioButton.isHidden = false
            infoLabel.isHidden = true
            detailImageView.isHidden = true
        case .customImage:
            customImage.isHidden = false
            radioButton.isHidden = true
            infoLabel.isHidden = true
            detailImageView.isHidden = false
        case .myProfile:
            customImage.isHidden = true
            radioButton.isHidden = true
            infoLabel.isHidden = true
            detailImageView.isHidden = false
        case .generalSettings:
            customImage.isHidden = true
            radioButton.isHidden = true
            infoLabel.isHidden = false
            detailImageView.isHidden = false
            arrowHeight.constant = ArrowHeight.compressed.rawValue
        }
    }
}

//
//  HotelBookingCell.swift
//  Pneuma
//
//  Created by Jatin on 04/03/21.
//  Copyright © 2021 Jatin. All rights reserved.
//

import UIKit

class HotelBookingCell: UITableViewCell {
    
    // MARK: - IBOUTLETS
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var currencyTypeLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    @IBOutlet weak var hotelImageView: UIImageView!
    @IBOutlet weak var ratingView: HCSStarRatingView!
    @IBOutlet weak var locationLabel: UILabel!
    
    // MARK: - CLASS LIFE CYCLE
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func setupCell(model: HotelModel) {
        self.nameLabel.text = model.name
        self.priceLabel.text = "\(model.price ?? 0)"
        self.descriptionLabel.text = (model.check_in ?? "") + " - " + (model.check_out ?? "")
        self.locationLabel.text = model.address
    }
}

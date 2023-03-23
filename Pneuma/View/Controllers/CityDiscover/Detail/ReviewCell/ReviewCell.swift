//
//  ReviewCell.swift
//  Pneuma
//
//  Created by Chitra on 12/03/21.
//  Copyright © 2021 Jatin. All rights reserved.
//

import UIKit

class ReviewCell: UITableViewCell {

    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var reviewText: UILabel!
    @IBOutlet weak var ratingView: HCSStarRatingView!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    @IBAction func infoAction(_ sender: Any) {
    }
    
    func setupContent(_ model: ReviewModel) {
        self.userName.text = model.name
        self.userImage.image = UIImage(named: model.image ?? "") ?? UIImage()
        self.timeLabel.text = model.reviewTime
        self.reviewText.text = model.reviewText
        self.ratingView.value = CGFloat(model.reviewValue ?? 0.0)
    }
}

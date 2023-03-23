//
//  UserCell.swift
//  Pneuma
//
//  Created by Infinity S on 24/12/21.
//  Copyright © 2021 Jatin. All rights reserved.
//

import UIKit

class UserCell: UITableViewCell {

    @IBOutlet weak var viewBG: UIView!
    @IBOutlet weak var imgUser: UIImageView!
    @IBOutlet weak var lblUserVoice: UILabel!

    override func prepareForReuse() {
        super.prepareForReuse()
        //self.viewBG.setGradientBackground(colorTop: AppColor.darkViolet.getColor(), colorBottom: AppColor.darkPink.getColor(), height: self.viewBG.bounds.height, width: self.viewBG.bounds.width)
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        imgUser.layer.cornerRadius = imgUser.frame.size.width / 2.0
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

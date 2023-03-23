//
//  ImageSliderCell.swift
//  Pneuma
//
//  Created by Chitra on 11/03/21.
//  Copyright © 2021 Jatin. All rights reserved.
//

import UIKit

class ImageSliderCell: UICollectionViewCell {

    @IBOutlet weak var imageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setupContent(image: String) {
        if let image = UIImage(named: image) {
            self.imageView.image = image
        }
    }

}

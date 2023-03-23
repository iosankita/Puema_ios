//
//  PassangerListCell.swift
//  Pneuma
//
//  Created by Infinity S on 13/01/22.
//  Copyright © 2022 Jatin. All rights reserved.
//

import UIKit

class PassangerListCell: UICollectionViewCell {

    @IBOutlet weak var viewBG: UIView!
    @IBOutlet weak var txtSelectPassanger: SkyFloatingLabelTextFieldWithIcon!
    @IBOutlet weak var txtEnterName: SkyFloatingLabelTextField!
    @IBOutlet weak var txtEnterMiddleName: SkyFloatingLabelTextField!
    @IBOutlet weak var txtEnterLastName: SkyFloatingLabelTextField!
    @IBOutlet weak var txtSelectDOB: SkyFloatingLabelTextFieldWithIcon!
    @IBOutlet weak var txtSelectGender: SkyFloatingLabelTextFieldWithIcon!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}

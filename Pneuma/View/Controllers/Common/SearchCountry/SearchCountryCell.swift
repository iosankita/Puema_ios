//
//  SearchCountryCell.swift
//  Pneuma
//
//  Created by Chitra on 09/03/21.
//  Copyright © 2021 Jatin. All rights reserved.
//

import UIKit

class SearchCountryCell: UITableViewCell {

    //MARK:- IBOUTLETS
    @IBOutlet weak var placeName: UILabel!
    @IBOutlet weak var timeZoneLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}

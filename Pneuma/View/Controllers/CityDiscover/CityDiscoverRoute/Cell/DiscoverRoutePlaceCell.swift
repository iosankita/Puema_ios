//
//  DiscoverRoutePlaceCell.swift
//  Pneuma
//
//  Created by Chitra on 16/03/21.
//  Copyright © 2021 Jatin. All rights reserved.
//

import UIKit

class DiscoverRoutePlaceCell: UITableViewCell {

    //MARK:- IBOUTLETS
    @IBOutlet weak var stepView: UIView!
    @IBOutlet weak var callTaxiView: UIView!
    @IBOutlet weak var placeNameLabel: UILabel!
    @IBOutlet weak var placeTypeLabel: UILabel!
    @IBOutlet weak var timingsLabel: UILabel!
    @IBOutlet weak var websiteLabel: UILabel!
    @IBOutlet weak var moreButton: UIButton!
    @IBOutlet weak var stepButton: UIButton!
    @IBOutlet weak var stepLineLabel: UILabel!
    
    //MARK:- VARIABLES
    var index: Int = -1 {
        didSet {
            self.stepButton.setTitle(get2DigitIndex(), for: .normal)
        }
    }
    
    //MARK:- CELL LifeCycle
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    @IBAction func moreButtonAction(_ sender: Any) {
    }
    
    //MARK:- OTHER FUNCTIONS
    private func get2DigitIndex() -> String {
        let integerAsString = String(index + 1)
        if index < 10 {
            return "0\(integerAsString)"
        }
        return integerAsString
    }
    
    func setupContent(model: DiscoverRouteModel, index: Int) {
        self.index = index
        self.placeNameLabel.text = model.placeName
        self.websiteLabel.text = model.website
        self.placeTypeLabel.text = model.placeType.rawValue
        self.timingsLabel.text = model.timings
    }
}

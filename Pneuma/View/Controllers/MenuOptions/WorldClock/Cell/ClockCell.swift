//
//  ClockCell.swift
//  Pneuma
//
//  Created by Chitra on 09/03/21.
//  Copyright © 2021 Jatin. All rights reserved.
//

import UIKit

protocol DeleteClockDelegate: class {
    func didPressDelete(_ sender: ClockCell, index: Int?)
}

class ClockCell: UITableViewCell {

    //MARK:- IBOUTLETS
    @IBOutlet weak var parentView: UIView!
    @IBOutlet weak var placeName: UILabel!
    @IBOutlet weak var timeDiffLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    weak var delegate: DeleteClockDelegate?
    var index: Int?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.parentView.addShadowOnView(shadowColor: UIColor.warmGreyTwo.cgColor, shadowOffset: .zero, shadowOpacity: 0.4, shadowRadius: 5.0)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setupInitials(index: Int, model: WorldClockModel) {
        self.index = index
        self.setValues(model)
    }
    
    private func setValues(_ model: WorldClockModel) {
        self.placeName.text = model.placeName
        self.timeDiffLabel.text = model.timeDiff
        self.timeLabel.text = model.currentTime
        self.dateLabel.text = model.date
        
    }
    
    //MARK:- IBACTIONS
    @IBAction func deleteAction(_ sender: Any) {
        self.delegate?.didPressDelete(self, index: self.index)
    }
}

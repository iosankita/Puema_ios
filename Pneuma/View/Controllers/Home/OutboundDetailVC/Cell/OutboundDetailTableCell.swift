//
//  OutboundDetailTableCell.swift
//  Pneuma
//
//  Created by Jatin on 01/03/21.
//  Copyright © 2021 Jatin. All rights reserved.
//

import UIKit

class OutboundDetailTableCell: UITableViewCell {

    // MARK: - IBOUTLETS
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var logoImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var dottedLineView: UIView!
    @IBOutlet weak var bottomOvalImageView: UIImageView!
    
    // MARK: - CLASS LIFE CYCLE
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.drawDottedLine()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    // MARK: - INTERNAL FUNCTIONS
    func setupCell(model: OutboundDetailDataModel) {
        if model.hideBottomOval {
           // self.bottomOvalImageView.removeFromSuperview()
        }
    }
    func setupCell(model: AirItineraryModel) {
       
    }
    
    // MARK: - PRIVATE FUNCTIONS
    private func drawDottedLine() {
        let x = self.dottedLineView.center.x
        self.dottedLineView.drawDottedLine(start: CGPoint(x: x, y: 0), end: CGPoint(x: x, y: self.dottedLineView.frame.maxY), color: .lightBlueGrey40Opacity)
    }

}

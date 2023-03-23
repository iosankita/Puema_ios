//
//  LabeledHeaderView.swift
//  Pneuma
//
//  Created by Jatin on 03/03/21.
//  Copyright © 2021 Jatin. All rights reserved.
//

import UIKit

class LabeledHeaderView: UIView {
    
    // MARK: - IBOUTLETS
    @IBOutlet weak var titleLabel: UILabel!
    
    // MARK: - INITIALIZERS
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}

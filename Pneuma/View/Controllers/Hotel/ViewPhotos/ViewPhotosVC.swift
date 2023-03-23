//
//  ViewPhotosVC.swift
//  Pneuma
//
//  Created by iTechnolabs on 04/03/21.
//  Copyright © 2021 Jatin. All rights reserved.
//

import UIKit

class ViewPhotosVC: UIViewController {
    
    //MARK:- IBOUTLET
    @IBOutlet weak var viewPhotosTableview: UITableView!
    
    // MARK: - VARIABLES
    let cellIdentifier = "ViewPhotosTableCell"
    var arrHotelImages = [String]()
    
    //MARK:- VIEW LIFE CYCLE
    override func viewDidLoad() {
        super.viewDidLoad()

        self.registerNib()
    }
    
    private func registerNib() {
        let nib = UINib(nibName: self.cellIdentifier, bundle: nil)
        self.viewPhotosTableview.register(nib, forCellReuseIdentifier: self.cellIdentifier)
    }
}

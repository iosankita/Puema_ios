//
//  SearchCountryVC.swift
//  Pneuma
//
//  Created by Chitra on 09/03/21.
//  Copyright © 2021 Jatin. All rights reserved.
//

import UIKit

class SearchCountryVC: UIViewController {

    //MARK:- IBOUTLETS
    @IBOutlet weak var parentView: UIView!
    @IBOutlet weak var searchTF: UITextField!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var tableHeight: NSLayoutConstraint!
    @IBOutlet var emptyListView: UIView!
    
    //MARK:- VIEW LIFECYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        let height = self.tableView.contentSize.height
        if height == 0 {
            self.tableHeight.constant = 120
        } else if height + 210 <= UIScreen.main.bounds.height {
            self.tableHeight.constant = height
            self.tableView.isScrollEnabled = false
        } else {
            self.tableHeight.constant = (UIScreen.main.bounds.height - 210)
            self.tableView.isScrollEnabled = true
        }
        
    }
    
    //MARK:- IBACTIONS
    @IBAction func cancelAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}

//MARK:- UITABLEVIEW DELEGATE, UITABLEVIEW DATASOURCE
extension SearchCountryVC: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SearchCountryCell") as! SearchCountryCell
        cell.placeName.text = "Rome"
        cell.timeZoneLabel.text = "Current Time"
        return cell
    }
}

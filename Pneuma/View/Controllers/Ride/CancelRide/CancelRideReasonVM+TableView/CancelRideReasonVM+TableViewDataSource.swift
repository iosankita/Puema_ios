//
//  CancelRideReasonVM+TableViewDataSource.swift
//  Pneuma
//
//  Created by Chitra on 05/03/21.
//  Copyright © 2021 Jatin. All rights reserved.
//

import UIKit

class CancelRideReasonTableDataSource: CancelRideReasonDataSourceModel, UITableViewDataSource {
    
    // MARK: - VARIABLES
    let cellIdentifier = "CustomListCell"
    
    // MARK: - TABLE DATA SOURCE
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.listArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! CustomListCell
        cell.title.text = self.listArray[indexPath.row].title
        cell.prepareUI(type: .radioButton)
        cell.separatorLabel.isHidden = (indexPath.row == self.listArray.count - 1) // hide for last row
        return cell
    }
}

//
//  HotelBookingsResultVC+TableDataSource.swift
//  Pneuma
//
//  Created by Jatin on 01/03/21.
//  Copyright © 2021 Jatin. All rights reserved.
//

import UIKit

class HotelBookingsTableDataSource: HotelBookingTableDataSourceModel, UITableViewDataSource {
    
    // MARK: - VARIABLES
    private let cellIdentifier = "HotelBookingCell"
    
    // MARK: - TABLE DATA SOURCE
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.listArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: self.cellIdentifier) as! HotelBookingCell
        cell.selectionStyle = .none
        cell.setupCell(model: self.listArray[indexPath.row])
        return cell
    }
}

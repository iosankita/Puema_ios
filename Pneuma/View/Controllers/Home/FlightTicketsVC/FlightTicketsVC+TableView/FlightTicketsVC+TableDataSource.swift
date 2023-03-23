//
//  FlightTicketsVC+TableDataSource.swift
//  Pneuma
//
//  Created by Jatin on 01/03/21.
//  Copyright © 2021 Jatin. All rights reserved.
//

import UIKit

class FlightTicketsTableDataSource: FlightTicketTableDataSourceModel, UITableViewDataSource {
    
    // MARK: - VARIABLES
    private let cellIdentifier = "FlightTicketTableCell"
    
    // MARK: - TABLE DATA SOURCE
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.listArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: self.cellIdentifier) as! FlightTicketTableCell
        cell.setupCell(model: self.listArray[indexPath.row])
        return cell
    }
    
}

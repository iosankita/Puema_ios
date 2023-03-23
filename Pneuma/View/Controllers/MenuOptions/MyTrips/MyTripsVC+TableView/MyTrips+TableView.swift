//
//  MyTrips+TableView.swift
//  Pneuma
//
//  Created by Chitra on 10/03/21.
//  Copyright © 2021 Jatin. All rights reserved.
//

import UIKit

class MyTripsDataSource: MyTripsDataSourceModel, UITableViewDataSource {
    
    let cellId = "MyTripsCell"
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.listArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! MyTripsCell
        cell.setupContent(self.listArray[indexPath.row])
        return cell
    }
}

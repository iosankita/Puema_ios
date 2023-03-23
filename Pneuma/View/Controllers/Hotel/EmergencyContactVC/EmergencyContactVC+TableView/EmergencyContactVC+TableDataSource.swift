//
//  EmergencyContactVC+TableDataSource.swift
//  Pneuma
//
//  Created by Jatin on 01/03/21.
//  Copyright © 2021 Jatin. All rights reserved.
//

import UIKit

class EmergencyContactTableDataSource: EmergencyContactTableDataSourceModel, UITableViewDataSource {
    
    // MARK: - VARIABLES
    private let cellIdentifier = "ChooseAddressTableCell"
    
    // MARK: - TABLE DATA SOURCE
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.listArray.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.listArray[section].contacts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: self.cellIdentifier) as! ChooseAddressTableCell
        let model = self.getAddressModel(for: indexPath)
        cell.setupCell(model: model)
        return cell
    }
}

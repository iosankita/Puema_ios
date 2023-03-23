//
//  MenuVC+TableDataSource.swift
//  Pneuma
//
//  Created by Chitra on 03/03/21.
//  Copyright © 2021 Jatin. All rights reserved.
//

import UIKit

class MenuTableDataSource: MenuDataSourceModel, UITableViewDataSource {
    
    // MARK: - VARIABLES
    let cellIdentifier = "MenuCell"
    
    // MARK: - TABLE DATA SOURCE
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.listArray.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.listArray[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! MenuCell
        cell.titleText.text = self.listArray[indexPath.section][indexPath.row].title
        cell.setSelected(self.listArray[indexPath.section][indexPath.row].isActive, animated: false)
        return cell
    }
    
    
    
    
}

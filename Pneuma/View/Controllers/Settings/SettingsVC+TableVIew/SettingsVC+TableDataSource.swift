//
//  SettingsVC+TableDataSource.swift
//  Pneuma
//
//  Created by Chitra on 05/03/21.
//  Copyright © 2021 Jatin. All rights reserved.
//

import UIKit

class SettingsDataSource: SettingsDataSourceModel, UITableViewDataSource {
    
    //MARK:- VARIABLES
    let cellId = "CustomListCell"
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let type = SettingsType(rawValue: tableView.tag) ?? .general
        return self.listArray[type]?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! CustomListCell
        let type = SettingsType(rawValue: tableView.tag) ?? .general
        cell.title.text = self.listArray[type]?[indexPath.row].title
        if tableView.tag == 0 {
            cell.prepareUI(type: .generalSettings)
            cell.infoLabel.text = self.listArray[.general]?[indexPath.row].infoData
        } else {
            cell.prepareUI(type: .radioButton)
        }
        return cell
    }
    
    
    
}

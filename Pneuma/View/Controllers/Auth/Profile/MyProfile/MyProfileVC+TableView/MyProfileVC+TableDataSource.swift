//
//  MyProfileVC+TableDataSource.swift
//  Pneuma
//
//  Created by Chitra on 02/03/21.
//  Copyright © 2021 Jatin. All rights reserved.
//

import UIKit

class MyProfileDataSource: MyProfileDataSourceModel, UITableViewDataSource {
    
    // MARK: - VARIABLES
    private let cellIdentifier = "CustomListCell"
    
    // MARK: - TABLE DATA SOURCE
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.listArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: self.cellIdentifier) as! CustomListCell
        cell.title.text = self.listArray[indexPath.row].title
        cell.prepareUI(type: .myProfile)
        cell.separatorLabel.isHidden = (indexPath.row == self.listArray.count - 1) // hide for last row
        return cell
    }
}

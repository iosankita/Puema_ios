//
//  DiscoverList+TableView.swift
//  Pneuma
//
//  Created by Chitra on 11/03/21.
//  Copyright © 2021 Jatin. All rights reserved.
//

import UIKit

class DiscoverListDataSource: DiscoverListDataSourceModel, UITableViewDataSource {
    let cellId = "DiscoverListCell"
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.listArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! DiscoverListCell
        cell.setupContent(model: self.listArray[indexPath.row])
        return cell
    }
}

//MARK:- TABLEVIEW DELEGATE
extension DiscoverListVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.viewModel.selectItem(at: indexPath.row)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}

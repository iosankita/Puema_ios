//
//  ChooseAddressVC+TableDataSource.swift
//  Pneuma
//
//  Created by Jatin on 01/03/21.
//  Copyright © 2021 Jatin. All rights reserved.
//

import UIKit

class ChooseAddressTableDataSource: ChooseAddressTableDataSourceModel, UITableViewDataSource {
    
    // MARK: - VARIABLES
    private let cellIdentifier = "ChooseAddressTableCell"

    // MARK: - TABLE DATA SOURCE
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.listArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: self.cellIdentifier) as! ChooseAddressTableCell
        let dataOfAirport = self.listArray[indexPath.row]
        cell.titleLabel.text = dataOfAirport.name ?? ""
        cell.subtitleLabel.text = dataOfAirport.iataCode ?? ""
        if indexPath.row == self.listArray.count - 1{
            CustomLoader.shared.show()
            self.VM?.moreDataList(completion: { [weak self] (errorMsg) in
                CustomLoader.shared.hide()
                guard let `self` = self else {
                    return
                }
                if errorMsg.isEmpty{
                    DispatchQueue.main.async {
//                        self.tableView.dataSource = self.viewModel.tableDataSource
                        tableView.reloadData()
                        // self.view.setNeedsLayout()
                    }
                }
            })
        }
        return cell
    }
}

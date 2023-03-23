//
//  WorldClockVC+TableDataSource.swift
//  Pneuma
//
//  Created by Chitra on 10/03/21.
//  Copyright © 2021 Jatin. All rights reserved.
//

import UIKit

class WorldClockDataSource: WorldClockDataSourceModel, UITableViewDataSource {
    
    let cellId = "ClockCell"
    var deleteCallBack: ((Int)->())?
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId) as! ClockCell
        cell.delegate = self
        cell.setupInitials(index: indexPath.row, model: self.listArray[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.listArray.count
    }
}

extension WorldClockDataSource: DeleteClockDelegate {
    func didPressDelete(_ sender: ClockCell, index: Int?) {
        guard let index = index else { return }
        self.deleteCallBack?(index)
    }
}

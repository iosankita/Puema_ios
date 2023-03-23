//
//  DiscoverRoute+TableView.swift
//  Pneuma
//
//  Created by Chitra on 16/03/21.
//  Copyright © 2021 Jatin. All rights reserved.
//

import UIKit

class DiscoverRouteDataSource: DiscoverRouteDataSourceModel, UITableViewDataSource {
    
    let placeCell = "DiscoverRoutePlaceCell"
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.listArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: placeCell, for: indexPath) as! DiscoverRoutePlaceCell
        cell.setupContent(model: self.listArray[indexPath.row], index: indexPath.row)
        return cell
    }
}

extension DiscoverRouteVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView == placesTableView {
            self.optionsViewModel.selectItem(at: indexPath.row)
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if (tableView == placesTableView) {
            return 60.0
        } else {
            return UITableView.automaticDimension
        }
    }
}

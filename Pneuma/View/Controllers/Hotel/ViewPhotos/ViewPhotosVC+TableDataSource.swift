//
//  ViewPhotosVC+TableDataSource.swift
//  Pneuma
//
//  Created by iTechnolabs on 04/03/21.
//  Copyright © 2021 Jatin. All rights reserved.
//

import UIKit

extension ViewPhotosVC: UITableViewDataSource {
    
    
    // MARK: - TABLE DATA SOURCE
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrHotelImages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: self.cellIdentifier) as! ViewPhotosTableCell
        cell.imgHotel.kf.setImage(with: URL(string:arrHotelImages[indexPath.row]))
        cell.selectionStyle = .none
        return cell
    }
}

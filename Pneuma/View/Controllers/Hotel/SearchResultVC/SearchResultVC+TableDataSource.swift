//
//  SearchResultVC+TableDataSource.swift
//  Pneuma
//
//  Created by iTechnolabs on 04/03/21.
//  Copyright © 2021 Jatin. All rights reserved.
//

import UIKit

extension SearchResultVC: UITableViewDataSource {
    
    
    // MARK: - TABLE DATA SOURCE
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.arrImages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = self.arrImages[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: self.cellIdentifier) as! ViewPhotosTableCell
        cell.imgHotel.kf.setImage(with: URL(string: model))
        return cell
    }
}

//
//  HotelSearchResultVC+TableDataSource.swift
//  Pneuma
//
//  Created by Jatin on 01/03/21.
//  Copyright © 2021 Jatin. All rights reserved.
//

import UIKit

class HotelSearchResultTableDataSource: HotelSearchResultTableDataSourceModel, UITableViewDataSource {
    
    // MARK: - VARIABLES
    private let cellIdentifier = "HotelListingCell"
    
    // MARK: - TABLE DATA SOURCE
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.listArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: self.cellIdentifier) as! HotelListingCell
        cell.selectionStyle = .none
        let model = self.listArray[indexPath.row]
        print("MODEL ::", model)
        cell.hotelImageView.kf.setImage(with: URL(string: model.hotelImages?[0]))
        cell.nameLabel.text = model.hotelName
        cell.locationLabel.text = model.hotelAddress
        cell.ratingView.value = CGFloat(Float(model.hotelSabreRating ?? "0.0") ?? 0.0)
        if let price = model.rooms?.first?.roomRate {
            cell.priceLabel.text = "\(price)"
        }
        if let currencyCode = model.rooms?.first?.currencyCode {
            cell.currencyTypeLabel.text = currencyCode
        }
        return cell
    }
}

//
//  HotelInfoVC+TableDataSource.swift
//  Pneuma
//
//  Created by iTechnolabs on 17/03/21.
//  Copyright © 2021 Jatin. All rights reserved.
//

import UIKit

extension HotelInfoVC:  UITableViewDataSource {
    
    // MARK: - TABLE DATA SOURCE
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.arrRoomDetail.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: self.tableCellIdentifier) as! RoomDetailTableCell
        let model = self.arrRoomDetail[indexPath.row]
        cell.lblRoomName.text = model.roomType
        cell.lblRoomBedType.isHidden = true
        cell.lblRoomDescription.isHidden = true
        //cell.lblRoomBedType.text = model.roomBedType
        //cell.lblRoomDescription.text = model.roomAmenties?.joined(separator: ",")
        cell.lblRoomPrice.text = String(describing: model.roomRate ?? 0.0)
        cell.lblCurrency.text = model.currencyCode
        cell.selectionStyle = .none
        return cell
    }
}

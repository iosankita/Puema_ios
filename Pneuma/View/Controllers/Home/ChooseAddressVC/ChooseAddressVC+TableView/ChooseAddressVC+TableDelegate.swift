//
//  ChooseAddressVC+TableDelegate.swift
//  Pneuma
//
//  Created by Jatin on 01/03/21.
//  Copyright © 2021 Jatin. All rights reserved.
//

import UIKit

extension ChooseAddressVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let dataOfAirport = self.viewModel.tableDataSource.listArray[indexPath.row]
        delegate?.setFlight(airpotName: dataOfAirport.name ?? "", cityName:  dataOfAirport.iataCode ?? "", from: self.viewModel.locationType)
        self.navigationController?.popViewController(animated: true)
    }//dataOfAirport.address?.iataCityCode ?? ""
}

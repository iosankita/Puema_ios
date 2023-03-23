//
//  CityDiscover+TableView.swift
//  Pneuma
//
//  Created by Chitra on 10/03/21.
//  Copyright © 2021 Jatin. All rights reserved.
//

import Foundation

class CityDiscoverDataSource: CityDiscoverDataSourceModel, UITableViewDataSource {
    
    let cellId = "CustomListCell"
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.listArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId) as! CustomListCell
        cell.prepareUI(type: .customImage)
        cell.title.text = self.listArray[indexPath.row].title
        cell.customImage.image = UIImage(named: self.listArray[indexPath.row].image)
        return cell
    }
}

extension CityDiscoverVC: UITableViewDataSource {
  
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == placesTableView{
              return self.placesModel.listArray.count
        }else{
            return 1
        }
      
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == placesTableView{
            let cell = tableView.dequeueReusableCell(withIdentifier: cellId) as! CustomListCell
            cell.selectionStyle = .none
            cell.prepareUI(type: .customImage)
            cell.title.text = self.placesModel.listArray[indexPath.row].title
            cell.customImage.image = UIImage(named: self.placesModel.listArray[indexPath.row].image)
            return cell
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: routeCellId) as! routeTableCell
            cell.selectionStyle = .none
            return cell
        }
       
    }
}

//MARK:- TABLEVIEW DELEGATE
extension CityDiscoverVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView == placesTableView {
            self.viewModel.selectItem(at: indexPath.row)
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 65.0
    }
}

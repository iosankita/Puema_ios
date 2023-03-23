//
//  SelectPlaceType+TableView.swift
//  Pneuma
//
//  Created by iTechnolabs on 17/03/21.
//  Copyright © 2021 Jatin. All rights reserved.
//

import Foundation

extension SelectPlaceTypeVC: UITableViewDataSource {
  
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
extension SelectPlaceTypeVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView == placesTableView{
          self.viewModel.selectItem(at: indexPath.row)
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if tableView == placesTableView{
           return 65.0
        }else{
            return 0.0
        }
       
    }
}

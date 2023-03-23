//
//  EmergencyContactDataModel.swift
//  Pneuma
//
//  Created by Jatin on 03/03/21.
//  Copyright © 2021 Jatin. All rights reserved.
//

import Foundation

class EmergencyContactTableDataSourceModel: NSObject {
    var listArray = [EmergencyContactCategoryModel]()
    
    func getSectionTitle(for section: Int) -> String {
        self.listArray[section].name
    }
    
    func getAddressModel(for indexPath: IndexPath) -> ChooseAddressDataModel {
        return self.listArray[indexPath.section].contacts[indexPath.row].addressModel
    }
}

struct EmergencyContactCategoryModel {
    var name: String
    var contacts = [EmergencyContactDataModel]()
}

struct EmergencyContactDataModel {
    var title: String
    var subtitle: String?
    var image: UIImage?
    
    var addressModel: ChooseAddressDataModel {
        return ChooseAddressDataModel(title: title,
                                      subtitle: subtitle,
                                      image: image)
    }
}

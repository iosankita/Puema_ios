//
//  MenuVM.swift
//  Pneuma
//
//  Created by Chitra on 03/03/21.
//  Copyright © 2021 Jatin. All rights reserved.
//

import Foundation

class MenuVM: NSObject {
    
    // MARK: - VARIABLES
    let tableDataSource = MenuTableDataSource()
    
    // MARK: - INITIALIZER
    override init() {
        super.init()
        self.getList()
    }
    
    // MARK: - PRIVATE FUNCTIONS
    private func getList() {
        let sec1 = [MenuModel(type: .home, isActive: true),
                    MenuModel(type: .bookAFlight),
                    MenuModel(type: .findAHotel),
                    MenuModel(type: .getARide),
                    MenuModel(type: .myProfile),
                    MenuModel(type: .settings)]
        let sec2 = [MenuModel(type: .myFlightTickets),
                    MenuModel(type: .myHotelBookings),
                    MenuModel(type: .myRides),
                    MenuModel(type: .myTrips)]
        let sec3 = [MenuModel(type: .emergencyServices),
                    MenuModel(type: .worldClock)]
        self.tableDataSource.listArray = [sec1, sec2, sec3]
    }
}

// MARK: - TABLE FUNCTIONS
extension MenuVM {
    func selectItem(at indexPath: IndexPath) {
        for i in 0..<self.tableDataSource.listArray.count {
            for j in 0..<self.tableDataSource.listArray[i].count {
                if j == indexPath.row {
                    self.tableDataSource.listArray[i][j].isActive = true
                    
                } else {
                    self.tableDataSource.listArray[i][j].isActive = false
                }
            }
        }
    }
}

class LogoutVM: NSObject {
    
    // MARK: - VARIABLES
     var apiServices: AuthApiServices
     var responseModel: LogoutResponseModel?
    
    // MARK: - CLASS LIFE CYCLE
    override init() {
        self.apiServices = AuthApiServices()
        self.responseModel = LogoutResponseModel()
        super.init()
    }
    
    // MARK: - CUSTOM FUNCTIONS
    ///login api call
    func logout(completion: @escaping ApiResponseCompletion) {
        
        
        ///Calling api service method
        self.apiServices.logout { (result) in
            switch result {
            case .success(let response):
                guard let data = response.resultData as? Data else {
                    completion(.failure(ApiResponseErrorBlock(message: LocalizedStringEnum.somethingWentWrong.localized)))
                    return
                }
                let model: LogoutResponseModel? = JSONDecoder().convertDataToModel(data)
                self.responseModel = model
                completion(.success(response))
            case .failure(let error):
                ///Handle failure response
                completion(.failure(error))
            }
        }
    }
    
    ///Validating the data that all the api parameters are completed or not.
    func validation() -> String? {
       
        return nil
    }
    
}

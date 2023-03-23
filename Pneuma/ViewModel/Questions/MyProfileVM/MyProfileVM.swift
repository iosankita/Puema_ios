//
//  MyProfileVM.swift
//  Pneuma
//
//  Created by Chitra on 02/03/21.
//  Copyright © 2021 Jatin. All rights reserved.
//

import Foundation

class MyProfileVM: NSObject {
    
    // MARK: - VARIABLES
    let tableDataSource = MyProfileDataSource()
    var handleSelectionCallback: ((ProfileModelType)->())? = nil
    var authApiServices: AuthApiServices
    var userResponseModel: UserModel?
    var apiServices: ProfileApiServices
    var editNameRequestModel: EditNameRequestModel
    var editNameResponseModel: EditNameResponseModel?
    var editPasswordRequestModel: EditPasswordRequestModel
    var editPasswordResponseModel: EditPasswordResponseModel?
    var editEmailRequestModel: EditEmailRequestModel
    var editEmailResponseModel: EditEmailResponseModel?
    var editPhoneRequestModel: EditPhoneRequestModel
    var editPhoneResponseModel: EditPhoneResponseModel?
    var editPassportRequestModel: EditPassportRequestModel
    var editPassportResponseModel: EditPassportResponseModel?
    
    // MARK: - INITIALIZER
    override init() {
        self.apiServices = ProfileApiServices()
        self.authApiServices = AuthApiServices()
        self.editNameRequestModel = EditNameRequestModel()
        self.editNameResponseModel = EditNameResponseModel()
        self.editPasswordRequestModel = EditPasswordRequestModel()
        self.editPasswordResponseModel = EditPasswordResponseModel()
        self.editEmailRequestModel = EditEmailRequestModel()
        self.editEmailResponseModel = EditEmailResponseModel()
        self.editPhoneRequestModel = EditPhoneRequestModel()
        self.editPhoneResponseModel = EditPhoneResponseModel()
        self.editPassportRequestModel = EditPassportRequestModel()
        self.editPassportResponseModel = EditPassportResponseModel()
        self.userResponseModel = UserModel()
        super.init()
        self.getList()
    }
    
    func getUser(completion: @escaping ApiResponseCompletion) {
          
          ///Calling api service method
          self.authApiServices.getUser { (result) in
              switch result {
              case .success(let response):
                  guard let data = response.resultData as? Data else {
                      completion(.failure(ApiResponseErrorBlock(message: LocalizedStringEnum.somethingWentWrong.localized)))
                      return
                  }
                  let model: UserModel? = JSONDecoder().convertDataToModel(data)
                  self.userResponseModel = model
                  AppCache.shared.currentUser = model
                  completion(.success(response))
              case .failure(let error):
                  ///Handle failure response
                  completion(.failure(error))
              }
          }
    }
    
    // MARK: - PRIVATE FUNCTIONS
    private func getList() {
        self.tableDataSource.listArray = [MyProfileModel(title: ProfileModelType.name.displayString, type: ProfileModelType.name),
                                          MyProfileModel(title: ProfileModelType.email.displayString, type: ProfileModelType.email),
                                          MyProfileModel(title: ProfileModelType.password.displayString, type: ProfileModelType.password),
                                          MyProfileModel(title: ProfileModelType.phoneNumber.displayString, type: ProfileModelType.phoneNumber),
                                          MyProfileModel(title: ProfileModelType.passportData.displayString, type: ProfileModelType.passportData)]
    }
    
}

// MARK: - TABLE FUNCTIONS
extension MyProfileVM {
    func selectItem(at indexPath: IndexPath) {
        let type = self.tableDataSource.listArray[indexPath.row].type
        self.handleSelectionCallback?(type)
    }
}
extension MyProfileVM {
    func editName(completion: @escaping ApiResponseCompletion) {
        ///Converting Codable type model to dictionary
      let params: [String: Any] = JSONEncoder().convertToDictionary(self.editNameRequestModel) ?? [:]
        
        ///Calling api service method
        self.apiServices.updateName(params) { (result) in
            switch result {
            case .success(let response):
                guard let data = response.resultData as? Data else {
                    completion(.failure(ApiResponseErrorBlock(message: LocalizedStringEnum.somethingWentWrong.localized)))
                    return
                }
                let model: EditNameResponseModel? = JSONDecoder().convertDataToModel(data)
                self.editNameResponseModel = model
                completion(.success(response))
            case .failure(let error):
                ///Handle failure response
                completion(.failure(error))
            }
        }
    }
    
    ///Validating the data that all the api parameters are completed or not.
    func nameValidation() -> String? {
        if self.editNameRequestModel.name?.isEmptyWithTrimmedSpace ?? true {
            return LocalizedStringEnum.enterFullName.localized
        }
       
        return nil
    }
}

extension MyProfileVM {
    func editPhone(completion: @escaping ApiResponseCompletion) {
        ///Converting Codable type model to dictionary
      let params: [String: Any] = JSONEncoder().convertToDictionary(self.editPhoneRequestModel) ?? [:]
        
        ///Calling api service method
        self.apiServices.updatePhone(params) { (result) in
            switch result {
            case .success(let response):
                guard let data = response.resultData as? Data else {
                    completion(.failure(ApiResponseErrorBlock(message: LocalizedStringEnum.somethingWentWrong.localized)))
                    return
                }
                let model: EditPhoneResponseModel? = JSONDecoder().convertDataToModel(data)
                self.editPhoneResponseModel = model
                completion(.success(response))
            case .failure(let error):
                ///Handle failure response
                completion(.failure(error))
            }
        }
    }
    
    ///Validating the data that all the api parameters are completed or not.
    func phoneValidation() -> String? {
        if self.editPhoneRequestModel.phone?.isEmptyWithTrimmedSpace ?? true {
            return LocalizedStringEnum.enterValidPhone.localized
        }
        if !(self.editPhoneRequestModel.phone?.isValidPhoneNumber() ?? false) {
            return LocalizedStringEnum.enterValidPhone.localized
        }
       
        return nil
    }
}
extension MyProfileVM {
    func editEmail(completion: @escaping ApiResponseCompletion) {
        ///Converting Codable type model to dictionary
      let params: [String: Any] = JSONEncoder().convertToDictionary(self.editEmailRequestModel) ?? [:]
        
        ///Calling api service method
        self.apiServices.updateEmail(params) { (result) in
            switch result {
            case .success(let response):
                guard let data = response.resultData as? Data else {
                    completion(.failure(ApiResponseErrorBlock(message: LocalizedStringEnum.somethingWentWrong.localized)))
                    return
                }
                let model: EditEmailResponseModel? = JSONDecoder().convertDataToModel(data)
                self.editEmailResponseModel = model
                completion(.success(response))
            case .failure(let error):
                ///Handle failure response
                completion(.failure(error))
            }
        }
    }
    
    ///Validating the data that all the api parameters are completed or not.
    func emailValidation() -> String? {
        if self.editEmailRequestModel.email?.isEmptyWithTrimmedSpace ?? true {
            return LocalizedStringEnum.enterEmailAddress.localized
        }
        if !(self.editEmailRequestModel.email?.checkIsValidEmail() ?? false) {
            return LocalizedStringEnum.enterValidEmailAddress.localized
        }
        if self.editEmailRequestModel.password?.isEmptyWithTrimmedSpace ?? true {
            return LocalizedStringEnum.enterPassword.localized
        }
        if !(self.editEmailRequestModel.password?.isValidPassword() ?? false) {
            return LocalizedStringEnum.InvalidPassword.localized
        }
       
        return nil
    }
}
extension MyProfileVM {
    func editPassword(completion: @escaping ApiResponseCompletion) {
        ///Converting Codable type model to dictionary
      let params: [String: Any] = JSONEncoder().convertToDictionary(self.editPasswordRequestModel) ?? [:]
        
        ///Calling api service method
        self.apiServices.updatePassword(params) { (result) in
            switch result {
            case .success(let response):
                guard let data = response.resultData as? Data else {
                    completion(.failure(ApiResponseErrorBlock(message: LocalizedStringEnum.somethingWentWrong.localized)))
                    return
                }
                let model: EditPasswordResponseModel? = JSONDecoder().convertDataToModel(data)
                self.editPasswordResponseModel = model
                completion(.success(response))
            case .failure(let error):
                ///Handle failure response
                completion(.failure(error))
            }
        }
    }
    
    ///Validating the data that all the api parameters are completed or not.
    func passwordValidation() -> String? {
        if self.editPasswordRequestModel.old_password?.isEmptyWithTrimmedSpace ?? true {
            return LocalizedStringEnum.enterOldPassword.localized
        }
        if !(self.editPasswordRequestModel.old_password?.isValidPassword() ?? false) {
            return LocalizedStringEnum.InvalidPassword.localized
        }
        if self.editPasswordRequestModel.new_password?.isEmptyWithTrimmedSpace ?? true {
            return LocalizedStringEnum.enterPassword.localized
        }
        if !(self.editPasswordRequestModel.new_password?.isValidPassword() ?? false) {
            return LocalizedStringEnum.InvalidPassword.localized
        }
        if self.editPasswordRequestModel.confirm_password?.isEmptyWithTrimmedSpace ?? true {
            return LocalizedStringEnum.enterPassword.localized
        }
        if self.editPasswordRequestModel.new_password != self.editPasswordRequestModel.confirm_password {
            return LocalizedStringEnum.enterValidPassword.localized
        }
        return nil
    }
}
extension MyProfileVM {
    func editPassport(completion: @escaping ApiResponseCompletion) {
        ///Converting Codable type model to dictionary
      let params: [String: Any] = JSONEncoder().convertToDictionary(self.editPassportRequestModel) ?? [:]
        
        ///Calling api service method
        self.apiServices.updatePassportDetails(params) { (result) in
            switch result {
            case .success(let response):
                guard let data = response.resultData as? Data else {
                    completion(.failure(ApiResponseErrorBlock(message: LocalizedStringEnum.somethingWentWrong.localized)))
                    return
                }
                let model: EditPassportResponseModel? = JSONDecoder().convertDataToModel(data)
                self.editPassportResponseModel = model
                completion(.success(response))
            case .failure(let error):
                ///Handle failure response
                completion(.failure(error))
            }
        }
    }
    
    ///Validating the data that all the api parameters are completed or not.
    func passportValidation() -> String? {
        if self.editPassportRequestModel.nationality?.isEmptyWithTrimmedSpace ?? true {
            return LocalizedStringEnum.enterNationality.localized
        }
        if self.editPassportRequestModel.passport_issue_date?.isEmptyWithTrimmedSpace ?? true {
            return LocalizedStringEnum.enterIssueDate.localized
        }
        if self.editPassportRequestModel.passport_expiry_date?.isEmptyWithTrimmedSpace ?? true {
            return LocalizedStringEnum.enterExpiryDate.localized
        }
        if self.editPassportRequestModel.passport_country_code?.isEmptyWithTrimmedSpace ?? true {
            return LocalizedStringEnum.enterCountryCode.localized
        }
        if self.editPassportRequestModel.passport_number?.isEmptyWithTrimmedSpace ?? true {
            return LocalizedStringEnum.enterPassportNumber.localized
        }
        if self.editPassportRequestModel.passport_citizenship_number?.isEmptyWithTrimmedSpace ?? true {
            return LocalizedStringEnum.enterCitizenshipNUmber.localized
        }
        return nil
    }
}

//
//  JsonEncoder+Extension.swift
//  Pneuma
//
//  Created by Chitra on 24/02/21.
//  Copyright © 2021 iTechnolabs. All rights reserved.
//

import Foundation

extension JSONEncoder {
    
    ///This method will convert the Codable type model(T) to return type(U).
    ///Usage => let dict: [String: Any] = JSONEncoder().convertToDictionary(model)
    ///Parameter and return type both are generic
    func convertToDictionary<T: Encodable, U>(_ model: T) -> U? {
        do {
            let data = try JSONEncoder().encode(model)
            let dictionary = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? U
            print(dictionary)
            return dictionary
        }catch {
            debugPrint(error.localizedDescription)
            return nil
        }
    }
   // let jsonDict = JSONHelper<RealStoriesUser>().toDictionary(model:  object ?? RealStoriesUser())
    
    func toDictionary<T: Encodable>(model: T) -> Any? {
        do {
            guard let data = getData(model: model) else {
                throw NSError(domain: "Can't convert model to data", code: 1, userInfo: nil)
            }
            
            let dict = try JSONSerialization.jsonObject(with: data, options: .allowFragments)
            return dict
        } catch {
            debugPrint(error.localizedDescription)
        }
        return nil
    }
    
    func getData<T: Encodable>(model: T) -> Data? {
        guard let data: Data = try? JSONEncoder().encode(model) else {
            return nil
        }
        return data
    }
    func convertToData<T: Encodable>(_ model: T) -> Data? {
        let encoder = JSONEncoder()
        return try? encoder.encode(model)
    }
}

extension JSONDecoder {
    func convertDataToModel<T: Decodable>(_ data: Data) -> T? {
        
        do {
            return try JSONDecoder().decode(T.self, from: data)
        }catch {
            debugPrint(error)
            return nil
        }
    }
}




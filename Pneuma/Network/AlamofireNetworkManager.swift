//
//  AlamofireNetworkManager.swift
//  Pneuma
//
//  Created by Jatin on 22/09/20.
//  Copyright © 2021 Jatin. All rights reserved.
//


import Foundation
import Alamofire
import SwifterSwift

fileprivate enum AlertMessages: String {
    case somethingWentWrong
    
    var localized: String {
        return NSLocalizedString(self.rawValue, comment: self.rawValue)
    }
}

class AlamofireNetworkManager {
    
    var myRequest: Alamofire.Request?
    
    func urlRequest(path: String, resource: Resource, completionBlock: @escaping ApiResponseCompletion) {
        if resource.responseType == .json {
            self.urlRequestForJsonResponse(path: path, resource: resource, completionBlock: completionBlock)
        }else if resource.responseType == .data {
            self.urlRequestForDataResponse(path: path, resource: resource, completionBlock: completionBlock)
        }
    }
    
    private func urlRequestForJsonResponse(path: String, resource: Resource, completionBlock: @escaping ApiResponseCompletion) {
        
        if !Network.reachability.isReachable {
            completionBlock(.failure(ApiResponseErrorBlock(message: LocalizedStringEnum.networkNotReachable.localized)))
            return
        }
        
        debugPrint("API path is: ", path)
        do {
            guard let request = self.createUrlRequest(path: path, resource: resource) else {
                let apiError = ApiResponseErrorBlock(message: "GET URL not set properly")
                completionBlock(.failure(apiError))
                return
            }
            AF.request(request).responseJSON { response in
                let statusCode = response.response?.statusCode ?? -1
                switch response.result {
                    
                case .success(let json):
                    debugPrint("API success code is: \(statusCode) and response is: ", json)
                    if resource.validator != nil {
                        resource.validator?.validateResponse(statusCode: statusCode, response: json, completionBlock: { (result) in
                            switch result {
                            case .success(let response):
                                completionBlock(.success(response))
                            case .failure(let error):
                                completionBlock(.failure(error))
                            }
                        })
                    }else {
                        let result = ApiResponseSuccessBlock(message: "", statusCode: response.response?.statusCode ?? -1, resultData: json, error: nil)
                        completionBlock(.success(result))
                    }
                case .failure(let error):
                    debugPrint("API failure response is: ", error.localizedDescription)
                    let apiError = ApiResponseErrorBlock(message: error.localizedDescription)
                    completionBlock(.failure(apiError))
                }
            }
        }
    }
    
    private func urlRequestForDataResponse(path: String, resource: Resource, completionBlock: @escaping ApiResponseCompletion) {
        if resource.method != .get {
            debugPrint("API path is: ", path)
        }
        
        do {
            guard let request = self.createUrlRequest(path: path, resource: resource) else {
                let apiError = ApiResponseErrorBlock(message: "GET URL not set properly")
                completionBlock(.failure(apiError))
                return
            }
            AF.request(request).responseData { response in
                switch response.result {
                    
                case .success(let jsonData):
                   
                    if resource.validator != nil{
                        resource.validator?.validateResponse(statusCode: response.response?.statusCode ?? -1, response: jsonData, completionBlock: { (result) in
                            switch result {
                            case .success(let response):
                                completionBlock(.success(response))
                            case .failure(let error):
                                completionBlock(.failure(error))
                            }
                        })
                    }else {
                        let result = ApiResponseSuccessBlock(message: "", statusCode: response.response?.statusCode ?? -1, resultData: jsonData, error: nil)
                        completionBlock(.success(result))
                    }
                case .failure(let error):
                    debugPrint("API response error: ", error.localizedDescription)
                    let apiError = ApiResponseErrorBlock(message: error.localizedDescription)
                    completionBlock(.failure(apiError))
                }
            }
        }
    }
    
    func request(path: String, resource: Resource, completionBlock: @escaping ApiResponseCompletion) {
        if resource.responseType == .json {
            self.requestForJsonResponse(path: path, resource: resource, completionBlock: completionBlock)
        }else if resource.responseType == .data {
            self.requestForDataResponse(path: path, resource: resource, completionBlock: completionBlock)
        }
    }
    
    private func requestForJsonResponse(path: String, resource: Resource, completionBlock: @escaping ApiResponseCompletion) {
        debugPrint("API path is: ", path)
        debugPrint("Request parameters: ", resource.parameters ?? [:])
        do {
            AF.request(path, method: self.getHTTPMethodType(type: resource.method), parameters: resource.parameters, encoding: self.getURLEncodingType(type: resource.encoding), headers: self.getHttpHeader(headers: resource.headers)).responseJSON { response in
                switch response.result {
                    
                case .success(let json):
                    debugPrint("API response is: ", json)
                    if resource.validator != nil{
                        resource.validator?.validateResponse(statusCode: response.response?.statusCode ?? -1, response: json, completionBlock: { (result) in
                            switch result {
                            case .success(let response):
                                completionBlock(.success(response))
                            case .failure(let error):
                                completionBlock(.failure(error))
                            }
                        })
                    }
                    else {
                        let result = ApiResponseSuccessBlock(message: "", statusCode: response.response?.statusCode ?? -1, resultData: json, error: nil)
                        completionBlock(.success(result))
                    }
                case .failure(let error):
                    debugPrint("API response error: ", error.localizedDescription)
                    let apiError = ApiResponseErrorBlock(message: error.localizedDescription)
                    completionBlock(.failure(apiError))
                }
            }
        }
    }
    
    private func requestForDataResponse(path: String, resource: Resource, completionBlock: @escaping ApiResponseCompletion) {
        debugPrint("API path is: ", path)
        debugPrint("Request parameters: ", resource.parameters ?? [:])
        do {
            AF.request(path, method: self.getHTTPMethodType(type: resource.method), parameters: resource.parameters, encoding: self.getURLEncodingType(type: resource.encoding), headers: self.getHttpHeader(headers: resource.headers)).responseData { response in
                switch response.result {
                    
                case .success(let json):
                    debugPrint("API response is: ", json)
                    if resource.validator != nil{
                        resource.validator?.validateResponse(statusCode: response.response?.statusCode ?? -1, response: json, completionBlock: { (result) in
                            switch result {
                            case .success(let response):
                                completionBlock(.success(response))
                            case .failure(let error):
                                completionBlock(.failure(error))
                            }
                        })
                    }else {
                        let result = ApiResponseSuccessBlock(message: "", statusCode: response.response?.statusCode ?? -1, resultData: json, error: nil)
                        completionBlock(.success(result))
                    }
                case .failure(let error):
                    debugPrint("API response error: ", error.localizedDescription)
                    let apiError = ApiResponseErrorBlock(message: error.localizedDescription)
                    completionBlock(.failure(apiError))
                }
            }
        }
    }
    
    
    
    //MARK: Request Method to Upload Multipart
    func uploadMultiple(path: String, resource: Resource, imageDict:[String: Data]?, completionBlock: @escaping ApiResponseCompletion) {
        do {
            debugPrint("********************************* API Request **************************************")
            debugPrint("Request URL:\(path)")
            debugPrint("Request resource: \(resource)")
            debugPrint("image dictionary: \(String(describing: imageDict))")
            
            let urlRequest = createRequestWithMultipleImages(resource: resource, urlString: path, parameters: resource.parameters, imageDict: imageDict)
            let manager = Alamofire.Session.default
            manager.session.configuration.timeoutIntervalForRequest = 180
            myRequest = manager.upload((urlRequest?.1)!, with: (urlRequest?.0)!).uploadProgress(closure: { (progress) in
                debugPrint(progress.localizedDescription ?? "")
                
            }).responseJSON(completionHandler: { [weak self] (response) in
                debugPrint("********************************* API Response *************************************")
                debugPrint("\(response.debugDescription)")
                debugPrint("************************************************************************************")
                
                self?.myRequest = nil
                switch response.result {
                
                case .success(let json):
                    debugPrint("API response is: ", json)
                    if resource.validator != nil {
                        resource.validator?.validateResponse(statusCode: response.response?.statusCode ?? -1, response: json, completionBlock: { (result) in
                            switch result {
                            case .success(let response):
                                completionBlock(.success(response))
                            case .failure(let error):
                                completionBlock(.failure(error))
                            }
                        })
                    }else {
                        let result = ApiResponseSuccessBlock(message: "", statusCode: response.response?.statusCode ?? -1, resultData: json, error: nil)
                        completionBlock(.success(result))
                    }
                case .failure(let error):
                    debugPrint("API response error: ", error.localizedDescription)
                    let apiError = ApiResponseErrorBlock(message: error.localizedDescription)
                    completionBlock(.failure(apiError))
                }
            })
        }
    }
    
    func createRequestWithMultipleImages(resource: Resource, urlString:String, parameters:[String : Any]?, imageDict: [String: Data]?) -> (URLRequestConvertible, Data)? {
        
        // create url request to send
        var mutableURLRequest = URLRequest(url: NSURL(string: urlString)! as URL)
        mutableURLRequest.httpMethod = resource.method.rawValue
        //        mutableURLRequest.allHTTPHeaderFields = resource.headers
        
        let boundaryConstant = "myRandomBoundary12345";
        let contentType = "multipart/form-data;boundary="+boundaryConstant
        mutableURLRequest.setValue(contentType, forHTTPHeaderField: "Content-Type")
        if resource.headers != nil {
            for (key, value) in resource.headers! {
                mutableURLRequest.setValue(value as! String, forHTTPHeaderField: key)
            }
        }
        
        // create upload data to send
        var uploadData = Data()
        if parameters != nil {
            for (key, value) in parameters! {
                uploadData.append("--\(boundaryConstant)\r\n".data(using: String.Encoding.utf8)!)
                uploadData.append("Content-Disposition: form-data; name=\"\(key)\"\r\n\r\n".data(using: String.Encoding.utf8)!)
                uploadData.append("\(value)\r\n".data(using: String.Encoding.utf8)!)
            }
        }
        if imageDict != nil {
            for (key, value) in imageDict! {
                uploadData.append("--\(boundaryConstant)\r\n".data(using: String.Encoding.utf8)!)
                uploadData.append("Content-Disposition: form-data; name=\"\(key)\"; filename=\"\(key).png\"\r\n".data(using: String.Encoding.utf8)!)
                uploadData.append("Content-Type: image/png\r\n\r\n".data(using: String.Encoding.utf8)!)
                uploadData.append(value)
                uploadData.append("\r\n".data(using: String.Encoding.utf8)!)
            }
        }
        uploadData.append("--\(boundaryConstant)--\r\n".data(using: String.Encoding.utf8)!)
        do {
            let result = try Alamofire.URLEncoding.default.encode(mutableURLRequest, with: nil)
            return (result, uploadData)
        }
        catch _ {
        }
        
        return nil
    }
    
    
    
    func hitMultipartRequest(path: String, resource: Resource, key: String, fileData: Data?, fileURL: URL?, mimeType: MimeType?, fileName: String?, uploadType: MultipartUploadType, completionBlock: @escaping ApiResponseCompletion) {
        
        debugPrint("path: ", path)
        debugPrint("params: ", resource.parameters)
        debugPrint("key: ", key)
        debugPrint("fileData: ", fileData)
        debugPrint("fileURL: ", fileURL)
        debugPrint("mimeType: ", mimeType)
        debugPrint("fileName: ", fileName)
        debugPrint("uploadType: ", uploadType)
        
        AF.upload(multipartFormData: { multipartFormData in
            
            if uploadType == .data && fileData != nil {
            multipartFormData.append(fileData!, withName: key, fileName: fileName, mimeType: mimeType?.rawValue)
            }else if fileURL != nil {//url
                multipartFormData.append(fileURL!, withName: key, fileName: fileName!, mimeType: mimeType!.rawValue)
            }
            
            for (key, value) in resource.parameters ?? [:] {
//                if let string = value as? String {
                    multipartFormData.append("\(value)".data(using: .utf8)!, withName: key)
//                }
            }
        }, to: path, method: self.getHTTPMethodType(type: resource.method))
            .responseJSON { (response) in
                switch response.result {
                    
                case .success(let json):
                    debugPrint("API response is: ", json)
                    if resource.validator != nil {
                        resource.validator?.validateResponse(statusCode: response.response?.statusCode ?? -1, response: json, completionBlock: { (result) in
                            switch result {
                            case .success(let response):
                                completionBlock(.success(response))
                            case .failure(let error):
                                completionBlock(.failure(error))
                            }
                        })
                    }else {
                        let result = ApiResponseSuccessBlock(message: "", statusCode: response.response?.statusCode ?? -1, resultData: json, error: nil)
                        completionBlock(.success(result))
                    }
                case .failure(let error):
                    debugPrint("API response error: ", error.localizedDescription)
                    let apiError = ApiResponseErrorBlock(message: error.localizedDescription)
                    completionBlock(.failure(apiError))
                }
        }
    }
    
    private func getHTTPMethodType(type:HTTPMethodType) -> HTTPMethod{
        switch type {
        case .get:
            return .get
        case .post:
            return .post
        case .put:
            return .put
        case .delete:
            return .delete
        default:
            return .get
            
        }
    }
    
    private func getURLEncoderType(type:URLEncodingType) -> ParameterEncoder{
        switch type {
        case .FORM:
            return URLEncodedFormParameterEncoder.init(encoder: URLEncodedFormEncoder(), destination: URLEncodedFormParameterEncoder.Destination.httpBody)
        case .QUERY:
            return URLEncodedFormParameterEncoder.init(encoder: URLEncodedFormEncoder(), destination: URLEncodedFormParameterEncoder.Destination.queryString)
        case .JSONENCODING:
            return JSONParameterEncoder.default
        default:
            return URLEncodedFormParameterEncoder.default
        }
        
    }
    
    private func getURLEncodingType(type:URLEncodingType) -> ParameterEncoding{
        switch type {
        case .FORM:
            return URLEncoding.httpBody
        case .QUERY:
            return URLEncoding.queryString
        case .JSONENCODING:
            return JSONEncoding.default
        default:
            return URLEncoding.default
        }
        
    }
    
    private func getHttpHeader(headers:[String:Any]?) -> HTTPHeaders? {
        guard let headers = headers else {
            return nil
        }
        
        var httpHeaders: HTTPHeaders = HTTPHeaders()
        for  (key,value) in headers {
            if let dictionary = value as? [String: Any] {
                let h1 = HTTPHeader.init(name: key, value: dictionary.jsonString() ?? "")
                httpHeaders.add(h1)
            }else {
                let h1 = HTTPHeader.init(name: key, value: value as? String ?? "")
                httpHeaders.add(h1)
            }
        }
        return httpHeaders
        
    }
    
    func createUrlRequest(path: String, resource: Resource) -> URLRequest? {
        
        var url = URL.init(string: nil)
        if resource.method == .get {
            var urlString = "\(path)?"
            for (key,value) in resource.parameters ?? [:] {
                urlString = "\(urlString)\(key)=\(value)&"
            }
            debugPrint("API path is: \(urlString)")
            url = URL(string: urlString)!
        } else {
            url = URL(string: path)!
        }
        
        guard let urlPath = url else {
            debugPrint("URL not set")
            return nil
        }

        var request = URLRequest(url: urlPath)
        request.httpMethod = resource.method.rawValue
        debugPrint("Request method: ", resource.method.rawValue)
        debugPrint("Request parameters: ", resource.parameters ?? [:])
        if let parameters = resource.parameters, resource.method != .get {
            // ADD PARAMETERS
            do {
                let data = try JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted)
                request.httpBody = data
            } catch {
                debugPrint(error.localizedDescription)
            }
        }
        
        debugPrint("Request headers: ", resource.headers ?? [:])
        // ADD HEADERS
        for (key, value) in resource.headers ?? [:] {
            if let dictionary = value as? [String: Any] {
                request.setValue(dictionary.jsonString() ?? "", forHTTPHeaderField: key)
            }else if let stringValue = value as? String {
                request.setValue(stringValue, forHTTPHeaderField: key)
            }
        }
        
        return request
    }
        
    // MARK: - DOWNLOAD PDF
    func downloadPdf(from urlString: String, completionHandler:@escaping(String?, Bool)->()){

        guard let downloadURL = URL(string: urlString) else {
            return
        }
        let fileName = downloadURL.lastPathComponent
        
        let destinationPath: DownloadRequest.Destination = { _, _ in
            let documentsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0];
            let fileURL = documentsURL.appendingPathComponent(fileName)
            return (fileURL, [.removePreviousFile, .createIntermediateDirectories])
        }
        debugPrint("Downloading file url: ", urlString)
        AF.download(urlString, to: destinationPath)
            .downloadProgress { progress in
                debugPrint(progress.completedUnitCount)
            }
            .responseData { response in
                debugPrint("response: \(response)")
                switch response.result{
                case .success:
                    if let filePath = response.fileURL {
                        completionHandler(filePath.absoluteString, true)
                    }else {
                        completionHandler(nil, false)
                    }
                case .failure:
                    completionHandler(nil, false)
                }

        }
    }
}

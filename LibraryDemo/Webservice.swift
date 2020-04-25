//
//  Webservice.swift
//  RequestHTTP
//
//  Created by Nanda Mochammad on 19/02/20.
//  Copyright © 2020 Nanda Mochammad. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

public enum NetworkError: Error{
    case decodingError
    case domainError
    case urlError
    case noConnection
}

class Webservice{
    func requestGET<T>(resource: WebserviceResource<T>, completion: @escaping(Result<T>) -> Void){
        Alamofire.request(resource.url, method: .get, parameters: nil, encoding: URLEncoding.default, headers: resource.headers)
            .validate()
            .responseJSON { (responseJSON) in
                switch responseJSON.result{
                case .success(let jsonResult):
                    do{
                        let jsonData = try JSONSerialization.data(withJSONObject: jsonResult, options: .prettyPrinted)

                        let result = try JSONDecoder().decode(T.self, from: jsonData)
                        
                        completion(.success(result))
                    }catch{
                        completion(.failure(NetworkError.decodingError))
                        print("Error Decoding, ", error.localizedDescription)
                        print("OUTPUT JSON: ", JSON(jsonResult))
                    }
                case .failure(let err):
                    completion(.failure(NetworkError.domainError))
                    print("Error Networking, ", err.localizedDescription)
                }
        }
    }
    
    func requestPOST<T>(resource: WebserviceResource<T>, completion: @escaping(Result<T>) -> Void){
        Alamofire.request(resource.url, method: .post, parameters: resource.parameters, encoding: resource.encoding as! ParameterEncoding, headers: resource.headers)
            .validate()
            .responseData { (responseData) in
                switch responseData.result{
                case .success(let data):
                    do{
                        let result = try JSONDecoder().decode(T.self, from: data)
                        completion(.success(result))
                    }catch{
                        if let error = error as? AFError {
                            switch error {
                            case .invalidURL(let url):
                                print("Invalid URL: \(url) - \(error.localizedDescription)")
                            case .parameterEncodingFailed(let reason):
                                print("Parameter encoding failed: \(error.localizedDescription)")
                                print("Failure Reason: \(reason)")
                            case .multipartEncodingFailed(let reason):
                                print("Multipart encoding failed: \(error.localizedDescription)")
                                print("Failure Reason: \(reason)")
                            case .responseValidationFailed(let reason):
                                print("Response validation failed: \(error.localizedDescription)")
                                print("Failure Reason: \(reason)")

                                switch reason {
                                case .dataFileNil, .dataFileReadFailed:
                                    print("Downloaded file could not be read")
                                case .missingContentType(let acceptableContentTypes):
                                    print("Content Type Missing: \(acceptableContentTypes)")
                                case .unacceptableContentType(let acceptableContentTypes, let responseContentType):
                                    print("Response content type: \(responseContentType) was unacceptable: \(acceptableContentTypes)")
                                case .unacceptableStatusCode(let code):
                                    print("Response status code was unacceptable: \(code)")
                                }
                            case .responseSerializationFailed(let reason):
                                print("Response serialization failed: \(error.localizedDescription)")
                                print("Failure Reason: \(reason)")
                            }
                        }
                        completion(.failure(error))
                    }
                case .failure(let error):
                    GlobalData.shared.jsonFailure = JSON(responseData.data!)
                    completion(.failure(error))
                    print("Error Networking, ", error.localizedDescription)
                }
        }
    }
}

final class GlobalData{
    static let shared = GlobalData()
    
    var jsonFailure: JSON?
    
    private init(){}
}

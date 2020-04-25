//
//  GetProviceRequest.swift
//  LibraryDemo
//
//  Created by Nanda Mochammad on 25/04/20.
//  Copyright © 2020 Nanda Mochammad. All rights reserved.
//

import Foundation

struct GetProvinceResponse: Codable{
    var rajaongkir: DataRequest
}

struct DataRequest: Codable{
    var query: [DataQuery]
    var status: DataStatus
    var results: [DataResult]
}

struct DataQuery: Codable{
    var id: String
}

struct DataStatus: Codable {
    var code: Int
    var description: String
}

struct DataResult: Codable{
    var province_id: String
    var province: String
}

extension GetProvinceResponse{
    static func resourceRequest()->WebserviceResource<GetProvinceResponse>{
        
        let url: String = "https://api.rajaongkir.com/starter/province"
        
        let headers = [
            "Content-Type": "application/json",
            "Accept": "application/json",
            "key": "0df6d5bf733214af6c6644eb8717c92c"
        ]
        
        return WebserviceResource<GetProvinceResponse>(url: URL(string: url)!, params: [:], headers: headers, encoding:
            "")
    }
}

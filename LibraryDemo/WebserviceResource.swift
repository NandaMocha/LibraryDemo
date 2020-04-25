//
//  PilihBenefitResource.swift
//  Philips
//
//  Created by Nanda Mochammad on 25/02/20.
//  Copyright © 2020 algostudio. All rights reserved.
//

import Foundation
import Alamofire

import Alamofire

struct WebserviceResource<T: Codable>{
    let url: URL
    var parameters: [String: Any]
    var headers: HTTPHeaders
    var encoding: String
    
    init(url: URL, params: [String: Any]?, headers: HTTPHeaders?, encoding: String?) {
        self.url = url
        self.parameters = params ?? [:]
        self.headers = headers ?? [:]
        self.encoding = encoding ?? ""
    }
}

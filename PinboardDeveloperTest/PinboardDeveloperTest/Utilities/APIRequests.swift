//
//  APIRequests.swift
//  ResourceDownloadManager
//
//  Created by Zaira Zafar on 28/05/2019.
//  Copyright © 2019 Zaira Zafar. All rights reserved.
//

import Foundation
import ResourceManager

class PhotosRequest: Endpoint {
    var baseURL: String!
    
    var url: String!
    
    var parameters: [String : Any]!
    
    var method: HTTPMethod!
        
    init(baseUrl: String, url: String, parameters: [String:Any], method: HTTPMethod) {
        self.baseURL = baseUrl
        self.url = url
        self.parameters = parameters
        self.method = method
    }
}


class Images: Endpoint {
    
    var baseURL: String!
    var url: String!
    var parameters: [String : Any]!
    var method: HTTPMethod!
    
    init(baseUrl: String, url: String, parameters: [String:Any], method: HTTPMethod) {
        self.baseURL = baseUrl
        self.url = url
        self.parameters = parameters
        self.method = method
    }
}

//
//  EndpointMock.swift
//  ResourceDownloadManagerTests
//
//  Created by Zaira Zafar on 30/05/2019.
//  Copyright © 2019 Zaira Zafar. All rights reserved.
//

import Foundation
@testable import ResourceManager

class MockAPI: Endpoint {
    
    var baseURL: String!
    
    var url: String!
    
    var parameters: [String : Any]!
    
    var method: HTTPMethod!
    
}

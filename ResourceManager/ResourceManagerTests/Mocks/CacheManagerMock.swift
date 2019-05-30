//
//  CacheManagerMock.swift
//  ResourceDownloadManagerTests
//
//  Created by Zaira Zafar on 30/05/2019.
//  Copyright © 2019 Zaira Zafar. All rights reserved.
//

import Foundation
@testable import ResourceManager

class CacheManagerMock: CacheResource {
    
    var isCached = false
    var limitReached = false
    var didGetFromCache = false
    
    func getCachedResource(url: String) -> Any? {
        if didGetFromCache == true {
            return "Sample return" }
        else{ return nil}
        
    }
    
    func cacheResource(url: String, data: Any) {
        isCached = true
    }
    
    func deleteExpiredData() {
        
    }
    
    func isLimitReached() -> Bool {
        limitReached = true
        return limitReached
    }
}

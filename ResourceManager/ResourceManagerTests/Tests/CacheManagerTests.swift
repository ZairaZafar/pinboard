//
//  CacheManagerTests.swift
//  ResourceDownloadManagerTests
//
//  Created by Zaira Zafar on 30/05/2019.
//  Copyright © 2019 Zaira Zafar. All rights reserved.
//

import XCTest
@testable import ResourceManager

class CacheManagerTests: XCTestCase {

    var cacheManager: CacheManager!
    
    override func setUp() {
        cacheManager = CacheManager(expireTimeInDays: 3, maximumLimit: 5)
        cacheManager.cacheResource(url: "http://stringurl.com", data: Data())
        cacheManager.cacheResource(url: "http://stringu3rl.com", data: Data())
//        cacheManager.cacheResource(url: "http://stringu32rl.com", data: Data())
    }

    func testCache(){
        cacheManager.cacheResource(url: "http://stringurl1.com", data: Data())
        XCTAssertEqual(cacheManager.isLimitReached(), false)
        cacheManager.cacheResource(url: "http://stringurl2.com", data: Data())
        cacheManager.cacheResource(url: "http://stringurl3.com", data: Data())
        cacheManager.cacheResource(url: "http://stringurl4.com", data: Data())
        cacheManager.cacheResource(url: "http://stringurl5.com", data: Data())
        XCTAssertEqual(cacheManager.isLimitReached(), true)

    }
    
    func testGetCachedData(){
        XCTAssertNotNil(cacheManager.getCachedResource(url: "http://stringurl.com"))
        XCTAssertNil(cacheManager.getCachedResource(url: "http://stringwurl.com"))
    }
    
    func testLastAccessed(){
        cacheManager.getCachedResource(url: "http://stringurl.com")
        XCTAssertNotNil(cacheManager.getNodeLeastAccessed())
    }
    

}

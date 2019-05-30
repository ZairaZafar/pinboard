//
//  ResourceManagerTests.swift
//  ResourceDownloadManagerTests
//
//  Created by Zaira Zafar on 30/05/2019.
//  Copyright © 2019 Zaira Zafar. All rights reserved.
//

import XCTest
@testable import ResourceManager

class ResourceManagerTests: XCTestCase {

    var resourceManager: ResourceManager!
    var networkManagerMock: NetworkManagerMock!
    var cacheResourceMock: CacheManagerMock!
    var mockEndpoint: MockAPI!
    
    override func setUp() {
        networkManagerMock = NetworkManagerMock()
        cacheResourceMock = CacheManagerMock()
        resourceManager = ResourceManager()
        resourceManager.configure(expireTimeInDays: 4, memoryMaximumLimit: 5, networkManager: networkManagerMock)
        resourceManager.resouceCache = cacheResourceMock
        
        mockEndpoint = MockAPI()
        mockEndpoint.baseURL = ""
        mockEndpoint.url = ""
    }

    func testCacheFetch() {
        cacheResourceMock.didGetFromCache = true
        resourceManager.fetch(endpoint: mockEndpoint){ data in
            if type(of: data) == Data.self {
                XCTAssertTrue(true)
                XCTAssertEqual(self.cacheResourceMock.didGetFromCache, true)
            }
            else {
                XCTAssertFalse(false)
            }
        }
    }
    
    func testNetworkFetch() {
        cacheResourceMock.didGetFromCache = false
        resourceManager.fetch(endpoint: mockEndpoint){ data in
            if type(of: data) == Data.self {
                XCTAssertTrue(true)
                XCTAssertEqual(self.networkManagerMock.didGetFromNetworkCall, true)
            }
            else {
                XCTAssertFalse(false)
            }
        }
    }
    
    func testNetworkDownload() {
        cacheResourceMock.didGetFromCache = false
        resourceManager.download(endpoint: mockEndpoint){ data in
            if type(of: data) == URL.self {
                XCTAssertTrue(true)
                XCTAssertEqual(self.networkManagerMock.didDownloadFromNetworkCall, true)
            }
            else {
                XCTAssertFalse(false)
            }
        }
    }
    
    func testCancel(){
        resourceManager.cancel(download: mockEndpoint)
        resourceManager.cancel(request: mockEndpoint)
        resourceManager.cancelAllDownload()
        resourceManager.cancelAllRequest()
        XCTAssertTrue(networkManagerMock.isRequestCancelled)
        XCTAssertTrue(networkManagerMock.isDownloadCancelled)
        XCTAssertTrue(networkManagerMock.allRequestsAreCancelled)
        XCTAssertTrue(networkManagerMock.allDownloadsAreCancelled)
    }
}

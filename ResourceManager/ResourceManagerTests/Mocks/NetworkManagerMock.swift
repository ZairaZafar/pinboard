//
//  NetworkManagerMock.swift
//  ResourceDownloadManagerTests
//
//  Created by Zaira Zafar on 30/05/2019.
//  Copyright © 2019 Zaira Zafar. All rights reserved.
//

import Foundation
@testable import ResourceManager

class NetworkManagerMock: NetworkRequest {
    
    var isRequestCancelled = false
    var allRequestsAreCancelled = false
    var isDownloadCancelled = false
    var allDownloadsAreCancelled = false
    var didGetFromNetworkCall = false
    var didDownloadFromNetworkCall = false

    func fetch(endpoint: Endpoint, completion: @escaping NetworkRequestCompletion) {
        didGetFromNetworkCall = true
        completion("", Data())
    }
    
    func download(endpoint: Endpoint, completion: @escaping DownloadRequestCompletion) {
        guard let url = URL(string: endpoint.baseURL + endpoint.url) else {return}
        didDownloadFromNetworkCall = true
        completion("", url)
    }
    
    func cancelAllDownloads() {
       allDownloadsAreCancelled = true
    }
    
    func cancel(download: Endpoint) {
        isDownloadCancelled = true
    }
    
    func cancel(request: Endpoint) {
        isRequestCancelled = true
    }
    
    func cancelAllRequests() {
       allRequestsAreCancelled = true
    }
}

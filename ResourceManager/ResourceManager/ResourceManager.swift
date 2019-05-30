//
//  ResourceManager.swift
//  ResourceDownloadManager
//
//  Created by Zaira Zafar on 25/05/2019.
//  Copyright © 2019 Zaira Zafar. All rights reserved.
//

import Foundation

public class ResourceManager: ResourceRequest {
    
    var networkManager: NetworkRequest!
    var resouceCache: CacheResource!
    
    public static var shared = ResourceManager()
    
    public func configure(expireTimeInDays: Int, memoryMaximumLimit: Int,
                          networkManager: NetworkRequest = NetworkManager()) {
        
        self.networkManager = networkManager
        self.resouceCache = CacheManager(expireTimeInDays: expireTimeInDays, maximumLimit: memoryMaximumLimit)
    }
    
    public func download(endpoint: Endpoint, completion: @escaping DownloadCompletedCallBack)  {
        
        if let cacheData = resouceCache.getCachedResource(url: endpoint.baseURL + endpoint.url) as? URL {
            completion(cacheData)
        }
        else {
            networkManager.download(endpoint: endpoint) { [weak self] url, data in
                guard let `self` = self else { return }
                self.resouceCache.cacheResource(url: url, data: data)
                completion(data)
            }
        }
    }
    
    
    public func fetch(endpoint: Endpoint, completion: @escaping DataFetchedCallBack) {
        
        if let cacheData = resouceCache.getCachedResource(url: endpoint.baseURL + endpoint.url) as? Data {
            
            completion(cacheData)
        }
        else {
            networkManager.fetch(endpoint: endpoint) {  [weak self] url, data in
                guard let `self` = self else { return }
                self.resouceCache.cacheResource(url: url, data: data)
                completion(data)
            }
        }
    }
    
    public func cancelAllRequest() {
        networkManager.cancelAllRequests()
    }
    
    public func cancel(request: Endpoint) {
        networkManager.cancel(request: request)
    }
    
    public func cancelAllDownload() {
        networkManager.cancelAllDownloads()
    }
    
    public func cancel(download: Endpoint) {
        networkManager.cancel(download: download)
    }
}

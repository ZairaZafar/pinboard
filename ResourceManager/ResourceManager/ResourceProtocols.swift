//
//  ResourceProtocols.swift
//  ResourceDownloadManager
//
//  Created by Zaira Zafar on 25/05/2019.
//  Copyright © 2019 Zaira Zafar. All rights reserved.
//

import Foundation

public protocol ResourceRequest: class {
    
    func download(endpoint: Endpoint, completion: @escaping DownloadCompletedCallBack)
    func fetch(endpoint: Endpoint, completion: @escaping DataFetchedCallBack)
    func cancelAllRequest()
    func cancel(request: Endpoint)
    func cancelAllDownload()
    func cancel(download: Endpoint)
    
}


public protocol CacheResource: class {
    func getCachedResource(url: String) -> Any?
    func cacheResource(url: String, data: Any)
    func deleteExpiredData()
    func isLimitReached()-> Bool
}

//
//  NetworkProtocols.swift
//  ResourceDownloadManager
//
//  Created by Zaira Zafar on 25/05/2019.
//  Copyright © 2019 Zaira Zafar. All rights reserved.
//

import Foundation

public protocol Endpoint {
    var baseURL: String! { get set}
    var url: String! { get set}
    var parameters: [String: Any]! { get set}
    var method: HTTPMethod! { get set}
    
}

public extension Endpoint {
    public func fetch(completion: @escaping DataFetchedCallBack){
        ResourceManager.shared.fetch(endpoint: self, completion: completion)
    }
    
    public func download(completion: @escaping DownloadCompletedCallBack){
        ResourceManager.shared.download(endpoint: self, completion: completion)
    }
    public func cancelRequest(){
        ResourceManager.shared.cancel(request: self)
    }
    
    public func cancelAllRequest(){
        ResourceManager.shared.cancelAllRequest()
    }
    
    public func cancelDownload(){
        ResourceManager.shared.cancel(download: self)
    }
    
    public func cancelAllDownload(){
        ResourceManager.shared.cancelAllDownload()
    }
}

public protocol NetworkRequest: class {
    
    typealias endpoint = Endpoint
    
    func fetch(endpoint: Endpoint, completion: @escaping NetworkRequestCompletion)
    func download(endpoint: Endpoint, completion: @escaping DownloadRequestCompletion)
    func cancelAllDownloads()
    func cancel(download: Endpoint)
    func cancel(request: Endpoint)
    func cancelAllRequests()
}

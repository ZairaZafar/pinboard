//
//  NetworkManager.swift
//  ResourceDownloadManager
//
//  Created by Zaira Zafar on 25/05/2019.
//  Copyright © 2019 Zaira Zafar. All rights reserved.
//

import Foundation

public class NetworkManager: NetworkRequest {
    
    let defaultSession = URLSession(configuration: .default)
    var taskList: [URL: URLSessionDataTask]!
    var downloadList: [URL: URLSessionDownloadTask]!
    
    public init(){
        taskList = [:]
        downloadList = [:]
        defaultSession.configuration.httpMaximumConnectionsPerHost = 10
    }
}

// Fetch requests
public extension NetworkManager {
    
    public func fetch(endpoint: endpoint, completion: @escaping NetworkRequestCompletion){
        
        guard let url = URL(string: endpoint.baseURL + endpoint.url) else {return}
        var dataTask: URLSessionDataTask?
        
        dataTask = defaultSession.dataTask(with: url){ [weak self] data, response, error in
            guard let `self` = self else { return }
            self.taskList[url] = dataTask
            guard let data = data, let response = response as? HTTPURLResponse,
                response.statusCode == 200
                else {
                    debugPrint("Fetch Error: \(String(describing: error))")
                    return
            }
            DispatchQueue.main.async {
                completion(url.description, data)
            }
        }
        dataTask?.resume()
    }
    
    
    public func cancel(request: Endpoint) {
        
        guard let url = URL(string: request.baseURL + request.url) else {return}
        taskList[url]?.cancel()
    }
    
    public func cancelAllRequests() {
        for task in taskList {
            task.value.cancel()
        }
    }
}

// Download Requests
public extension NetworkManager {
    
    public func download(endpoint: Endpoint, completion: @escaping DownloadRequestCompletion) {
        guard let url = URL(string: endpoint.baseURL + endpoint.url) else {return}
        var downloadTask: URLSessionDownloadTask?
        
        downloadTask = defaultSession.downloadTask(with: url) { [weak self] tempUrl, response, error in
            guard let `self` = self else { return }
            self.downloadList[url] = downloadTask
            guard let url = tempUrl, let response = response as? HTTPURLResponse,
                response.statusCode == 200
                else {
                    debugPrint("Download Error: \(String(describing: error))")
                    return
            }
            DispatchQueue.main.async {
                completion(url.description, url)
            }
        }
        downloadTask?.resume()
    }
    
    public func cancel(download: Endpoint) {
        
        guard let url = URL(string: download.baseURL + download.url) else {return}
        downloadList[url]?.cancel()
    }
    
    public func cancelAllDownloads() {
        for task in downloadList {
            task.value.cancel()
        }
    }
}

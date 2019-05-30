//
//  Constants.swift
//  ResourceDownloadManager
//
//  Created by Zaira Zafar on 25/05/2019.
//  Copyright © 2019 Zaira Zafar. All rights reserved.
//

import Foundation

public enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
}

public typealias NetworkRequestCompletion = (String, Data) -> ()

public typealias DownloadRequestCompletion = (String, URL) -> ()

public typealias DataFetchedCallBack = (Data) -> ()

public typealias DownloadCompletedCallBack = (URL) -> ()

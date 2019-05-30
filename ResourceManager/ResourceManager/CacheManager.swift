//
//  CacheManager.swift
//  ResourceDownloadManager
//
//  Created by Zaira Zafar on 27/05/2019.
//  Copyright © 2019 Zaira Zafar. All rights reserved.
//

import Foundation

public class CacheManager: CacheResource {
    
    class Node {
        var url: String
        var data: Any
        var lastAccessed: Date
        var nextNode: Node?
        
        init(url: String, data: Any) {
            self.url = url
            self.data = data
            self.lastAccessed = Date()
        }
    }
    
    var head: Node!
    var previous: Node!
    var next: Node!
    var maximumLimit: Int!
    var expireTimeInDays: Int!
    
    init(expireTimeInDays: Int, maximumLimit: Int) {
        self.expireTimeInDays = expireTimeInDays
        self.maximumLimit = maximumLimit
    }
    
    public func getCachedResource(url: String) -> Any? {
        
        if head == nil {
            return nil
        }
        
        var temp = head
        while temp?.nextNode != nil {
            if temp?.url == url {
                temp?.lastAccessed = Date()
                return temp?.data
            }
            temp = temp?.nextNode
        }
        
        if temp?.url == url {
            temp?.lastAccessed = Date()
            return temp?.data
        }
        
        return nil
    }
    
    public func cacheResource(url: String, data: Any) {
        
        if isLimitReached() {
            deleteExpiredData()
        }
        
        next = Node(url: url, data: data)
        if head == nil {
            head = next
            
        }
        if previous != nil {
            previous.nextNode = next
            previous = next
        }
        else {
            previous = next
        }
    }
    
    public func deleteExpiredData(){
        var temp = head
        var previous = temp
        
        let timeInterval = Double(expireTimeInDays*24*60*60)
        let expirationDate = Date().addingTimeInterval(-timeInterval)
        
        if head == nil {
            return
        }
        
        while temp?.nextNode != nil {
            if temp?.lastAccessed == expirationDate {
                previous?.nextNode = temp?.nextNode
                debugPrint("Data deleted")
                return
            }
            previous = temp
            temp = temp?.nextNode
        }
        
        if temp?.lastAccessed == expirationDate {
            previous?.nextNode = nil
            debugPrint("Data deleted")
        } else {
            var nodeToDelete: Node, previousNode: Node
            
            (nodeToDelete, previousNode) = getNodeLeastAccessed()
            previousNode.nextNode = nodeToDelete.nextNode
        }
    }
    
    func getNodeLeastAccessed() -> (Node, Node) {
        var temp = head
        var leastAccessedNode: Node!
        var previousNodeToLastAccessed: Node!
        var previous = temp
        var totalNodeCount = 1
        
        while temp?.nextNode != nil {
            if let temp = temp, let nextNode = temp.nextNode,
                temp.lastAccessed < nextNode.lastAccessed {
                leastAccessedNode = temp
                previousNodeToLastAccessed = previous
            }
            previous = temp
            temp = temp?.nextNode
            totalNodeCount += 1
        }
        if totalNodeCount == 2 {
            leastAccessedNode = temp
            previousNodeToLastAccessed = previous
        }
        
        return (leastAccessedNode, previousNodeToLastAccessed)
    }
    
    public func isLimitReached() -> Bool {
        var count = 0
        var temp = head
        while temp != nil {
            count += 1
            temp = temp?.nextNode
        }
        
        if count == maximumLimit {
            return true
        }
        return false
    }
    
}




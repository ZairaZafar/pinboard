//
//  JsonClasses.swift
//  ResourceDownloadManager
//
//  Created by Zaira Zafar on 28/05/2019.
//  Copyright © 2019 Zaira Zafar. All rights reserved.
//

import Foundation

class Photos: Codable {
    var id: String
    var created_at: String
    var width: Int
    var height: Int
    var color: String
    var likes: Int
    var liked_by_user: Bool
    var user: User
    var current_user_collections: [CurrentUserCollections]
    var urls: Urls
    var categories: [Categories]
    var links: Links
}

class User: Codable {
    var id: String
    var username: String
    var name: String
    var profile_image: ProfileImages
    var links: UserLinks
}

class CurrentUserCollections: Codable {
    
}

class Urls: Codable {
    var raw: String
    var full: String
    var regular: String
    var small: String
    var thumb: String
}

class Categories: Codable {
    var id: Int
    var title: String
    var photo_count: Int
    var links: CategoryLinks
}

class Links: Codable {
    var selfLink: String
    var html: String
    var download: String
    
    enum CodingKeys: String, CodingKey {
        
        case selfLink = "self"
        case html = "html"
        case download = "download"
    }
    
    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        selfLink = try values.decodeIfPresent(String.self, forKey: .selfLink) ?? ""
        html = try values.decodeIfPresent(String.self, forKey: .html) ?? ""
        download = try values.decodeIfPresent(String.self, forKey: .download) ?? ""
    }
    
}

class ProfileImages: Codable {
    var small: String
    var medium: String
    var large: String
    
}

class UserLinks: Codable {
    var selfLink: String
    var html: String
    var photos: String
    var likes: String
    
    enum CodingKeys: String, CodingKey {
        
        case selfLink = "self"
        case html = "html"
        case photos = "photos"
        case likes = "likes"
    }
    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        selfLink = try values.decodeIfPresent(String.self, forKey: .selfLink) ?? ""
        html = try values.decodeIfPresent(String.self, forKey: .html) ?? ""
        photos = try values.decodeIfPresent(String.self, forKey: .photos) ?? ""
        likes = try values.decodeIfPresent(String.self, forKey: .likes) ?? ""
    }
}

class CategoryLinks: Codable {
    var selfLink: String
    var photos: String
    
    enum CodingKeys: String, CodingKey {
        
        case selfLink = "self"
        case photos = "photos"
    }
    
    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        selfLink = try values.decodeIfPresent(String.self, forKey: .selfLink) ?? ""
        photos = try values.decodeIfPresent(String.self, forKey: .photos) ?? ""
    }
}

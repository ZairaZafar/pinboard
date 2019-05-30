//
//  DataManager.swift
//  ResourceDownloadManager
//
//  Created by Zaira Zafar on 28/05/2019.
//  Copyright © 2019 Zaira Zafar. All rights reserved.
//

import Foundation
import UIKit
import ResourceManager


protocol ViewProtocols {
    func viewReload()
}

class DataManager {
    
    var images: [UIImage] = []
    var delegate: ViewProtocols!
    var photos: [Photos]!
    var likes: [Int] = []
    var categories: [String] = []
    var user: [String] = []
    
    init() {
        ResourceManager.shared.configure(expireTimeInDays: 3, memoryMaximumLimit: 50)
    }
    
    func request(photos: Endpoint){
        
        photos.fetch { data in
            let decoder = JSONDecoder()
            do {
                self.photos = try decoder.decode([Photos].self, from: data)
            } catch {
                print(error)
            }
            self.mapImages()
        }
    }
    
    func mapImages() {
        
        let image = Images(baseUrl: "", url: "", parameters: [:], method: .get)
        
        for photo in photos {
            
            likes.append(photo.likes)
            categories.append(photo.categories.first?.title ?? "")
            user.append(photo.user.name)
            image.url = photo.links.download
            
            image.fetch() { data in
                let resizedImage = self.imageWithImage(image: UIImage(data: data) ?? UIImage(), scaledToSize: CGSize(width: 364, height: 165))
                self.images.append(resizedImage)
                self.delegate.viewReload()
            }
        }
    }
    
    func imageWithImage(image:UIImage, scaledToSize newSize:CGSize) -> UIImage{
        UIGraphicsBeginImageContextWithOptions(newSize, false, 0.0);
        image.draw(in: CGRect(origin: CGPoint.zero, size: CGSize(width: newSize.width, height: newSize.height)))
        let newImage:UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return newImage
    }
}


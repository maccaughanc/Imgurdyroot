//
//  ImgurAPI.swift
// 
//  Provides Interpretation services to access the Imgur API
//
//
//  Created by Colt MacCaughan on 6/17/16.
//  Copyright © 2016 Rion Apps. All rights reserved.
//

import Foundation
import SwiftyJSON
import Alamofire

enum endpointURL: String {
    
    case mainGallery = "gallery/hot/viral/0.json"
    case imageGallery = "gallery/image/"
    case albumGallery = "gallery/album/"
}


struct ImgurAPI {
    
    private static let clientID = "f0c8cd7b0e81af2"
    private static let baseURLString = "https://api.imgur.com/3/"
    
    // Allows non-OAuth requests
    static func getAuthHeader() -> [String:String] {
        return ["Authorization":"Client-ID "+clientID]
    }
    
    static func getMainGalleryURL() -> NSURL {
        let url = NSURL(string: baseURLString)!
        return url.URLByAppendingPathComponent(endpointURL.mainGallery.rawValue, isDirectory: false)
    }
    
    static func getPhotosFromJSONData(json: JSON) -> [Photo] {
        
        var photos = [Photo]()
        
        // JSON photo data contained in array to initialize photos
        for (_, subJson):(String, JSON) in json["data"] {
            if let id = subJson["id"].string,
                title = subJson["title"].string,
                dateTime = subJson["datetime"].int,
                isAlbum = subJson["is_album"].bool,
                imageCount = subJson["images_count"].int {
                
                photos.append(Photo.init(id: id,
                    title: title,
                    dateTime: dateTime,
                    imageCount: imageCount,
                    isAlbum: isAlbum))
            }
        }
        
        return photos
    }
    
    static func getImageURL(photo: Photo) -> NSURL {
        
        let url = NSURL(string: baseURLString)!
        
        var path: String
        if photo.isAlbum {
            path = endpointURL.albumGallery.rawValue
        } else {
            path = endpointURL.imageGallery.rawValue
        }
        path.appendContentsOf(photo.id)
        
        print(url.URLByAppendingPathComponent(path, isDirectory: false))
        
        return url.URLByAppendingPathComponent(path, isDirectory: false)
    }
    
    static func getDirectURLFromJSONObject(json: JSON,
                                           photoIsAlbum: Bool) -> NSURL? {
        
        if photoIsAlbum {
            guard let urlString = json["data"]["images"][0]["link"].string,
            let url = NSURL(string: urlString) else {
                return nil
            }
            return url
        } else {
            guard let urlString = json["data"]["link"].string,
            let url = NSURL(string: urlString) else {
                return nil
            }
            return url
        }
    }
}



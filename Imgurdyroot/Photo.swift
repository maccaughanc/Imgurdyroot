//
//  Photo.swift
//  Imgurdyroot
//
//  Created by Colt MacCaughan on 6/17/16.
//  Copyright © 2016 Rion Apps. All rights reserved.
//

import UIKit

class Photo {
    
    let id: String
    let title: String
    let dateTime: NSDate
    let imageCount: Int
    let isAlbum: Bool
    var imageURL: NSURL?
    var image: UIImage?
    
    
    init(id: String, title: String, dateTime: Int,
         imageCount: Int, isAlbum: Bool) {
        
        self.id = id
        self.title = title
        self.imageCount = imageCount
        self.isAlbum = isAlbum
        
        // dateTime originally in Epoch time (seconds since 1970)
        self.dateTime = NSDate.init(timeIntervalSince1970: Double(dateTime))
    }
}




extension Photo: Equatable {}

// Added to allow indexing of the photo class
func ==(lhs: Photo, rhs: Photo) -> Bool {
    return lhs.id == rhs.id
}
//
//  GalleryAlbum.swift
//  Imgurdyroot
//
//  Created by Colt MacCaughan on 6/22/16.
//  Copyright © 2016 Rion Apps. All rights reserved.
//

import Foundation

class GalleryAlbum {
    
    let id: String
    let title: String
    let description: String
    let dateTime: NSDate
    let coverID: String
    let views: Int
    let link: NSURL
    let upVotes: Int
    let downVotes: Int
    let imageCount: Int
    let images: [Image]
    
    init(id: String,
         title: String,
         description: String,
         dateTime: Int,
         coverID: String,
         views: Int,
         link: String,
         upVotes: Int,
         downVotes: Int,
         imageCount: Int,
         images: [Image]) {
        
        self.id = id
        self.title = title
        self.description = description
        self.dateTime = NSDate.init(timeIntervalSince1970: Double(dateTime))
        self.coverID = coverID
        self.views = views
        self.link = NSURL(string: link)!
        self.upVotes = upVotes
        self.downVotes = downVotes
        self.imageCount = imageCount
        self.images = images
    }
    
}


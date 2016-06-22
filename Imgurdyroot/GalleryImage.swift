//
//  GalleryImage.swift
//  Imgurdyroot
//
//  Created by Colt MacCaughan on 6/22/16.
//  Copyright © 2016 Rion Apps. All rights reserved.
//

import Foundation

class GalleryImage {
    
    let id: String
    let title: String
    let description: String
    let dateTime: Int
    let type: String
    let views: Int
    let link: String
    let mp4: String?
    let commentCount: Int
    let upVotes: Int
    let downVotes: Int
    
    init(id: String,
        title: String,
        description: String,
        dateTime: Int,
        type: String,
        views: Int,
        link: String,
        mp4: String?,
        commentCount: Int,
        upVotes: Int,
        downVotes: Int) {
        
        self.id = id
        self.title = title
        self.description = description
        self.dateTime = dateTime
        self.type = type
        self.views = views
        self.link = link
        self.mp4 = mp4
        self.commentCount = commentCount
        self.upVotes = upVotes
        self.downVotes = downVotes
    }
    
}

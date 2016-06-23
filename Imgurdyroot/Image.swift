//
//  Image.swift
//  Imgurdyroot
//
//  Created by Colt MacCaughan on 6/22/16.
//  Copyright © 2016 Rion Apps. All rights reserved.
//

import Foundation

class Image {
    
    let id: String
    let title: String?
    let description: String?
    let dateTime: NSDate
    let type: String
    let views: Int
    let url: NSURL
    let mp4: NSURL?
    
    init(id: String,
         title: String?,
         description: String?,
         dateTime: Int,
         type: String,
         views: Int,
         link: String,
         mp4: String?) {
        
        self.id = id
        self.title = title
        self.description = description
        self.dateTime = NSDate.init(timeIntervalSince1970: Double(dateTime))
        self.type = type
        self.views = views
        self.url = NSURL(string: link)!
        
        if let mp4 = mp4 {
            self.mp4 = NSURL(string: mp4)
        } else {
            self.mp4 = nil
        }
    }
    
}
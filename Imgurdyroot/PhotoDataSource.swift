//
//  CollectionViewDataSource.swift
//  Sample Imgur App
//
// Source: Big Nerds Guide (2015)
//
//  Created by Colt MacCaughan on 6/17/16.
//  Copyright © 2016 Rion Apps. All rights reserved.
//

import UIKit

class PhotoDataSource: NSObject, UICollectionViewDataSource{
    
    var photo = [Photo]()
    
    func collectionView(collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        return photo.count
    }
    
    func collectionView(collectionView: UICollectionView,
                        cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let identifier = "UICollectionViewCell"
        
        let cell =
            collectionView.dequeueReusableCellWithReuseIdentifier(identifier,
                                                                  forIndexPath: indexPath) as! PhotoCollectionViewCell
        
        return cell
    }
}

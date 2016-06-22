//
//  ViewController.swift
//  Sample Imgur App
//
//  Created by Colt MacCaughan on 6/17/16.
//  Copyright © 2016 Rion Apps. All rights reserved.
//
//


import UIKit
import PromiseKit

class PhotosViewController: UIViewController,
        UICollectionViewDelegate,
        UICollectionViewDelegateFlowLayout {
    
    @IBOutlet var collectionView: UICollectionView!
    var store: PhotoStore!
    var photoDataSource = PhotoDataSource()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.dataSource = photoDataSource
        collectionView.delegate = self
        
        store.fetchRecentPhotos() {
            (photos) -> Void in
            
            self.photoDataSource.photo = photos!
            self.collectionView.reloadSections(NSIndexSet(index: 0))
        }
    }
    
    // MARK: - Collection View Methods
    func collectionView(collectionView: UICollectionView,
        willDisplayCell cell: UICollectionViewCell,
        forItemAtIndexPath indexPath: NSIndexPath) {
        
        
        let photo = photoDataSource.photo[indexPath.row]
        
        // With PromiseKit, the requests become synchronized.
        firstly {
                store.fetchDirectURLforImage(photo)
            }.then {_ in
                self.store.fetchImageForPhoto(photo)
            }.then {obj -> Void in
                let photoIndex = self.photoDataSource.photo.indexOf(photo)
                let photoIndexPath = NSIndexPath(forRow: photoIndex!, inSection: 0)
                
                // View only updated if cell still visible
                if let cell =
                    self.collectionView.cellForItemAtIndexPath(photoIndexPath) as? PhotoCollectionViewCell {
                    
                    cell.updateWithImage(photo.image)
                }
        }
    }
    
    override func traitCollectionDidChange(previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        
        // Allows collection to be updated when device is rotated
        collectionView.collectionViewLayout.invalidateLayout()
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
    }
    
    
    // Adapts size of collection view cells to display four in a row
    func collectionView(collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                               sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        
        let flowLayout = collectionViewLayout as! UICollectionViewFlowLayout
        
        // Give enough space for three images in a row
        let width = (collectionView.frame.width - flowLayout.sectionInset.left -
            flowLayout.sectionInset.right -
            flowLayout.minimumInteritemSpacing*2) / 3
        
        return CGSize(width: width, height: width)
    }
}


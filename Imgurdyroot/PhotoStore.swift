//
//  PhotoStore.swift
//  ImgurdyRoot
//
//  Created by Colt MacCaughan on 6/17/16.
//  Copyright © 2016 Rion Apps. All rights reserved.
//

import UIKit
import Alamofire
import PromiseKit
import SwiftyJSON

enum PhotoError: ErrorType {
    case ImageCreationError
    case JSONError
}

enum ImageResult {
    case Success(UIImage)
    case Failure(PhotoError)
}

class PhotoStore {
    
    // MARK: - Photo Request Methods
    func fetchRecentPhotos(completion: ([Photo]?) -> Void) {
        
        Alamofire.request(
            .GET,
            ImgurAPI.getMainGalleryURL(),
            parameters: ["nsfw": "false"],
            headers: ImgurAPI.getAuthHeader())
            .validate()
            .responseJSON {
                response in
                switch response.result {
                case .Success:
                    if let value = response.result.value {
                        let photos = ImgurAPI.getPhotosFromJSONData(JSON(value))
                        completion(photos)
                    }
                case .Failure(let error):
                    print(error)
                }
        }
        
    }
    
    func fetchImageForPhoto(photo: Photo) -> Promise<UIImage> {
        
        return Promise { fulfull, rejection in
            Alamofire.request(.GET,
                photo.imageURL!,
                headers: ImgurAPI.getAuthHeader())
                .validate()
                .responseData {
                    response in
                    switch response.result {
                    case .Success:
                        if let data = response.data {
                            let imageResult = self.processImageData(data)
                            
                            if case let .Success(image) = imageResult {
                                photo.image = image
                                fulfull(image)
                            } else {
                                rejection(PhotoError.ImageCreationError)
                            }
                        }
                    case .Failure(let error):
                        rejection(error)
                    }
                    
            }
            
        }
        
    }
    
    func fetchDirectURLforImage(photo: Photo) -> Promise<NSURL> {
        
        return Promise {fulfill, rejection in
            let imageURL = ImgurAPI.getImageURL(photo)
            
            Alamofire.request(.GET,
                imageURL,
                headers: ImgurAPI.getAuthHeader())
                .validate()
                .responseJSON {
                    response in
                    switch response.result {
                        
                    case .Success:
                        guard let value = response.result.value,
                            let url = ImgurAPI.getDirectURLFromJSONObject(
                                JSON(value),
                                photoIsAlbum: photo.isAlbum) else {
                                    rejection(PhotoError.JSONError)
                                    break
                        }
                        photo.imageURL = url
                        fulfill(url)
                        
                    case .Failure(let error):
                        rejection(error)
                    }
            }
        }
    }
    
    // MARK: - Image Processing Methods
    private func processImageDataFromFile(fileURL: NSURL) -> ImageResult {
        
        guard let image = UIImage(contentsOfFile: fileURL.path!) else {
            return .Failure(PhotoError.ImageCreationError)
        }
        
        return .Success(image)
    }
    
    private func processImageData(data: NSData) -> ImageResult {
        
        guard let image = UIImage(data: data) else {
            return .Failure(PhotoError.ImageCreationError)
        }
        
        return .Success(image)
    }
}
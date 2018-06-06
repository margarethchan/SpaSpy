//
//  StorageService.swift
//  SpaSpy
//
//  Created by C4Q on 6/4/18.
//  Copyright © 2018 C4Q. All rights reserved.
//

import Foundation
import FirebaseStorage
import Firebase
import UIKit

class StorageService {
    
    private init() {
        storage = Storage.storage()
        storageRef = storage.reference()
        imagesRef = storageRef.child("images")
    }
    static let manager = StorageService()
    private var storage: Storage!
    private var storageRef: StorageReference!
    private var imagesRef: StorageReference!
    
    public func storeImage(_ image: UIImage, imageID: String) -> StorageUploadTask? {
        let ref  = imagesRef.child(imageID)
        guard let imageData = UIImagePNGRepresentation(image) else { return nil }
        let metaData = StorageMetadata()
        metaData.contentType = "image/png"
        return ref.putData(imageData, metadata: metaData, completion: { (storageMetaData, error) in
            if let error = error {
                print(error.localizedDescription)
            }
        })
    }
    public func storeReportImage(withImage image: UIImage?, reportID: String, andImageID imageID: String, completion: @escaping (_ error: String?, _ imageURLString: String?) -> Void) {
        guard let image = image else {
            print("No image uploaded"); return }
        let savedImageID = reportID + "_" + imageID
        guard let uploadTask = StorageService.manager.storeImage(image, imageID: savedImageID) else {
            completion("Error uploading image", nil)
            return
        }
        uploadTask.observe(.success) { (taskSnapshot) in
            taskSnapshot.reference.downloadURL(completion: { (url, error) in
                if let error = error {
                    print("error downloading url: \(error.localizedDescription)")
                } else if let url = url {
                    completion(nil, url.absoluteString)
                    print("image url: \(url.absoluteString)")
                }
            })
        }
        uploadTask.observe(.failure) { (snapshot) in
            if let error = snapshot.error {
                print(error.localizedDescription)
            }
        }
    }
    
    
    
    
    /// NEW METHODS FOR IMAGE STORAGE UPLOAD/DOWNLOAD
    
    
    //    public func downloadImagesFromStorage(images: [UIImage]?, reportID: String) {
    //        guard let images = images else { return }
    //        for image in images {
    //            let imageURLString = reportID + (images.index(of: image)?.description)!
    //            let storageRef = Storage.storage().reference()
    //            let downloadImageRef = storageRef.child("images/\(imageURLString)")
    //
    //            downloadImageRef.getData(maxSize: 1 * 1024 * 1024) { (data, error) in
    //                if let error = error {
    //                    print("download image error: \(error.localizedDescription)")
    //                } else if let data = data {
    //                    let image = UIImage.init(data: data)
    //                    print("Uploaded image")
    //                }
    //            }
    //
    //        }
    //    }
    
    
}

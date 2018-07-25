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
import FirebaseDatabase
import UIKit

class StorageService {
    
    private init() {
        storage = Storage.storage()
        storageRef = storage.reference()
    }
    static let manager = StorageService()
    private var storage: Storage!
    public var storageRef: StorageReference!
    public var reportRef: StorageReference!
    
    public func uploadReportImages(reportImages: [UIImage], toReportID reportID: String) {
        let reportRef = storageRef.child(reportID)
        
        uploadImages(reportImages: reportImages, toReportID: reportID, fromIndex: 0)
    }
    
    public func uploadImages(reportImages: [UIImage], toReportID reportID: String, fromIndex index: Int) {
        
        let reportRef = storageRef.child(reportID)
        
        if index < reportImages.count {
            let imagePath = reportRef.child("\(index)")
            guard let imageData = UIImageJPEGRepresentation(reportImages[index], 1) else { return }
            
            let metadata = StorageMetadata()
            metadata.contentType = "image/jpeg"
            
            let uploadTask = imagePath.putData(imageData, metadata: metadata) { (metadata, error) in
                guard let metadata = metadata else {
                    print("Error uploading image: \(error)")
                    return
                }
            }
            uploadTask.observe(.success) { (taskSnapshot) in
                taskSnapshot.reference.downloadURL(completion: { (url, error) in
                    if let error = error {
                        print("\tUnable to create downloadURL: \(error)")
                    } else if let url = url {
                        DBService.manager.ref.child("reports").child(reportID).child("imageURLs").child("\(index)").setValue(url.absoluteString)
                        print("\tdownloadURL: \(url.absoluteString)")
                    }
                })
            }
            uploadTask.observe(.failure) { (taskSnapshot) in
                if let error = taskSnapshot.error {
                    print("Failed to create downloadURL: \(error)")
                }
            }
            uploadImages(reportImages: reportImages, toReportID: reportID, fromIndex: index + 1)
            return
        }
    }
}

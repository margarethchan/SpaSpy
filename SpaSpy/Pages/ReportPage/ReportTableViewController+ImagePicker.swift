//
//  ReportTableViewController+ImagePicker.swift
//  SpaSpy
//
//  Created by C4Q on 5/23/18.
//  Copyright © 2018 C4Q. All rights reserved.
//

import UIKit
import AVFoundation

extension ReportTableViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    /// PHOTOS
    
    @objc public func addImageButtonPressed() {
        
        let photoAlert = Alert.create(withTitle: "Upload a Photo", andMessage: nil, withPreferredStyle: .actionSheet)
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            Alert.addAction(withTitle: "Camera", style: .default, andHandler: { (_) in
                self.imagePickerVC.sourceType = .camera
                self.checkAVAuthorization()
            }, to: photoAlert)
        }
        Alert.addAction(withTitle: "Photo Library", style: .default, andHandler: { (_) in
            self.imagePickerVC.sourceType = .photoLibrary
            self.checkAVAuthorization()
        }, to: photoAlert)
        Alert.addAction(withTitle: "Cancel", style: .cancel, andHandler: nil, to: photoAlert)
        self.present(photoAlert, animated: true, completion: nil)
    }
    
    private func checkAVAuthorization() {
        let status = AVCaptureDevice.authorizationStatus(for: .video)
        switch status {
        case .notDetermined:
            print("notDetermined")
            AVCaptureDevice.requestAccess(for: .video, completionHandler: { (granted) in
                if granted {
                    self.showImagePicker()
                } else {
                    self.deniedPhotoAlert()
                }
            })
        case .denied:
            print("denied")
            deniedPhotoAlert()
        case .authorized:
            print("authorized")
            showImagePicker()
        case .restricted:
            print("restricted")
        }
    }
    
    public func showImagePicker() {
        present(imagePickerVC, animated: true, completion: nil)
    }
    
    
    private func deniedPhotoAlert() {
        let settingsAlert = Alert.create(withTitle: "Please Allow Photo Access", andMessage: "This will allow you to share photos from your library and your camera.", withPreferredStyle: .alert)
        Alert.addAction(withTitle: "Cancel", style: .cancel, andHandler: nil, to: settingsAlert)
        Alert.addAction(withTitle: "Settings", style: .default, andHandler: { (_) in
            UIApplication.shared.open(URL(string: UIApplicationOpenSettingsURLString)!, options: [:], completionHandler: nil)
        }, to: settingsAlert)
        self.present(settingsAlert, animated: true, completion: nil)
    }
    
    @objc func removeLastPhoto() {
        if uploadedPhotos.count > 0 {
            uploadedPhotos.popLast()
            print("remove last photo")
            let tvc = self.tableView.cellForRow(at: IndexPath(row: 0, section: 0)) as! PhotosTableViewCell
            self.tableView.reloadData()
        } else {
            print("no photos to remove")
            
            let noPhotoAlert = Alert.createErrorAlert(withMessage: "No Photos to Remove")
            //Present the controller
            self.present(noPhotoAlert, animated: true, completion: nil)
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        guard (info[UIImagePickerControllerOriginalImage] as? UIImage) != nil else { print("image is nil"); return }
        
        var selectedImageFromImagePicker: UIImage?
        
        if let editedImage = info["UIImagePickerControllerEditedImage"] as? UIImage {
            selectedImageFromImagePicker = editedImage
        } else if let originalImage = info["UIImagePickerControllerOriginalImage"] as? UIImage {
            selectedImageFromImagePicker = originalImage
        }
        
        // refer to the path of the photo collection view image view selected
        let photoTVC = self.tableView.cellForRow(at: IndexPath(row: 0, section: 0)) as! PhotosTableViewCell
        
        if let selectedImage = selectedImageFromImagePicker {
            DispatchQueue.main.async {
                
                //                self.currentSelectedPhotoCell.addImageIcon.image = selectedImage
                self.uploadedPhotos.append(selectedImage)
                
                photoTVC.photosCollectionView.reloadData()
                self.tableView.reloadData()
            }
        }
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
}


//
//  ReportTableViewController.swift
//  SpaSpy
//
//  Created by C4Q on 4/26/18.
//  Copyright © 2018 C4Q. All rights reserved.
//

import UIKit
import AVFoundation

class ReportTableViewController: UITableViewController {

    public var uploadedPhotos = [UIImage]() {
        didSet {
            print("------Image added to uploadedPhotos: \(uploadedPhotos)")
        }
    }
    public var selectedBusinessTypes = [String]()
    private var selectedLocation = "selectedLocation"
    private var selectedRedFlags = [String]()
    private var enteredNumbers = ""
    private var enteredWebpages = ""
    private var enteredNotes = ""
    
    private let imagePickerVC = UIImagePickerController()
    private var currentSelectedImage: UIImage!
    public var currentSelectedPhotoCell: AddPhotoCollectionViewCell!
    public var currentSelectedPhotoCellIndexPath: IndexPath!
    
    // UICollectionView reference values
    let sectionInsets = UIEdgeInsets(top: 10.0, left: 10.0, bottom: 10.0, right: 10.0)
    let itemsPerRow: CGFloat = 4
    
    @IBAction func clearFormButton(_ sender: UIBarButtonItem) {
        print("clear form")
    }
    
    @IBAction func reportButton(_ sender: UIBarButtonItem) {
        print("submit report")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.estimatedRowHeight = 150
        self.tableView.reloadData()
        self.tableView.allowsSelection = false
        self.tableView.bounces = false
        self.tableView.separatorStyle = .none
        

    }

    @objc public func changeImageButtonTapped() {
        
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
        //Present the controller
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
    
    private func showImagePicker() {
        imagePickerVC.delegate = self
        imagePickerVC.sourceType = .photoLibrary
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
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 7
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        switch indexPath.row {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "PhotosTableViewCell", for: indexPath) as! PhotosTableViewCell
            cell.backgroundColor = .yellow
            cell.photosCollectionView.backgroundColor = .yellow
            cell.photosCollectionView.delegate = self
            cell.photosCollectionView.dataSource = self
            cell.photosCollectionView.tag = 0
            cell.addPhotoButton.addTarget(self, action: #selector(changeImageButtonTapped), for: .touchUpInside)
            cell.removePhotoButton.addTarget(self, action: #selector(removeLastPhoto), for: .touchUpInside)
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: "AddressTableViewCell", for: indexPath) as! AddressTableViewCell
            cell.addLocationButton.addTarget(self, action: #selector(addLocation), for: .touchUpInside)
            cell.mapIconButton.addTarget(self, action: #selector(addLocation), for: .touchUpInside)
            cell.addLocationButton.setTitle("Add Location", for: .normal)
//            cell.addLocationButton.setTitle(selectedLocation, for: .selected)
            cell.addLocationButton.addTarget(self, action: #selector(addLocation), for: .touchUpInside)
            cell.backgroundColor = .green
            return cell
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: "BusinessTypeTableViewCell", for: indexPath) as! BusinessTypeTableViewCell
            cell.backgroundColor = .blue
            cell.businessTypeCollectionView.backgroundColor = .yellow
            cell.businessTypeCollectionView.delegate = self
            cell.businessTypeCollectionView.dataSource = self
            cell.businessTypeCollectionView.tag = 1
            cell.businessTypeCollectionView.allowsMultipleSelection = true
            return cell
        case 3:
            let cell = tableView.dequeueReusableCell(withIdentifier: "RedFlagsTableViewCell", for: indexPath) as! RedFlagsTableViewCell
            cell.backgroundColor = .cyan
            cell.addRedFlagsButton.addTarget(self, action: #selector(selectRedFlags), for: .touchUpInside)
            return cell
        case 4:
            let cell = tableView.dequeueReusableCell(withIdentifier: "NumbersTableViewCell", for: indexPath) as! NumbersTableViewCell
            cell.backgroundColor = .red
        return cell
        case 5:
            let cell = tableView.dequeueReusableCell(withIdentifier: "WebpagesTableViewCell", for: indexPath) as! WebpagesTableViewCell
            cell.backgroundColor = .orange
            return cell
        case 6:
            let cell = tableView.dequeueReusableCell(withIdentifier: "NotesTableViewCell", for: indexPath) as! NotesTableViewCell
            cell.backgroundColor = .brown
            return cell
        default:
            let cell = UITableViewCell()
            return cell
        }
    }

    
    @objc func removeLastPhoto() {
        if uploadedPhotos.count > 0 {
        uploadedPhotos.popLast()
            print("remove last photo")
            let tvc = self.tableView.cellForRow(at: IndexPath(row: 0, section: 0)) as! PhotosTableViewCell
            tvc.photosCollectionView.reloadData()
        } else {
            print("no photos to remove")
            
            let noPhotoAlert = Alert.createErrorAlert(withMessage: "No Photos to Remove")
            //Present the controller
            self.present(noPhotoAlert, animated: true, completion: nil)
        }
    }
    
    
    @objc func addPhoto() {
        let cameraVC = CameraViewController()
        cameraVC.modalPresentationStyle = .overFullScreen
        cameraVC.modalTransitionStyle = .crossDissolve
        self.present(cameraVC, animated: false, completion: nil)

        print("open add photo view")
    }
    
    @objc func addLocation() {
        let locationVC = LocationViewController()
        locationVC.modalPresentationStyle = .overFullScreen
        locationVC.modalTransitionStyle = .crossDissolve
        self.present(locationVC, animated: false, completion: nil)
        
        print("open add location view")
    }
    
    @objc func selectRedFlags() {
        let flagsVC = FlagsViewController()
        flagsVC.modalPresentationStyle = .overFullScreen
        flagsVC.modalTransitionStyle = .crossDissolve
        self.present(flagsVC, animated: false, completion: nil)

        print("open modal red flags view")
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}


extension ReportTableViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {

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
            }
        }
        dismiss(animated: true, completion: nil)
    }

    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
}


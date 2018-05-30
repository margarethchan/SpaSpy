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
//            if uploadedPhotos.count > 0 {
//                self.tableView.cellForRow(at: 0)..removePhotoButton.isHidden = false
//            } else {
//                cell.removePhotoButton.isHidden = true
//            }
        }
    }
    private var selectedLocation = "selectedLocation"
    public var selectedBusinessTypes = [String]()
    private var selectedRedFlags = [String]()
    private var enteredNumbers = ""
    private var enteredWebpages = ""
    private var enteredNotes = ""
    
    public let imagePickerVC = UIImagePickerController()
    private var currentSelectedImage: UIImage!
//    public var currentSelectedPhotoCell: AddPhotoCollectionViewCell!
//    public var currentSelectedPhotoCellIndexPath: IndexPath!
    
    // UICollectionView reference values
    let sectionInsets = UIEdgeInsets(top: 10.0, left: 10.0, bottom: 10.0, right: 10.0)
    let itemsPerRow: CGFloat = 4
    
    /// NAV BAR BUTTONS
    
    @IBAction func clearFormButton(_ sender: UIBarButtonItem) {
        print("clear form")
    }
    
    @IBAction func reportButton(_ sender: UIBarButtonItem) {
        print("submit report")
        // capture the values from each tableviewcell and save to Firebase
        // uploadedPhotos= [UIImage]
        // selectedLocation = String
        // selectedBusinessTypes = [String]
        // selectedRedFalgs = [String]
        // enteredNumbers = String
        // enteredWebpages = String
        // enteredNotes = String
        
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

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    /// MARK: - Table view data source

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
//            cell.backgroundColor = .yellow
            cell.photosCollectionView.backgroundColor = .clear
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
//            cell.backgroundColor = .green
            return cell
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: "BusinessTypeTableViewCell", for: indexPath) as! BusinessTypeTableViewCell
//            cell.backgroundColor = .blue
            cell.businessTypeCollectionView.backgroundColor = .clear
            cell.businessTypeCollectionView.delegate = self
            cell.businessTypeCollectionView.dataSource = self
            cell.businessTypeCollectionView.tag = 1
            cell.businessTypeCollectionView.allowsMultipleSelection = true
            return cell
        case 3:
            let cell = tableView.dequeueReusableCell(withIdentifier: "RedFlagsTableViewCell", for: indexPath) as! RedFlagsTableViewCell
//            cell.backgroundColor = .cyan
            cell.addRedFlagsButton.addTarget(self, action: #selector(selectRedFlags), for: .touchUpInside)
            return cell
        case 4:
            let cell = tableView.dequeueReusableCell(withIdentifier: "NumbersTableViewCell", for: indexPath) as! NumbersTableViewCell
//            cell.backgroundColor = .red
        return cell
        case 5:
            let cell = tableView.dequeueReusableCell(withIdentifier: "WebpagesTableViewCell", for: indexPath) as! WebpagesTableViewCell
//            cell.backgroundColor = .orange
            return cell
        case 6:
            let cell = tableView.dequeueReusableCell(withIdentifier: "NotesTableViewCell", for: indexPath) as! NotesTableViewCell
//            cell.backgroundColor = .brown
            return cell
        default:
            let cell = UITableViewCell()
            return cell
        }
    }

    
    /// BUSINESS ADDRESS
    
    @objc func addLocation() {
        let locationVC = LocationViewController()
        locationVC.modalPresentationStyle = .overFullScreen
        locationVC.modalTransitionStyle = .crossDissolve
        self.present(locationVC, animated: false, completion: nil)
        
        print("open add location view")
    }
    
    
    /// RED FLAGS
    
    @objc func selectRedFlags() {
        let flagsVC = FlagsViewController()
        flagsVC.modalPresentationStyle = .overFullScreen
        flagsVC.modalTransitionStyle = .crossDissolve
        self.present(flagsVC, animated: false, completion: nil)

        print("open modal red flags view")
    }
}



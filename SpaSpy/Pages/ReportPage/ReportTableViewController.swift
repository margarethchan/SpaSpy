//
//  ReportTableViewController.swift
//  SpaSpy
//
//  Created by C4Q on 4/26/18.
//  Copyright © 2018 C4Q. All rights reserved.
//

import UIKit
import AVFoundation
import SimplePDF
import GoogleMaps
import GooglePlaces
import GooglePlacePicker
import MessageUI
import FirebaseAuth
import SnapKit

class ReportTableViewController: UITableViewController {
    
    /// PDF
    public let A4paperSize = CGSize(width: 595, height: 842)
    public let pageMargin: CGFloat = 20.0
    public var pdf: SimplePDF!
    public var fileName: String = ""
    public var pdfData: Data?
    
    /// BUSINESS PHOTOS
    public var uploadedPhotos = [UIImage]()
    public var uploadedPhotoURLs = [String]()
    public let imagePickerVC = UIImagePickerController()
    private var currentSelectedImage: UIImage!
    
    /// BUSINESS ADDRESS VALUES
    public var selectedLocation: GMSPlace?
    public var selectedLocationName = ""
    public var selectedLocationAddress = ""
    public var selectedLocationLatitude = ""
    public var selectedLocationLongitude = ""
    var placesClient: GMSPlacesClient!
    
    public var selectedBusinessTypes = [String]()
    public var allRedFlags = [String]()
    public var selectedRedFlags = [String]()
    public var enteredNumbers = ""
    public var enteredWebpages = ""
    public var enteredNotes = ""
    
    public var now = Date()
        
    // UICollectionView reference values
    let sectionInsets = UIEdgeInsets(top: 10.0, left: 10.0, bottom: 10.0, right: 10.0)
    let itemsPerRow: CGFloat = 4
    
    public var currentTimestampFull = ""
    public var currentTimestampShort = ""
    
    var mailComposeViewController: MFMailComposeViewController!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.estimatedRowHeight = 150
        self.tableView.reloadData()
        self.tableView.allowsSelection = false
        self.tableView.bounces = true
        self.tableView.separatorStyle = .none
        self.tableView.tag = 0
        self.imagePickerVC.delegate = self
        self.tableView.backgroundColor = UIColor(red:0.39, green:0.82, blue:1.00, alpha:1.0)
        placesClient = GMSPlacesClient.shared()
        
        AuthUserService.manager.signInAnon()
        loadAllFlags()
    }
    
    /// NAV BAR BUTTONS
    @IBAction func clearFormButton(_ sender: UIBarButtonItem) {
        clearForm()
    }
    
    @IBAction func reportButton(_ sender: UIBarButtonItem) {
        finalizeInputs()
        if selectedLocationName.isEmpty || selectedLocationAddress.isEmpty || selectedBusinessTypes.count == 0 || selectedRedFlags.count == 0 || uploadedPhotos.count == 0 {
            reportNotSubmittedAlert()
        } else {
            DBService.manager.saveReport(withImages: uploadedPhotos, name: selectedLocationName, address: selectedLocationAddress, latitude: selectedLocationLatitude, longitude: selectedLocationLongitude, services: selectedBusinessTypes, redFlags: selectedRedFlags, phoneNumbers: enteredNumbers, webpages: enteredWebpages, notes: enteredNotes)
            /// Uncomment next line to enable PDF generating function when submitting report
            //      collectPDFInputs()
            reportSubmittedAlert()
            clearForm()
        }
    }
    
    /// MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 7
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "PhotosTableViewCell", for: indexPath) as! PhotosTableViewCell
            cell.photosCollectionView.backgroundColor = .clear
            cell.photosCollectionView.delegate = self
            cell.photosCollectionView.dataSource = self
            cell.photosCollectionView.tag = 0
            cell.addPhotoButton.addTarget(self, action: #selector(addImageButtonPressed), for: .touchUpInside)
            cell.removePhotoButton.addTarget(self, action: #selector(removeLastPhoto), for: .touchUpInside)
            
            if uploadedPhotos.count < 1 {
                cell.removePhotoButton.isHidden = true
                cell.addPhotoWidth?.deactivate()
                cell.addPhotoLeading?.deactivate()
                cell.addPhotoCenter?.deactivate()
                cell.addPhotoButton.snp.makeConstraints { (make) in
                    cell.addPhotoWidth = make.width.equalTo(cell.contentView.snp.width).multipliedBy(0.85).constraint
                    cell.addPhotoCenter = make.centerX.equalTo(cell.contentView.snp.centerX).constraint
                }
                cell.collectionCellHeight?.deactivate()
                cell.photosCollectionView.snp.makeConstraints { (make) in
                    cell.collectionCellHeight = make.height.equalTo(0).constraint
                }
            } else {
                cell.removePhotoButton.isHidden = false
                cell.addPhotoWidth?.deactivate()
                cell.addPhotoLeading?.deactivate()
                cell.addPhotoCenter?.deactivate()
                cell.addPhotoButton.snp.makeConstraints { (make) in
                    cell.addPhotoWidth = make.width.equalTo(cell.contentView.snp.width).multipliedBy(0.4).constraint
                     cell.addPhotoCenter = make.centerX.equalTo(cell.contentView.snp.centerX).multipliedBy(0.55).constraint
                }
                cell.collectionCellHeight?.deactivate()
                cell.photosCollectionView.snp.makeConstraints { (make) in
                    cell.collectionCellHeight = make.height.equalTo(120).constraint
                }
            }
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: "AddressTableViewCell", for: indexPath) as! AddressTableViewCell
            cell.addLocationButton.addTarget(self, action: #selector(addLocation), for: .touchUpInside)
            if self.selectedLocationAddress == "" {
                cell.addLocationButton.setTitle("Add Location", for: .normal)
                
                cell.nameCellHeight?.deactivate()
                cell.businessNameLabel.snp.makeConstraints { (make) in
                    cell.nameCellHeight = make.height.equalTo(0).constraint
                }
                cell.addressCellHeight?.deactivate()
                cell.businessAddressLabel.snp.makeConstraints { (make) in
                    cell.addressCellHeight = make.height.equalTo(0).constraint
                }
            } else {
                cell.addLocationButton.setTitle("Change Location", for: .normal)
                cell.addLocationButton.backgroundColor = .clear
                cell.nameCellHeight?.deactivate()
                cell.businessNameLabel.snp.makeConstraints { (make) in
                    cell.nameCellHeight = make.height.equalTo(30).constraint
                }
                cell.addressCellHeight?.deactivate()
                cell.businessAddressLabel.snp.makeConstraints { (make) in
                    cell.addressCellHeight = make.height.equalTo(30).constraint
                }
            }
            cell.addLocationButton.addTarget(self, action: #selector(addLocation), for: .touchUpInside)
            return cell
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: "BusinessTypeTableViewCell", for: indexPath) as! BusinessTypeTableViewCell
            cell.businessTypeCollectionView.backgroundColor = .clear
            cell.businessTypeCollectionView.delegate = self
            cell.businessTypeCollectionView.dataSource = self
            cell.businessTypeCollectionView.tag = 1
            cell.businessTypeCollectionView.allowsMultipleSelection = true
            cell.otherBusinessTypeTextView.delegate = self
            cell.otherBusinessTypeTextView.tag = indexPath.row
            return cell
        case 3:
            let cell = tableView.dequeueReusableCell(withIdentifier: "RedFlagsTableViewCell", for: indexPath) as! RedFlagsTableViewCell
            cell.addRedFlagsButton.addTarget(self, action: #selector(selectRedFlags), for: .touchUpInside)
            if self.selectedRedFlags.count == 1 {
                cell.selectedFlagsLabel.text = selectedRedFlags.count.description + " Selected Flag"
            } else if self.selectedRedFlags.count > 1 {
                cell.selectedFlagsLabel.text = selectedRedFlags.count.description + " Selected Flags"
            }
            if self.selectedRedFlags.isEmpty {
                cell.addRedFlagsButton.setTitle("Set Red Flags", for: .normal)
                cell.redFlagsCellHeight?.deactivate()
                cell.selectedFlagsLabel.snp.makeConstraints { (make) in
                    cell.redFlagsCellHeight = make.height.equalTo(0).constraint
                }
            } else {
                cell.addRedFlagsButton.setTitle("Edit Red Flags", for: .normal)
                cell.addRedFlagsButton.backgroundColor = .clear
                cell.redFlagsCellHeight?.deactivate()
                cell.selectedFlagsLabel.snp.makeConstraints { (make) in
                    cell.redFlagsCellHeight = make.height.equalTo(30).constraint
                }
            }
            return cell
        case 4:
            let cell = tableView.dequeueReusableCell(withIdentifier: "NumbersTableViewCell", for: indexPath) as! NumbersTableViewCell
            cell.numbersTextView.delegate = self
            cell.numbersTextView.tag = indexPath.row
            return cell
        case 5:
            let cell = tableView.dequeueReusableCell(withIdentifier: "WebpagesTableViewCell", for: indexPath) as! WebpagesTableViewCell
            cell.webpagesTextView.delegate = self
            cell.webpagesTextView.tag = indexPath.row
            return cell
        case 6:
            let cell = tableView.dequeueReusableCell(withIdentifier: "NotesTableViewCell", for: indexPath) as! NotesTableViewCell
            cell.notesTextView.delegate = self
            cell.notesTextView.tag = indexPath.row
            return cell
        default:
            let cell = UITableViewCell()
            return cell
        }
    }


    
    public func addBusinessTypeInputs() {
        let businessTypeTVC = self.tableView.cellForRow(at: IndexPath(row: 2, section: 0)) as? BusinessTypeTableViewCell
        let businessTypeCV = businessTypeTVC?.businessTypeCollectionView
        let selectedTypesIndexPaths = businessTypeCV?.indexPathsForSelectedItems
        selectedTypesIndexPaths?.forEach({ (indexpath) in
            let businessTypeCell = businessTypeCV?.cellForItem(at: indexpath) as! BusinessTypeCollectionViewCell
            self.selectedBusinessTypes.append(businessTypeCell.businessTypeLabel.text!)
        })
        if businessTypeTVC?.otherBusinessTypeTextView.text != "Other Type of Service" {
            self.selectedBusinessTypes.append((businessTypeTVC?.otherBusinessTypeTextView.text)!)
        }
    }
    private func loadAllFlags() {
        for desc in redFlags {
            allRedFlags.append(desc)
        }
    }
    @objc func selectRedFlags() {
        let flagsVC = FlagsViewController()
        flagsVC.modalPresentationStyle = .overFullScreen
        flagsVC.modalTransitionStyle = .crossDissolve
        self.present(flagsVC, animated: false, completion: nil)
        flagsVC.delegate = self
        flagsVC.selectedFlags = self.selectedRedFlags
        flagsVC.allFlags = self.allRedFlags
        print("open modal red flags view")
    }

    private func finalizeInputs() {
        self.view.endEditing(true)
        currentTimestampFull = DateFormatter.dateFormatterFull.string(from: now)
        currentTimestampShort = DateFormatter.dateFormatterShort.string(from: now)
        addBusinessTypeInputs()
    }
    
    private func reportSubmittedAlert() {
        print("\n\tREPORT CREATED:  Photos: \(uploadedPhotos.count), Name: \(selectedLocationName), Address: \(selectedLocationAddress), Business Types: \(selectedBusinessTypes), Red Flags: \(selectedRedFlags.count), Phone Numbers: \(enteredNumbers), Webpages: \(enteredWebpages), Notes: \(enteredNotes)\n")
        let reportCreatedAlert = Alert.create(withTitle: "Report Submitted", andMessage: "Thank you for your report", withPreferredStyle: .alert)
        Alert.addAction(withTitle: "OK", style: .default, andHandler: nil, to: reportCreatedAlert)
        self.present(reportCreatedAlert, animated: true, completion: nil)
    }
    
    
    private func reportNotSubmittedAlert() {
        let reportFailAlert = Alert.create(withTitle: "Report Failed to Submit", andMessage: "Please complete report before sending", withPreferredStyle: .alert)
        Alert.addAction(withTitle: "OK", style: .default, andHandler: nil, to: reportFailAlert)
        self.present(reportFailAlert, animated: true, completion: nil)
    }
    
    private func clearForm() {
        self.uploadedPhotos = []
        self.uploadedPhotoURLs = []
        self.currentSelectedImage = nil
        self.selectedLocationName = ""
        self.selectedLocationAddress = ""
        self.selectedBusinessTypes = [String]()
        self.selectedRedFlags = [String]()
        self.enteredNumbers = ""
        self.enteredWebpages = ""
        self.enteredNotes = ""
        
        let photoTVC = self.tableView.cellForRow(at: IndexPath(row: 0, section: 0)) as? PhotosTableViewCell
        photoTVC?.photosCollectionView.reloadData()
        
        let addressTVC = self.tableView.cellForRow(at: IndexPath(row: 1, section: 0)) as? AddressTableViewCell
        addressTVC?.businessNameLabel.text = "No location selected"
        addressTVC?.businessAddressLabel.text = "No address for location"
        
        let businessTypeTVC = self.tableView.cellForRow(at: IndexPath(row: 2, section: 0)) as? BusinessTypeTableViewCell
        businessTypeTVC?.businessTypeCollectionView.reloadData()
        businessTypeTVC?.otherBusinessTypeTextView.textColor = .lightGray
        businessTypeTVC?.otherBusinessTypeTextView.text = "Other Type of Service"
        
        let flagsTVC = self.tableView.cellForRow(at: IndexPath(row: 3, section: 0)) as? RedFlagsTableViewCell
        flagsTVC?.selectedFlagsLabel.text = selectedRedFlags.count.description + " Selected Flags"
        
        let numbersTVC = self.tableView.cellForRow(at: IndexPath(row: 4, section: 0)) as? NumbersTableViewCell
        numbersTVC?.numbersTextView.textColor = .lightGray
        numbersTVC?.numbersTextView.text = "Listed Phone Numbers"
        
        let webpagesTVC = self.tableView.cellForRow(at: IndexPath(row: 5, section: 0)) as? WebpagesTableViewCell
        webpagesTVC?.webpagesTextView.textColor = .lightGray
        webpagesTVC?.webpagesTextView.text = "Listed Web Pages"
        
        let notesTVC = self.tableView.cellForRow(at: IndexPath(row: 6, section: 0)) as? NotesTableViewCell
        notesTVC?.notesTextView.textColor = .lightGray
        notesTVC?.notesTextView.text = "Other Notes"
        
        self.tableView.reloadData()
        
        let formClearedAlert = Alert.create(withTitle: "Report Form Cleared", andMessage: "Report not submitted", withPreferredStyle: .alert)
        Alert.addAction(withTitle: "OK", style: .default, andHandler: nil, to: formClearedAlert)
        self.present(formClearedAlert, animated: true, completion: nil)
        print("form cleared")
    }

}

extension ReportTableViewController: SetSelectedFlagsDelegate {
    
    func clearAll(flags: [String]) {
        self.selectedRedFlags = flags
        self.tableView.reloadData()
    }
    
    func setSelected(flags: [String]) {
        self.selectedRedFlags = flags
        self.tableView.reloadData()
    }
    
}


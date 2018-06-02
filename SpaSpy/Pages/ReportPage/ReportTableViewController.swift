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

class ReportTableViewController: UITableViewController {
    /// CREATE PDF FROM REPORT
    private let A4paperSize = CGSize(width: 595, height: 842)
    private let pageMargin: CGFloat = 20.0
    private var pdf: SimplePDF! = nil
    
    
    /// BUSINESS PHOTOS
    public var uploadedPhotos = [UIImage]() {
        didSet {
            print("uploadedPhotos: \(uploadedPhotos)")
        }
    }
    public let imagePickerVC = UIImagePickerController()
    private var currentSelectedImage: UIImage!
    
    /// BUSINESS ADDRESS VALUES
    private var selectedLocationName = "" {
        didSet {
            print("selectedLocationName: \(selectedLocationName)")
        }
    }
    private var selectedLocationAddress = "" {
        didSet {
            print("selectedLocationAddress: \(selectedLocationAddress)")
        }
    }
    var placesClient: GMSPlacesClient!
    

    public var selectedBusinessTypes = [String]() {
        didSet {
            print("Selected Business Types: \(selectedBusinessTypes)")
        }
    }
    private var selectedRedFlags = [String]() {
        didSet {
            print("Selected Red Flags: \(selectedRedFlags)")
        }
    }
    public var enteredNumbers = "" {
        didSet {
            print("Phone Numbers: \(enteredNumbers)")
        }
    }
    public var enteredWebpages = "" {
        didSet {
            print("Webpages: \(enteredWebpages)")
        }
    }
    public var enteredNotes = "" {
        didSet {
            print("Notes: \(enteredNotes)")
        }
    }
    
    private var now = Date()
    
  
        
    // UICollectionView reference values
    let sectionInsets = UIEdgeInsets(top: 10.0, left: 10.0, bottom: 10.0, right: 10.0)
    let itemsPerRow: CGFloat = 4
    
    
    private func clearForm() {
        self.uploadedPhotos = [UIImage]()
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
        businessTypeTVC?.otherBusinessTypeTextView.text = "Other Type of Business"
        
        let flagsTVC = self.tableView.cellForRow(at: IndexPath(row: 3, section: 0)) as? RedFlagsTableViewCell
        flagsTVC?.redFlagsLabel.text = selectedRedFlags.count.description + " Selected Flags"
        
        let numbersTVC = self.tableView.cellForRow(at: IndexPath(row: 4, section: 0)) as? NumbersTableViewCell
        numbersTVC?.numbersTextView.text = "Listed Phone Numbers"
        
        let webpagesTVC = self.tableView.cellForRow(at: IndexPath(row: 5, section: 0)) as? WebpagesTableViewCell
        webpagesTVC?.webpagesTextView.text = "Listed Web Pages"
        
        let notesTVC = self.tableView.cellForRow(at: IndexPath(row: 6, section: 0)) as? NotesTableViewCell
        notesTVC?.notesTextView.text = "Other Notes"
        
        self.tableView.reloadData()
        print("form cleared")
    }
    
    /// NAV BAR BUTTONS
    @IBAction func clearFormButton(_ sender: UIBarButtonItem) {
        clearForm()
    }
    
    @IBAction func reportButton(_ sender: UIBarButtonItem) {
        print("submit report")
        /// COLLECT DATA FOR PDF REPORT
        pdf.setContentAlignment(.center)
        
        let logoImage = #imageLiteral(resourceName: "icon_83.5")
        pdf.addImage(logoImage)
        pdf.addText("Spa Spy Report", font: UIFont.boldSystemFont(ofSize: 20), textColor: .blue)
        pdf.addLineSpace(10.0)
        
        let currentTimestamp = DateFormatter.dateFormatter.string(from: now)
        
        pdf.addText("Reported on: " + currentTimestamp, font: UIFont.systemFont(ofSize: 10), textColor: .black)
        pdf.addLineSpace(30)
        
        pdf.setContentAlignment(.left)

        pdf.addText("Business Location", font: UIFont.boldSystemFont(ofSize: 15), textColor: .blue)
        pdf.addLineSeparator(height: 0.5)
        pdf.addText(self.selectedLocationName)
        pdf.addLineSpace(20.0)
        
        pdf.addText("Business Types", font: UIFont.boldSystemFont(ofSize: 15), textColor: .blue)
        pdf.addLineSeparator(height: 0.5)
        
        
        
        let businessTypeIndexPath = IndexPath(row: 2, section: 0)
        let businessTypeTVCell = self.tableView.cellForRow(at: businessTypeIndexPath) as! BusinessTypeTableViewCell
        let businessTypeCV = businessTypeTVCell.businessTypeCollectionView
        let selectedTypesIndexPaths = businessTypeCV.indexPathsForSelectedItems
        selectedTypesIndexPaths?.forEach({ (indexpath) in
            let businessTypeCell = businessTypeCV.cellForItem(at: indexpath) as! BusinessTypeCollectionViewCell
            self.selectedBusinessTypes.append(businessTypeCell.businessTypeLabel.text!)
        })
        if businessTypeTVCell.otherBusinessTypeTextView.text != "Other Type of Business" {
            self.selectedBusinessTypes.append(businessTypeTVCell.otherBusinessTypeTextView.text)
        }
        if !self.selectedBusinessTypes.isEmpty {
            self.selectedBusinessTypes.forEach { (type) in
                pdf.addText(type)
            }
        } else {
            pdf.addText("No Business Type Selected")
            
        }
        pdf.addLineSpace(20.0)
        
        pdf.addText("Red Flags", font: UIFont.boldSystemFont(ofSize: 15), textColor: .blue)
        pdf.addLineSeparator(height: 0.5)
        self.selectedRedFlags.forEach { (flag) in
            pdf.addText(flag)
        }
        pdf.addLineSpace(20.0)
        
        pdf.addText("Business Phone Numbers", font: UIFont.boldSystemFont(ofSize: 15), textColor: .blue)
        pdf.addLineSeparator(height: 0.5)
        pdf.addText(enteredNumbers)
        pdf.addLineSpace(20.0)
        
        pdf.addText("Business Webpages", font: UIFont.boldSystemFont(ofSize: 15), textColor: .blue)
        pdf.addLineSeparator(height: 0.5)
        pdf.addText(enteredWebpages)
        pdf.addLineSpace(20.0)
        
        let notesTVC = self.tableView.cellForRow(at: IndexPath(row: 6, section: 0)) as? NotesTableViewCell
        notesTVC?.notesTextView.resignFirstResponder()
        pdf.addText("Other Notes", font: UIFont.boldSystemFont(ofSize: 15), textColor: .blue)
        pdf.addLineSeparator(height: 0.5)
        pdf.addText(enteredNotes)
        pdf.addLineSpace(20.0)
        
        pdf.addText("Photos of the Business", font: UIFont.boldSystemFont(ofSize: 15), textColor: .blue)
        pdf.addLineSeparator(height: 0.5)
        self.uploadedPhotos.forEach { (image) in
            pdf.addImage(image)
            pdf.beginNewPage()
        }
        
        // Generate PDF data and save to a local file.
        if let documentDirectories = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first {
            
            let fileName = "example.pdf"
            let documentsFileName = documentDirectories + "/" + fileName
            
            let pdfData = pdf.generatePDFdata()
            do {
                try pdfData.write(to: URL(fileURLWithPath: documentsFileName), options: .atomicWrite)
                print("\nThe generated pdf can be found at:")
                print("\n\t\(documentsFileName)\n")
            } catch {
                print(error)
            }
        }
        
        print("REPORT CREATED: Photos: \(uploadedPhotos.count), Name: \(selectedLocationName), Address: \(selectedLocationAddress), Business Types: \(selectedBusinessTypes), Red Flags: \(selectedRedFlags.count), Phone Numbers: \(enteredNumbers), Webpages: \(enteredWebpages), Notes: \(enteredNotes)")
        
        clearForm()
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
        self.pdf = SimplePDF(pageSize: A4paperSize, pageMarginLeft: pageMargin, pageMarginTop: pageMargin, pageMarginBottom: pageMargin, pageMarginRight: pageMargin)
        
        placesClient = GMSPlacesClient.shared()
    }
    

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    /// MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

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
            cell.addPhotoButton.addTarget(self, action: #selector(changeImageButtonTapped), for: .touchUpInside)
            cell.removePhotoButton.addTarget(self, action: #selector(removeLastPhoto), for: .touchUpInside)
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: "AddressTableViewCell", for: indexPath) as! AddressTableViewCell
            cell.addLocationButton.addTarget(self, action: #selector(addLocation), for: .touchUpInside)
            cell.mapIconButton.addTarget(self, action: #selector(addLocation), for: .touchUpInside)
            if self.selectedLocationName == "" {
                cell.addLocationButton.setTitle("Add Location", for: .normal)
            } else {
                cell.addLocationButton.setTitle("Change Location", for: .normal)
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
            cell.selectedFlagsLabel.text = selectedRedFlags.count.description + " Selected Flags"
            if self.selectedRedFlags.isEmpty {
                cell.addRedFlagsButton.setTitle("Set Red Flags", for: .normal)
            } else {
                cell.addRedFlagsButton.setTitle("Edit Red Flags", for: .normal)
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


    
    /// BUSINESS ADDRESS
    
    @objc func addLocation() {
        let businessAddressCellIndexPath = IndexPath(row: 1, section: 0)
        let businessAddressCell = self.tableView.cellForRow(at: businessAddressCellIndexPath) as! AddressTableViewCell
        
        /// initial start location?
        let center = CLLocationCoordinate2D(latitude: 37.788204, longitude: -122.411937)
        let northEast = CLLocationCoordinate2D(latitude: center.latitude + 0.001, longitude: center.longitude + 0.001)
        let southWest = CLLocationCoordinate2D(latitude: center.latitude - 0.001, longitude: center.longitude - 0.001)
        let viewport = GMSCoordinateBounds(coordinate: northEast, coordinate: southWest)
        let config = GMSPlacePickerConfig(viewport: viewport)
        let placePicker = GMSPlacePicker(config: config)
        
        placePicker.pickPlace(callback: {(place, error) -> Void in
            if let error = error {
                print("Pick Place error: \(error.localizedDescription)")
                return
            }
            
            if let place = place {
                businessAddressCell.businessNameLabel.text = place.name
                businessAddressCell.businessAddressLabel.text = (place.formattedAddress != nil) ? place.formattedAddress! : "Lat: \(place.coordinate.latitude) + Long: \(place.coordinate.longitude)"
                // set address variables on form
                self.selectedLocationName = place.name
                self.selectedLocationAddress = (place.formattedAddress != nil) ? place.formattedAddress! : "Lat: \(place.coordinate.latitude), Long: \(place.coordinate.longitude)"
                self.tableView.reloadData()
            } else {
                businessAddressCell.businessNameLabel.text = "No location selected"
                businessAddressCell.businessAddressLabel.text = ""
            }
        })
    }
    
    
    /// RED FLAGS
    @objc func selectRedFlags() {
        let flagsVC = FlagsViewController()
        flagsVC.modalPresentationStyle = .overFullScreen
        flagsVC.modalTransitionStyle = .crossDissolve
        self.present(flagsVC, animated: false, completion: nil)
        flagsVC.delegate = self
        flagsVC.selectedFlags = self.selectedRedFlags
        print("open modal red flags view")
    }
}


extension ReportTableViewController: SetSelectedFlagsDelegate {
    func setSelected(flags: [String]) {
        self.selectedRedFlags = flags
        self.tableView.reloadData()
    }
}


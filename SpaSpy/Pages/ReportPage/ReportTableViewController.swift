//
//  ReportTableViewController.swift
//  SpaSpy
//
//  Created by C4Q on 4/26/18.
//  Copyright © 2018 C4Q. All rights reserved.
//

import UIKit

class ReportTableViewController: UITableViewController {

    var uploadedPhotos = [Photo]()
    var selectedBusinessTypes = [String]()
    var selectedLocation = "selectedLocation"
    var selectedRedFlags = [String]()
    var enteredNumbers = ""
    var enteredWebpages = ""
    var enteredNotes = ""
    
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
        self.tableView.estimatedRowHeight = 100
        self.tableView.reloadData()
        self.tableView.allowsSelection = false
        self.tableView.bounces = false
        self.tableView.separatorStyle = .none

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
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: "AddressTableViewCell", for: indexPath) as! AddressTableViewCell
            cell.addLocationButton.addTarget(self, action: #selector(addLocation), for: .touchUpInside)
            cell.mapIconButton.addTarget(self, action: #selector(addLocation), for: .touchUpInside)
            cell.addLocationButton.setTitle("Add Location", for: .normal)
//            cell.addLocationButton.setTitle(selectedLocation, for: .selected)
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
    
    @objc func addLocation() {
        print("add location")
    }
    
    @objc func selectRedFlags() {
        let flagsVC = FlagsTableViewController()
        let detailedNavigationController = UINavigationController(rootViewController: flagsVC)
        detailedNavigationController.modalTransitionStyle = .crossDissolve
        self.navigationController?.pushViewController(flagsVC, animated: true)

        print("open red flags view")    
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




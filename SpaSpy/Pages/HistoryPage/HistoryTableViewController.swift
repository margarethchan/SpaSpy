//
//  HistoryTableViewController.swift
//  SpaSpy
//
//  Created by C4Q on 5/30/18.
//  Copyright © 2018 C4Q. All rights reserved.
//

import UIKit
import Foundation
import FirebaseDatabase

class HistoryTableViewController: UITableViewController {

    var reports = [Report]() {
        didSet {
            self.tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.delegate = self
        self.tableView.dataSource = self
        getReports()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        getReports()
    }
    
    private func getReports() {
        let currentUser = AuthUserService.manager.getCurrentUser()
        DBService.manager.getReports(fromUID: (currentUser?.uid)!) { (userReports) in
            self.reports = userReports
        }
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return reports.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ReportCell", for: indexPath) as! HistoryTableViewCell

        let report = reports[indexPath.row]
        cell.businessName.text = report.name
        cell.businessAddress.text = report.address
        cell.businessTypes.text = report.services.joined(separator: ", ")
        cell.businessImage.image = nil
        
        if let reportImageURLstrs = report.imageURLs {
            let completion: (UIImage) -> Void = {(onlineImage: UIImage) in
                cell.businessImage.image = onlineImage
                cell.setNeedsLayout()
            }
            ImageAPIClient.manager.loadImage(from: reportImageURLstrs[0], completionHandler: completion, errorHandler: {print($0)})
        } else {
            cell.businessImage.image = UIImage(named: "noImage")
        }
        return cell
    }

    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 180.0
    }

    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? HistoryReportDetailViewController {
            let report = reports[(tableView.indexPathForSelectedRow?.row)!]
            destination.report = report
        }
    }


}

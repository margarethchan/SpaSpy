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

    var reports = [Report]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.delegate = self
        self.tableView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let currentUser = AuthUserService.manager.getCurrentUser()
        DBService.manager.getReports(fromUID: (currentUser?.uid)!) { (userReports) in
            self.reports = userReports
        }
    }
    override func viewDidAppear(_ animated: Bool) {
        self.tableView.reloadData()
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
        return 200.0
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

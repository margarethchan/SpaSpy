//
//  HistoryReportDetailViewController.swift
//  SpaSpy
//
//  Created by C4Q on 7/5/18.
//  Copyright © 2018 C4Q. All rights reserved.
//

import UIKit

class HistoryReportDetailViewController: UIViewController {

    var report: Report?
    
    @IBOutlet weak var reportImagesCollectionView: UICollectionView!
    @IBOutlet weak var submittedLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var servicesLabel: UILabel!
    @IBOutlet weak var redFlagsLabel: UILabel!
    @IBOutlet weak var notesLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = report?.name
        
        self.submittedLabel.text = (report?.timestamp ?? "N/A")
        self.nameLabel.text = (report?.name ?? "N/A")
        self.addressLabel.text = (report?.address ?? "N/A")
        self.servicesLabel.text = (report?.services.joined(separator: ", ") ?? "N/A")
        self.redFlagsLabel.text = (report?.redFlags.joined(separator: ", \n") ?? "N/A")
        self.notesLabel.text = (report?.notes ?? "N/A")
        
    }
}
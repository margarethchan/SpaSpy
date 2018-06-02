//
//  FlagsViewController.swift
//  SpaSpy
//
//  Created by C4Q on 5/8/18.
//  Copyright © 2018 C4Q. All rights reserved.
//

import UIKit

protocol SetSelectedFlagsDelegate: class {
    func setSelected(flags: [String])
}

class FlagsViewController: UIViewController {

    weak var delegate: SetSelectedFlagsDelegate?
    
    private let flagsView = FlagsView()
    private let redFlagList = redFlags
    public var selectedFlags = [String]() {
        didSet {
            print("selectedFlags: \(selectedFlags)")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .clear
        view.addSubview(flagsView)
        
        flagsView.redFlagsTableView.dataSource = self
        flagsView.redFlagsTableView.delegate = self
        flagsView.redFlagsTableView.register(FlagTableViewCell.self, forCellReuseIdentifier: "FlagCell")
        
        flagsView.cancelButton.addTarget(self, action: #selector(cancel), for: .touchUpInside)
        flagsView.doneButton.addTarget(self, action: #selector(done), for: .touchUpInside)
        
        // Do any additional setup after loading the view.
    }
    
    @objc func cancel() {
        print("cancel")
        self.dismiss(animated: true, completion: nil)
    }
    
    
    @objc func done() {
        print("done")
        // export the selected flags
//        delegate?.saveFlags(fromList: selectedFlags)
        let selectedFlagsIndexPaths = self.flagsView.redFlagsTableView.indexPathsForSelectedRows
        selectedFlagsIndexPaths?.forEach({ (indexpath) in
            let flagCell = self.flagsView.redFlagsTableView.cellForRow(at: indexpath) as! FlagTableViewCell
            self.selectedFlags.append(flagCell.flagLabel.text!)
        })
        delegate?.setSelected(flags: self.selectedFlags)
        self.dismiss(animated: true, completion: nil)
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}


extension FlagsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return redFlagList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FlagCell", for: indexPath) as! FlagTableViewCell
        let flagDescription = redFlags[indexPath.row]
        cell.configureCell(withFlagDescription: flagDescription, selected: cell.isSelected)
//        cell.flagLabel.text = flagDescription
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40.0
    }
    
}




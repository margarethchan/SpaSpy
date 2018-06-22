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
    func clearAll(flags: [String])
}

class FlagsViewController: UIViewController {
    
    weak var delegate: SetSelectedFlagsDelegate?
    
    private let flagsView = FlagsView()
    public var allFlags = [String]() {
        didSet {
            print("allFlags: \(allFlags.count)")
        }
    }
    public var selectedFlags = [String]() {
        didSet {
            print("selectedFlags: \(selectedFlags.count)")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .clear
        view.addSubview(flagsView)
        
        flagsView.redFlagsTableView.dataSource = self
        flagsView.redFlagsTableView.delegate = self
        flagsView.redFlagsTableView.register(FlagTableViewCell.self, forCellReuseIdentifier: "FlagCell")
        flagsView.redFlagsTableView.tag = 1
        
        flagsView.clearButton.addTarget(self, action: #selector(clear), for: .touchUpInside)
        flagsView.doneButton.addTarget(self, action: #selector(done), for: .touchUpInside)
    }
    
    @objc func clear() {
        print("clear")
        self.selectedFlags = []
        delegate?.clearAll(flags: self.selectedFlags)
        self.flagsView.redFlagsTableView.reloadData()
    }
    
    @objc func done() {
        print("done")
        let selectedFlagsIndexPaths = self.flagsView.redFlagsTableView.indexPathsForSelectedRows
        selectedFlagsIndexPaths?.forEach({ (indexpath) in
//            let flagCell = self.flagsView.redFlagsTableView.cellForRow(at: indexpath) as! FlagTableViewCell
            let flag = allFlags[indexpath.row]
            self.selectedFlags.append(flag.description)
        })
        delegate?.setSelected(flags: self.selectedFlags)
        self.dismiss(animated: true, completion: nil)
    }
}

extension FlagsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allFlags.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FlagCell", for: indexPath) as! FlagTableViewCell
        let flag = allFlags[indexPath.row]
        cell.flagLabel.text = flag.description
//        if self.selectedFlags.contains(flag) { // how to make Flag and [Flag] ]equatable?
//        if cell.isSelected {
//            cell.backgroundColor = .red
//            cell.accessoryType = .checkmark
//        } else {
//            cell.accessoryType = .none
        
//        if self.selectedFlags.contains(flagDescription) {
//        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FlagCell", for: indexPath) as! FlagTableViewCell
        var flag = allFlags[indexPath.row]
        cell.flagLabel.text = flag.description
//        flag.isSelected = true
        
        //done()
//        tableView.reloadData()

    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40.0
    }
}




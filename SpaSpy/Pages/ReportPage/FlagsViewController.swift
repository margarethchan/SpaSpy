//
//  FlagsViewController.swift
//  SpaSpy
//
//  Created by C4Q on 5/8/18.
//  Copyright © 2018 C4Q. All rights reserved.
//

import UIKit

class FlagsViewController: UIViewController {

    let flagsView = FlagsView()
    
    let redFlagList = redFlags
    
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
        self.dismiss(animated: true, completion: nil)
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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


extension FlagsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return redFlagList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FlagCell", for: indexPath) as! FlagTableViewCell
        let flag = redFlags[indexPath.row]
        cell.flagLabel.text = flag
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40.0
    }
    
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        <#code#>
//    }
    
}

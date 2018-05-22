//
//  LocationViewController.swift
//  SpaSpy
//
//  Created by C4Q on 5/10/18.
//  Copyright © 2018 C4Q. All rights reserved.
//

import UIKit

class LocationViewController: UIViewController {

    let locationView = LocationView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .clear
        view.addSubview(locationView)
        locationView.dismissButton.addTarget(self, action: #selector(dismissView), for: .touchUpInside)
        locationView.dismissView.addTarget(self, action: #selector(dismissView), for: .touchUpInside)
        // Do any additional setup after loading the view.
    }

    @objc private func dismissView() {
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

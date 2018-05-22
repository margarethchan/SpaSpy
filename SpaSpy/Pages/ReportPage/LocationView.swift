//
//  LocationView.swift
//  SpaSpy
//
//  Created by C4Q on 5/10/18.
//  Copyright © 2018 C4Q. All rights reserved.
//

import UIKit
import SnapKit

class LocationView: UIView {

    lazy var dismissView: UIButton = {
        let button = UIButton(frame: UIScreen.main.bounds)
        button.backgroundColor = .clear
        return button
    }()
    
    lazy var containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .red
        view.layer.cornerRadius = 20
        view.layer.masksToBounds = true
        return view
    }()
    
    lazy var dismissButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named:"dismissButtonIcon"), for: .normal)
        button.backgroundColor = .orange
//        button.layer.mask = self.containerView.layer
//        button.layer.masksToBounds = true
        return button
    }()
    
    lazy var titleLabel: UILabel = {
        let lb = UILabel()
        lb.text = "Add Location"
        lb.font = UIFont.systemFont(ofSize: 17, weight: .bold)
        lb.textAlignment = .center
        lb.backgroundColor = .blue
        return lb
    }()
    
    lazy var searchBar: UISearchBar = {
       let searchBar = UISearchBar()
        searchBar.barStyle = .default
        searchBar.backgroundColor = .cyan
        searchBar.showsCancelButton = true
        return searchBar
    }()
    
    lazy var mapView: UIView = {
        let view = UIView()
        view.backgroundColor = .green
        return view
    }()
    
    lazy var selectLocationButton: UIButton = {
        let button = UIButton()
        button.setTitle("Select Location", for: .normal)
        button.setTitleColor(UIColor.black, for: .normal)
        button.backgroundColor = .blue
//        button.layer.mask = self.containerView.layer
//        button.layer.masksToBounds = true
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: UIScreen.main.bounds)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit() {
        backgroundColor = .white
        setupViews()
        setupConstraints()
    }
    
    
    private func setupViews() {
        setupBlurEffectView()
        addSubview(dismissView)
        addSubview(containerView)
        addSubview(dismissButton)
        addSubview(titleLabel)
        addSubview(searchBar)
        addSubview(selectLocationButton)
        addSubview(mapView)

    }
    

    
    private func setupBlurEffectView() {
        let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.dark) // .light, .dark, .prominent, .regular, .extraLight
        let visualEffect = UIVisualEffectView(frame: UIScreen.main.bounds)
        visualEffect.effect = blurEffect
        addSubview(visualEffect)
    }
    
    private func setupConstraints() {
        containerView.snp.makeConstraints { (make) in
            make.centerX.equalTo(self.snp.centerX)
            make.centerY.equalTo(self.snp.centerY)
            make.width.equalTo(self.snp.width).multipliedBy(0.9)
            make.height.equalTo(self.snp.height).multipliedBy(0.95)
        }
        
        dismissButton.snp.makeConstraints { (make) in
            make.top.equalTo(containerView.snp.top).offset(10)
            make.leading.equalTo(containerView.snp.leading).offset(10)
            make.height.width.equalTo(30)
//            make.edges.equalTo(self.containerView)
        }
        
        titleLabel.snp.makeConstraints { (make) in
            make.centerX.equalTo(containerView.snp.centerX)
            make.top.equalTo(containerView.snp.top)
            make.width.equalTo(containerView).multipliedBy(0.75)
            make.height.equalTo(50)
        }
        
        searchBar.snp.makeConstraints { (make) in
            make.centerX.equalTo(containerView.snp.centerX)
            make.top.equalTo(titleLabel.snp.bottom)
            make.width.equalTo(containerView)
            make.height.equalTo(50)
        }
        
        selectLocationButton.snp.makeConstraints { (make) in
            make.centerX.equalTo(containerView.snp.centerX)
            make.bottom.equalTo(containerView.snp.bottom)
            make.width.equalTo(containerView)
            make.height.equalTo(50)
//            make.edges.equalTo(self.containerView)
        }

        mapView.snp.makeConstraints { (make) in
            make.width.equalTo(containerView)
            make.top.equalTo(searchBar.snp.bottom)
            make.bottom.equalTo(selectLocationButton.snp.top)
            make.centerX.equalTo(containerView.snp.centerX)
        }
        
    }

}

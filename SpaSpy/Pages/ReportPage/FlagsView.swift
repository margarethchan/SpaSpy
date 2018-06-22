//
//  FlagsView.swift
//  SpaSpy
//
//  Created by C4Q on 4/26/18.
//  Copyright © 2018 C4Q. All rights reserved.
//

import UIKit
import SnapKit

class FlagsView: UIView {

    lazy var dismissView: UIButton = {
        let button = UIButton(frame: UIScreen.main.bounds)
        button.backgroundColor = .clear
        return button
    }()
    
    lazy var containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 15
        view.layer.masksToBounds = true
        return view
    }()
    
    lazy var clearButton: UIButton = {
        let button = UIButton()
        button.setTitle("Clear", for: .normal)
        button.setTitleColor(UIColor.black, for: .normal)
        return button
    }()
    
    lazy var flagsLabel: UILabel = {
        let lb = UILabel()
       lb.text = "Select Red Flags"
        lb.font = UIFont.systemFont(ofSize: 17, weight: .bold)
        return lb
    }()
    

    lazy var doneButton: UIButton = {
        let button = UIButton()
        button.setTitle("Done", for: .normal)
        button.setTitleColor(UIColor(red:0.39, green:0.82, blue:1.00, alpha:1.0), for: .normal)
        return button
    }()

    
    lazy var redFlagsTableView: UITableView = {
       let tbv = UITableView()
        tbv.separatorStyle = .singleLine
        tbv.allowsMultipleSelection = true
        tbv.showsVerticalScrollIndicator = false
        return tbv
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
        backgroundColor = .clear
        setupViews()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    private func setupViews() {
        setupBlurEffectView()
        addSubview(dismissView)
        setupConstraints()
    }
    
    private func setupBlurEffectView() {
        let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.dark)
        let visualEffect = UIVisualEffectView(frame: UIScreen.main.bounds)
        visualEffect.effect = blurEffect
        addSubview(visualEffect)
    }
    
    private func setupConstraints() {
        addSubview(containerView)
        containerView.snp.makeConstraints { (make) in
            make.centerX.equalTo(self.snp.centerX)
            make.centerY.equalTo(self.snp.centerY)
            make.width.equalTo(self.snp.width).multipliedBy(0.9)
            make.height.equalTo(self.snp.height).multipliedBy(0.95)
        }
        
        containerView.addSubview(clearButton)
        clearButton.snp.makeConstraints { (make) in
            make.top.equalTo(containerView.snp.top).offset(10)
            make.leading.equalTo(containerView.snp.leading).offset(10)
        }
        
        containerView.addSubview(flagsLabel)
        flagsLabel.snp.makeConstraints { (make) in
            make.centerX.equalTo(containerView.snp.centerX)
            make.centerY.equalTo(clearButton.snp.centerY)
        }
        
       containerView.addSubview(doneButton)
        doneButton.snp.makeConstraints { (make) in
            make.top.equalTo(containerView.snp.top).offset(10)
            make.trailing.equalTo(containerView.snp.trailing).offset(-10)
        }
        
        containerView.addSubview(redFlagsTableView)
        redFlagsTableView.snp.makeConstraints { (make) in
            make.top.equalTo(doneButton.snp.bottom).offset(10)
            make.leading.equalTo(containerView).offset(10)
            make.trailing.equalTo(containerView).offset(-10)
            make.bottom.equalTo(containerView.snp.bottom)
        }
    }
}

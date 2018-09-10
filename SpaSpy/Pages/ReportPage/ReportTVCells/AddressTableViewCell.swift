//
//  AddressTableViewCell.swift
//  SpaSpy
//
//  Created by C4Q on 4/27/18.
//  Copyright © 2018 C4Q. All rights reserved.
//

import UIKit
import SnapKit

class AddressTableViewCell: UITableViewCell {
    
    public var addressCellHeight: Constraint? = nil
    public var nameCellHeight: Constraint? = nil
    
    lazy var icon: UIImageView = {
        let image = UIImageView()
        image.image = #imageLiteral(resourceName: "pinwhite1")
        image.contentMode = .scaleAspectFill
        return image
    }()
    
    lazy var businessAddressHeaderLabel: UILabel = {
        let label = UILabel()
        label.text = "Business Address"
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textColor = StyleSheet.headerColor
        return label
    }()
    
    lazy var businessNameLabel: UILabel = {
        let label = UILabel()
        label.text = "No location selected"
        label.font = UIFont.systemFont(ofSize: 17)
        return label
    }()
    
    lazy var businessAddressLabel: UILabel = {
        let label = UILabel()
        label.text = "No address for location"
        label.font = UIFont.italicSystemFont(ofSize: 17)
        return label
    }()
    
    lazy var addLocationButton: UIButton = {
        let button = UIButton()
        button.setTitle("Add Location", for: .normal)
//        button.backgroundColor = UIColor(red:0.39, green:0.82, blue:1.00, alpha:1.0)
        button.backgroundColor = .white
        button.layer.borderWidth = 1
        button.setTitleColor(UIColor.black, for: .normal)
        return button
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit() {
        backgroundColor = .clear
        setUpConstraints()
    }
    
    private func setUpConstraints() {
        
        contentView.addSubview(icon)
        icon.snp.makeConstraints { (make) in
            make.top.leading.equalTo(contentView).offset(10)
            make.height.width.equalTo(StyleSheet.length)
        }
        
        contentView.addSubview(businessAddressHeaderLabel)
        businessAddressHeaderLabel.snp.makeConstraints { (make) in
            make.centerY.equalTo(icon.snp.centerY)
            make.leading.equalTo(icon.snp.trailing).offset(StyleSheet.headerIconOffset)
            make.width.equalTo(contentView.snp.width).multipliedBy(0.85).constraint
            make.height.equalTo(30)
        }
        
        contentView.addSubview(addLocationButton)
        addLocationButton.snp.makeConstraints { (make) in
            make.top.equalTo(businessAddressHeaderLabel.snp.bottom).offset(10)
            make.centerX.equalTo(contentView.snp.centerX)
            make.width.equalTo(contentView.snp.width).multipliedBy(0.85)
            make.height.equalTo(StyleSheet.buttonHeight)
        }
        
        contentView.addSubview(businessNameLabel)
        businessNameLabel.snp.makeConstraints { (make) in
            make.top.equalTo(addLocationButton.snp.bottom).offset(5)
            make.centerX.equalTo(contentView.snp.centerX)
            make.width.equalTo(contentView.snp.width).multipliedBy(0.85)
            self.nameCellHeight = make.height.equalTo(30).constraint
        }
        
        contentView.addSubview(businessAddressLabel)
        businessAddressLabel.snp.makeConstraints { (make) in
            make.top.equalTo(businessNameLabel.snp.bottom)
            make.centerX.equalTo(contentView.snp.centerX)
            make.width.equalTo(contentView.snp.width).multipliedBy(0.85)
            self.addressCellHeight = make.height.equalTo(30).constraint
            make.bottom.equalTo(contentView.snp.bottom)
        }
    }
}

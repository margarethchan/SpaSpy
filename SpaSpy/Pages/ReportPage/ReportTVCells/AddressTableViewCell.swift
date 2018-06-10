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
    
    lazy var icon: UIImageView = {
        let image = UIImageView()
        image.image = #imageLiteral(resourceName: "mapwhitelarge")
//        image.backgroundColor = .black
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
    
    lazy var mapIconButton: UIButton = {
        let button = UIButton()
        button.setImage(#imageLiteral(resourceName: "pinwhite1"), for: .normal)
        return button
    }()
    
    lazy var addLocationButton: UIButton = {
        let button = UIButton()
        button.setTitle("Add Location", for: .normal)
        button.backgroundColor = UIColor(red:0.39, green:0.82, blue:1.00, alpha:1.0)
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
        }
        
        contentView.addSubview(businessNameLabel)
        businessNameLabel.snp.makeConstraints { (make) in
            make.top.equalTo(businessAddressHeaderLabel.snp.bottom).offset(10)
            make.leading.equalTo(contentView.snp.leading).offset(10)
            make.trailing.equalTo(contentView.snp.trailing).offset(-10)
        }
        
        contentView.addSubview(businessAddressLabel)
        businessAddressLabel.snp.makeConstraints { (make) in
            make.top.equalTo(businessNameLabel.snp.bottom).offset(10)
            make.leading.equalTo(contentView.snp.leading).offset(10)
            make.trailing.equalTo(contentView.snp.trailing).offset(-10)
        }
        
        contentView.addSubview(addLocationButton)
        addLocationButton.snp.makeConstraints { (make) in
            make.centerX.equalTo(contentView)
            make.top.equalTo(businessAddressLabel.snp.bottom).offset(10)
            make.height.equalTo(40)
            make.width.equalTo(contentView.snp.width).multipliedBy(0.9)
            make.bottom.equalTo(contentView.snp.bottom).offset(-10)
        }
        
        contentView.addSubview(mapIconButton)
        mapIconButton.snp.makeConstraints { (make) in
            make.leading.equalTo(addLocationButton.snp.leading).offset(5)
            make.centerY.equalTo(addLocationButton.snp.centerY)
            make.height.width.equalTo(25)
        }
    }
}

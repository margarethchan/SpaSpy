//
//  RedFlagsTableViewCell.swift
//  SpaSpy
//
//  Created by C4Q on 4/27/18.
//  Copyright © 2018 C4Q. All rights reserved.
//

import UIKit
import SnapKit

class RedFlagsTableViewCell: UITableViewCell {

    public var redFlagsCellHeight: Constraint? = nil
    
    lazy var icon: UIImageView = {
        let image = UIImageView()
        image.image = #imageLiteral(resourceName: "flagwhiteempty")
        image.contentMode = .scaleAspectFill
        return image
    }()
    
    lazy var redFlagsLabel: UILabel = {
        let label = UILabel()
        label.text = "Red Flags"
        label.font = UIFont.boldSystemFont(ofSize: 20)
                label.textColor = StyleSheet.headerColor
        return label
    }()
    
    lazy var selectedFlagsLabel: UILabel = {
        let label = UILabel()
        label.text = "No Flags Selected"
        label.font = UIFont.italicSystemFont(ofSize: 17)
        return label
    }()
    
    lazy var flagIconButton: UIButton = {
        let button = UIButton()
        button.setImage(#imageLiteral(resourceName: "flagtrianglewhite"), for: .normal)
        return button
    }()
    
    lazy var addRedFlagsButton: UIButton = {
        let button = UIButton()
        button.setTitle("Set Red Flags", for: .normal)
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
        
        contentView.addSubview(redFlagsLabel)
        redFlagsLabel.snp.makeConstraints { (make) in
            make.centerY.equalTo(icon.snp.centerY)
            make.leading.equalTo(icon.snp.trailing).offset(StyleSheet.headerIconOffset)
            make.width.equalTo(contentView.snp.width).multipliedBy(0.85)
            make.height.equalTo(30)
        }
        
        contentView.addSubview(addRedFlagsButton)
        addRedFlagsButton.snp.makeConstraints { (make) in
            make.centerX.equalTo(contentView.snp.centerX)
            make.top.equalTo(redFlagsLabel.snp.bottom).offset(5)
            make.width.equalTo(contentView.snp.width).multipliedBy(0.85)
            make.height.equalTo(30)
        }
        
        contentView.addSubview(selectedFlagsLabel)
        selectedFlagsLabel.snp.makeConstraints { (make) in
            make.top.equalTo(addRedFlagsButton.snp.bottom).offset(5)
            make.centerX.equalTo(contentView.snp.centerX)
            make.width.equalTo(contentView.snp.width).multipliedBy(0.85)
            self.redFlagsCellHeight = make.height.equalTo(30).constraint
            make.bottom.equalTo(contentView.snp.bottom)
        }
    }
}

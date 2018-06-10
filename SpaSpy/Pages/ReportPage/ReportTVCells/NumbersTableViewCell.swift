//
//  NumbersTableViewCell.swift
//  SpaSpy
//
//  Created by C4Q on 4/27/18.
//  Copyright © 2018 C4Q. All rights reserved.
//

import UIKit
import SnapKit

class NumbersTableViewCell: UITableViewCell {

    lazy var icon: UIImageView = {
        let image = UIImageView()
        image.image = #imageLiteral(resourceName: "phonewhiteempty")
//        image.backgroundColor = .black
        image.contentMode = .scaleAspectFill
        return image
    }()
    
    lazy var numbersLabel: UILabel = {
        let label = UILabel()
        label.text = "Phone Numbers"
        label.font = UIFont.boldSystemFont(ofSize: 20)
                label.textColor = StyleSheet.headerColor
        return label
    }()
    
    lazy var numbersTextView: UITextView = {
        let tv = UITextView()
        tv.text = "Listed Phone Numbers"
        tv.isEditable = true
        tv.textColor = .lightGray
        tv.isScrollEnabled = true
        tv.layer.borderWidth = 1
        tv.font = UIFont.systemFont(ofSize: 17)
        tv.keyboardType = .numbersAndPunctuation
        return tv
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
        
        contentView.addSubview(numbersLabel)
        numbersLabel.snp.makeConstraints { (make) in
            make.centerY.equalTo(icon.snp.centerY)
            make.leading.equalTo(icon.snp.trailing).offset(StyleSheet.headerIconOffset)
        }

        contentView.addSubview(numbersTextView)
        numbersTextView.snp.makeConstraints { (make) in
            make.top.equalTo(numbersLabel.snp.bottom).offset(10)
            make.centerX.equalTo(contentView)
            make.height.equalTo(40)
            make.width.equalTo(contentView.snp.width).multipliedBy(0.9)
            make.bottom.equalTo(contentView.snp.bottom).offset(-10)
        }
    }
}

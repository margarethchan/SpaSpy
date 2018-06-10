//
//  NotesTableViewCell.swift
//  SpaSpy
//
//  Created by C4Q on 4/27/18.
//  Copyright © 2018 C4Q. All rights reserved.
//

import UIKit
import SnapKit

class NotesTableViewCell: UITableViewCell {

    lazy var icon: UIImageView = {
        let image = UIImageView()
        image.image = #imageLiteral(resourceName: "pencilwhite")
//        image.backgroundColor = .black
        image.contentMode = .scaleAspectFill
        return image
    }()

    lazy var notesLabel: UILabel = {
        let label = UILabel()
        label.text = "Notes"
        label.font = UIFont.boldSystemFont(ofSize: 20)
                label.textColor = StyleSheet.headerColor
        return label
    }()
    
    lazy var notesTextView: UITextView = {
        let tv = UITextView()
        tv.text = "Other Notes"
//        tv.backgroundColor = .lightGray
        tv.isEditable = true
        tv.textColor = .lightGray
        tv.isScrollEnabled = true
        tv.layer.borderWidth = 1
        tv.font = UIFont.systemFont(ofSize: 17)
        tv.keyboardType = .default
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
        
         contentView.addSubview(notesLabel)
        notesLabel.snp.makeConstraints { (make) in
            make.centerY.equalTo(icon.snp.centerY)
            make.leading.equalTo(icon.snp.trailing).offset(StyleSheet.headerIconOffset)
        }
        
        contentView.addSubview(notesTextView)
        notesTextView.snp.makeConstraints { (make) in
            make.top.equalTo(notesLabel.snp.bottom).offset(10)
            make.centerX.equalTo(contentView)
            make.height.equalTo(100)
            make.width.equalTo(contentView.snp.width).multipliedBy(0.9)
            make.bottom.equalTo(contentView.snp.bottom).offset(-10)
        }
    }
}

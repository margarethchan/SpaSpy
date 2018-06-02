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

    lazy var redFlagsLabel: UILabel = {
        let label = UILabel()
        label.text = "Red Flags"
        label.font = UIFont.boldSystemFont(ofSize: 20)
        return label
    }()
    
    lazy var selectedFlagsLabel: UILabel = {
        let label = UILabel()
        label.text = "No Flags Selected"
        label.font = UIFont.boldSystemFont(ofSize: 17)
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
        button.backgroundColor = UIColor(red:0.39, green:0.82, blue:1.00, alpha:1.0)
        button.layer.borderWidth = 1
        button.setTitleColor(UIColor.black, for: .normal)
        return button
    }()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }



    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit() {
        backgroundColor = .white
        setupViews()
        setUpConstraints()
    }
    
    private func setupViews() {
        contentView.addSubview(redFlagsLabel)
        contentView.addSubview(selectedFlagsLabel)
        contentView.addSubview(addRedFlagsButton)
        contentView.addSubview(flagIconButton)
    }

    private func setUpConstraints() {
        redFlagsLabel.snp.makeConstraints { (make) in
            make.top.leading.equalTo(contentView).offset(10)
        }
        
        selectedFlagsLabel.snp.makeConstraints { (make) in
            make.top.equalTo(redFlagsLabel.snp.bottom).offset(10)
            make.centerX.equalTo(contentView)
//            make.leading.equalTo(contentView.snp.leading).offset(10)
//            make.trailing.equalTo(contentView.snp.trailing).offset(-10)
        }
        
        addRedFlagsButton.snp.makeConstraints { (make) in
            make.centerX.equalTo(contentView)
            make.top.equalTo(selectedFlagsLabel.snp.bottom).offset(10)
            make.height.equalTo(40)
            make.width.equalTo(contentView.snp.width).multipliedBy(0.9)
            make.bottom.equalTo(contentView.snp.bottom).offset(-10)
        }
        
        flagIconButton.snp.makeConstraints { (make) in
            make.leading.equalTo(addRedFlagsButton.snp.leading).offset(5)
            make.centerY.equalTo(addRedFlagsButton.snp.centerY)
            make.centerY.equalTo(addRedFlagsButton.snp.centerY)
            make.height.width.equalTo(25)
        }
    }
}

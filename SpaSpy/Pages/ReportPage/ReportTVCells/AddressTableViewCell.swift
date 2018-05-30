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
    
    lazy var businessAddressLabel: UILabel = {
        let label = UILabel()
        label.text = "Business Address"
        label.font = UIFont.boldSystemFont(ofSize: 20)
        return label
    }()
    
    lazy var mapIconButton: UIButton = {
        let button = UIButton()
        button.setImage(#imageLiteral(resourceName: "pinwhite1"), for: .normal)
//        button.backgroundColor = .red
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
    
    // Presents a modal view with a tableview of red flags with switches set to off for user to switch on for applicable cases
    // Present FlagsView modally
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    
    // setup custom view
    
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
        contentView.addSubview(businessAddressLabel)
        contentView.addSubview(addLocationButton)
        contentView.addSubview(mapIconButton)
    }
    
    private func setUpConstraints() {
        businessAddressLabel.snp.makeConstraints { (make) in
            make.top.leading.equalTo(contentView).offset(10)
        }
        
        addLocationButton.snp.makeConstraints { (make) in
            make.centerX.equalTo(contentView)
            make.top.equalTo(businessAddressLabel.snp.bottom).offset(10)
            make.height.equalTo(40)
            make.width.equalTo(contentView.snp.width).multipliedBy(0.9)
            make.bottom.equalTo(contentView.snp.bottom).offset(-10)
        }
        
        mapIconButton.snp.makeConstraints { (make) in
            make.leading.equalTo(addLocationButton.snp.leading).offset(5)
            make.centerY.equalTo(addLocationButton.snp.centerY)
            make.height.width.equalTo(25)
        }
    }
}

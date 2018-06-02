//
//  FlagTableViewCell.swift
//  SpaSpy
//
//  Created by C4Q on 5/8/18.
//  Copyright © 2018 C4Q. All rights reserved.
//

import UIKit
import SnapKit

class FlagTableViewCell: UITableViewCell {

    lazy var flagLabel: UILabel = {
        let label = UILabel()
        label.text = "Flag Description"
        label.textAlignment = .left
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 17)
        return label
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: nil)
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
        contentView.addSubview(flagLabel)
    }
    
    private func setUpConstraints() {
        flagLabel.snp.makeConstraints { (make) in
            make.centerY.equalTo(contentView.snp.centerY)
            make.leading.trailing.equalTo(contentView)
        }
    }
}

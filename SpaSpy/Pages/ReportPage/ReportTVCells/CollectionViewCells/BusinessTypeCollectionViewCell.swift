//
//  BusinessTypeCollectionViewCell.swift
//  SpaSpy
//
//  Created by C4Q on 4/27/18.
//  Copyright © 2018 C4Q. All rights reserved.
//

import UIKit
import SnapKit

class BusinessTypeCollectionViewCell: UICollectionViewCell {
    
    lazy var businessTypeLabel: UILabel = {
       let label = UILabel()
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit() {
        backgroundColor = UIColor(red:0.39, green:0.82, blue:1.00, alpha:1.0)
        layer.borderWidth = 1
        setupViews()
        setUpConstraints()
    }
    
    private func setupViews() {
        contentView.addSubview(businessTypeLabel)
    }
    
    private func setUpConstraints() {
        businessTypeLabel.snp.makeConstraints { (make) in
            make.centerX.centerY.equalTo(contentView)
        }
    }
    
    override var isSelected: Bool {
        didSet {
            self.layer.borderWidth = isSelected ? 3.0 : 1.0
            self.layer.borderColor = isSelected ? UIColor.red.cgColor : UIColor.black.cgColor
        }
    }
    
    
}

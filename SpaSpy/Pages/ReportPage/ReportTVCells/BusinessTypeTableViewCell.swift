//
//  BusinessTypeTableViewCell.swift
//  SpaSpy
//
//  Created by C4Q on 4/27/18.
//  Copyright © 2018 C4Q. All rights reserved.
//

import UIKit
import SnapKit

class BusinessTypeTableViewCell: UITableViewCell {

    lazy var businessTypeLabel: UILabel = {
        let label = UILabel()
        label.text = "Business Type"
        label.font = UIFont.boldSystemFont(ofSize: 20)
        return label
    }()
    
    lazy var businessTypeCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let screenHeight: CGFloat = UIScreen.main.bounds.height
        let screenWidth: CGFloat = UIScreen.main.bounds.width
        let cellSpacing = UIScreen.main.bounds.width * 0.01
        let numberOfCells: CGFloat = 1
        let numberOfSpaces: CGFloat = numberOfCells + 1
        layout.itemSize = CGSize(width: (screenWidth - (cellSpacing * numberOfSpaces)) / numberOfCells, height: (screenWidth - (cellSpacing * numberOfSpaces)))
        layout.sectionInset = UIEdgeInsetsMake(cellSpacing, cellSpacing, cellSpacing, cellSpacing)
        layout.minimumLineSpacing = cellSpacing
        layout.minimumInteritemSpacing = cellSpacing
        let cv = UICollectionView(frame: self.bounds, collectionViewLayout: layout)
        cv.register(BusinessTypeCollectionViewCell.self, forCellWithReuseIdentifier: "BusinessTypeCollectionViewCell")
        cv.showsHorizontalScrollIndicator = false
        cv.backgroundColor = .clear
        return cv
    }()
    
//    lazy var otherBusinessTypeTextField: UITextField = {
//        let tf = UITextField()
////        tf.backgroundColor = .lightGray
//        tf.placeholder = " Other Type of Business"
////        tf.borderStyle = .roundedRect
//        tf.layer.borderWidth = 1
//        return tf
//    }()
    lazy var otherBusinessTypeTextView: UITextView = {
        let tv = UITextView()
        tv.text = "Other Type of Business"
        tv.isEditable = true
        tv.textColor = .lightGray
        tv.isScrollEnabled = true
        tv.layer.borderWidth = 1
        tv.font = UIFont.systemFont(ofSize: 17)
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
        backgroundColor = .white
        setupViews()
        setUpConstraints()
    }
    
    private func setupViews() {
        contentView.addSubview(businessTypeLabel)
        contentView.addSubview(businessTypeCollectionView)
        contentView.addSubview(otherBusinessTypeTextView)
    }
    
    private func setUpConstraints() {
        businessTypeLabel.snp.makeConstraints { (make) in
            make.top.leading.equalTo(contentView).offset(10)
        }
        
        businessTypeCollectionView.snp.makeConstraints { (make) in
            make.leading.trailing.equalTo(contentView)
            make.top.equalTo(businessTypeLabel.snp.bottom).offset(10)
            make.height.equalTo(40)
        }
        
        otherBusinessTypeTextView.snp.makeConstraints { (make) in
            make.centerX.equalTo(contentView)
            make.top.equalTo(businessTypeCollectionView.snp.bottom).offset(10)
            make.height.equalTo(40)
            make.width.equalTo(contentView.snp.width).multipliedBy(0.9)
            make.bottom.equalTo(contentView.snp.bottom).offset(-10)
        }
        
    }

}

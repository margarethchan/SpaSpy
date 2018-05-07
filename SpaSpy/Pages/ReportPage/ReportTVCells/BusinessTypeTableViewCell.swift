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
        //        categoriesCV.backgroundColor = .white
        cv.register(BusinessTypeCollectionViewCell.self, forCellWithReuseIdentifier: "BusinessTypeCollectionViewCell")
        cv.showsHorizontalScrollIndicator = false
        cv.backgroundColor = .white
        return cv
    }()
    
    lazy var otherBusinessTypeTextField: UITextField = {
        let tf = UITextField()
        tf.backgroundColor = .gray
        return tf
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
        contentView.addSubview(otherBusinessTypeTextField)
    }
    
    private func setUpConstraints() {
        businessTypeLabel.snp.makeConstraints { (make) in
            make.top.leading.equalTo(contentView)
        }
        
        businessTypeCollectionView.snp.makeConstraints { (make) in
            make.leading.trailing.equalTo(contentView)
            make.top.equalTo(businessTypeLabel.snp.bottom).offset(10)
            make.height.equalTo(40)
        }
        
        otherBusinessTypeTextField.snp.makeConstraints { (make) in
            make.centerX.equalTo(contentView)
            make.top.equalTo(businessTypeCollectionView.snp.bottom).offset(10)
            make.height.equalTo(30)
            make.width.equalTo(contentView.snp.width).multipliedBy(0.75)
            make.bottom.equalTo(contentView.snp.bottom).offset(-10)
        }
        
    }

}

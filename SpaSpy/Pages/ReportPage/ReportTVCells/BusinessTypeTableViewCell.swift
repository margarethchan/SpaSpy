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

    lazy var icon: UIImageView = {
        let image = UIImageView()
        image.image = #imageLiteral(resourceName: "flowerwhite")
//        image.backgroundColor = .black
        image.contentMode = .scaleAspectFill
        return image
    }()
    
    lazy var businessTypeLabel: UILabel = {
        let label = UILabel()
        label.text = "Business Services"
        label.font = UIFont.boldSystemFont(ofSize: 20)
                label.textColor = StyleSheet.headerColor
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
    
    lazy var otherBusinessTypeTextView: UITextView = {
        let tv = UITextView()
        tv.text = "Other Type of Service"
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
        
        contentView.addSubview(businessTypeLabel)
        businessTypeLabel.snp.makeConstraints { (make) in
            make.centerY.equalTo(icon.snp.centerY)
            make.leading.equalTo(icon.snp.trailing).offset(StyleSheet.headerIconOffset)
        }
        
        contentView.addSubview(businessTypeCollectionView)
        businessTypeCollectionView.snp.makeConstraints { (make) in
            make.leading.trailing.equalTo(contentView)
            make.top.equalTo(businessTypeLabel.snp.bottom)
            make.height.equalTo(60)
        }
        
        contentView.addSubview(otherBusinessTypeTextView)
        otherBusinessTypeTextView.snp.makeConstraints { (make) in
            make.centerX.equalTo(contentView)
            make.top.equalTo(businessTypeCollectionView.snp.bottom)
            make.height.equalTo(40)
            make.width.equalTo(contentView.snp.width).multipliedBy(0.9)
            make.bottom.equalTo(contentView.snp.bottom).offset(-10)
        }
        
    }

}

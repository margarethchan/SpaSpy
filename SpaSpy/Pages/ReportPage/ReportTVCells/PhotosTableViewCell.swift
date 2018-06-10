//
//  PhotosTableViewCell.swift
//  SpaSpy
//
//  Created by C4Q on 4/27/18.
//  Copyright © 2018 C4Q. All rights reserved.
//

import UIKit
import SnapKit

class PhotosTableViewCell: UITableViewCell {

    public var collectionCellHeight: Constraint? = nil
    public var addPhotoWidth: Constraint? = nil
    public var addPhotoLeading: Constraint? = nil
    public var addPhotoCenter: Constraint? = nil
    
    lazy var icon: UIImageView = {
        let image = UIImageView()
        image.image = #imageLiteral(resourceName: "camerawhite2")
        image.contentMode = .scaleAspectFill
        return image
    }()
    
    lazy var photosHeaderLabel: UILabel = {
        let label = UILabel()
        label.text = "Photos of Business"
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textColor = StyleSheet.headerColor
        return label
    }()
    
    lazy var addPhotoButton: UIButton = {
        let button = UIButton()
        button.setTitle("Add Photo", for: .normal)
        button.backgroundColor = UIColor(red:0.39, green:0.82, blue:1.00, alpha:1.0)
        button.layer.borderWidth = 1
        button.setTitleColor(UIColor.black, for: .normal)
        return button
    }()
    
    lazy var removePhotoButton: UIButton = {
        let button = UIButton()
        button.setTitle("Remove Last", for: .normal)
        button.backgroundColor = .lightGray
        button.layer.borderWidth = 1
        button.setTitleColor(UIColor.black, for: .normal)
        return button
    }()
    
    lazy var photosCollectionView: UICollectionView = {
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
        cv.register(AddPhotoCollectionViewCell.self, forCellWithReuseIdentifier: "AddPhotoCollectionViewCell")
        cv.showsHorizontalScrollIndicator = false
        cv.backgroundColor = .clear
        return cv
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
        
        contentView.addSubview(photosHeaderLabel)
        photosHeaderLabel.snp.makeConstraints { (make) in
            make.centerY.equalTo(icon.snp.centerY)
            make.leading.equalTo(icon.snp.trailing).offset(StyleSheet.headerIconOffset)
            make.height.equalTo(30)
        }
        
        contentView.addSubview(addPhotoButton)
        addPhotoButton.snp.makeConstraints { (make) in
//            make.centerY.equalTo(icon.snp.centerY)
            make.top.equalTo(photosHeaderLabel.snp.bottom).offset(10)
            self.addPhotoLeading = make.leading.equalTo(contentView.snp.leading).offset(10).constraint
            make.height.equalTo(30)
            self.addPhotoWidth = make.width.equalTo(contentView.snp.width).multipliedBy(0.4).constraint
        }
        
        contentView.addSubview(removePhotoButton)
        removePhotoButton.snp.makeConstraints { (make) in
//            make.trailing.equalTo(contentView.snp.trailing).offset(-20)
            make.centerX.equalTo(contentView.snp.centerX).multipliedBy(1.45)
            make.top.equalTo(addPhotoButton.snp.top)
            make.height.equalTo(30)
            make.width.equalTo(contentView.snp.width).multipliedBy(0.4)
        }
        
        contentView.addSubview(photosCollectionView)
        photosCollectionView.snp.makeConstraints { (make) in
            make.leading.trailing.equalTo(contentView)
            make.top.equalTo(addPhotoButton.snp.bottom)
            self.collectionCellHeight = make.height.equalTo(120).constraint
            make.bottom.equalTo(contentView.snp.bottom)
        }
    }
}

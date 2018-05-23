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

    lazy var photosLabel: UILabel = {
        let label = UILabel()
        label.text = "Photos"
        return label
    }()
    
    lazy var addPhotoButton: UIButton = {
        let button = UIButton()
        button.setTitle("Add Photo", for: .normal)
        button.backgroundColor = .orange
        return button
    }()
    
    lazy var removePhotoButton: UIButton = {
        let button = UIButton()
        button.setTitle("Remove Last Photo", for: .normal)
        button.backgroundColor = .green
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
        //        categoriesCV.backgroundColor = .white
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
        backgroundColor = .white
        setupViews()
        setUpConstraints()
    }
    
    private func setupViews() {
        contentView.addSubview(photosLabel)
        contentView.addSubview(addPhotoButton)
        contentView.addSubview(removePhotoButton)
        contentView.addSubview(photosCollectionView)
        
    }
    
    private func setUpConstraints() {
        photosLabel.snp.makeConstraints { (make) in
            make.top.leading.equalTo(contentView)
        }
        
        addPhotoButton.snp.makeConstraints { (make) in
            make.leading.equalTo(contentView.snp.leading).offset(10)
            make.top.equalTo(photosLabel.snp.bottom).offset(10)
            make.height.equalTo(30)
            make.width.equalTo(contentView.snp.width).multipliedBy(0.45)
        }
        
        removePhotoButton.snp.makeConstraints { (make) in
            make.trailing.equalTo(contentView.snp.trailing).offset(-10)
            make.top.equalTo(photosLabel.snp.bottom).offset(10)
            make.height.equalTo(30)
            make.width.equalTo(contentView.snp.width).multipliedBy(0.45)
        }
        
        photosCollectionView.snp.makeConstraints { (make) in
            make.leading.trailing.equalTo(contentView)
            make.top.equalTo(addPhotoButton.snp.bottom).offset(10)
            make.height.equalTo(90)
            make.bottom.equalTo(contentView.snp.bottom).offset(-10)
        }
        
    }
}

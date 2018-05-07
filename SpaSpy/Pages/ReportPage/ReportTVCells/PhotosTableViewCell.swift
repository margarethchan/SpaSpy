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
        cv.backgroundColor = .white
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
        contentView.addSubview(photosCollectionView)
    }
    
    private func setUpConstraints() {
        photosLabel.snp.makeConstraints { (make) in
            make.top.leading.equalTo(contentView)
        }
        
        photosCollectionView.snp.makeConstraints { (make) in
            make.leading.trailing.equalTo(contentView)
            make.top.equalTo(photosLabel.snp.bottom).offset(10)
            make.height.equalTo(90)
            make.bottom.equalTo(contentView.snp.bottom).offset(-10)
        }
        
    }
}

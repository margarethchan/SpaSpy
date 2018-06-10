//
//  AddPhotoCollectionViewCell.swift
//  SpaSpy
//
//  Created by C4Q on 4/27/18.
//  Copyright © 2018 C4Q. All rights reserved.
//

import UIKit
import SnapKit

class AddPhotoCollectionViewCell: UICollectionViewCell {
    
    lazy var addImageIcon: UIImageView = {
        let imageView = UIImageView()
//        imageView.image = #imageLiteral(resourceName: "camerawhite2")
        return imageView
    }()
    
    lazy var addImageButton: UIButton = {
        let button = UIButton()

        return button
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
        backgroundColor = .clear
        setUpConstraints()
    }
    
    private func setUpConstraints() {
        contentView.addSubview(addImageIcon)
        addImageIcon.snp.makeConstraints { (make) in
            make.top.leading.trailing.bottom.equalTo(contentView)
        }
        
        contentView.addSubview(addImageButton)
        addImageButton.snp.makeConstraints { (make) in
            make.top.leading.trailing.bottom.equalTo(contentView)
        }
    }
}

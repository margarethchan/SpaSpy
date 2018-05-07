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
        imageView.image = #imageLiteral(resourceName: "cam1")
        return imageView
    }()
    
    // image of a camera
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
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
        contentView.addSubview(addImageIcon)
    }
    
    private func setUpConstraints() {
        addImageIcon.snp.makeConstraints { (make) in
            make.top.leading.trailing.bottom.equalTo(contentView)
        }
    }
}

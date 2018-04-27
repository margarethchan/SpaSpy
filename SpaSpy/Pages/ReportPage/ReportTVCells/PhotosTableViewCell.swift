//
//  PhotosTableViewCell.swift
//  SpaSpy
//
//  Created by C4Q on 4/27/18.
//  Copyright © 2018 C4Q. All rights reserved.
//

import UIKit

class PhotosTableViewCell: UITableViewCell {

    @IBOutlet weak var photosCollectionView: UICollectionView!

    
//    func setCollectionViewDataSourceDelegate
//        <D: UICollectionViewDataSource & UICollectionViewDelegate>
//        (dataSourceDelegate: D, forRow row: Int) {
//        
//        photosCollectionView.delegate = dataSourceDelegate
//        photosCollectionView.dataSource = dataSourceDelegate
//        photosCollectionView.tag = row
//        photosCollectionView.reloadData()
//    }
    
    
    
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        commonInit()
        photosCollectionView.backgroundColor = .red
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit() {
//        backgroundColor = .white
//        setupViews()
    }
    
//    override func layoutSubviews() {
//        super.layoutSubviews() // sets image the way we want without it changing during scrolling
        // we get the frame of the UI elements here
//        profileImageView.layer.cornerRadius = profileImageView.bounds.width / 2.0 /// makes image a circle frame
//        profileImageView.layer.masksToBounds = true
//    }
    
//    private func setupViews() {
//        setupProfileImage()
//        setupNameLabel()
//    }

    // Collection View of Images to be added by user
    // Clicking on First Cell presents CameraView modally
    // Added photos begin at Index 1
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

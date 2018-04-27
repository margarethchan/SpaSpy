//
//  AddPhotoCollectionViewCell.swift
//  SpaSpy
//
//  Created by C4Q on 4/27/18.
//  Copyright © 2018 C4Q. All rights reserved.
//

import UIKit

class AddPhotoCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var addImageIcon: UIImageView!
    // image of a camera
    

    override init(frame: CGRect) {
        super.init(frame: frame)
//        addImageIcon.backgroundColor = .yellow
//        addImageIcon.image = #imageLiteral(resourceName: "cam1")
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    
    
}

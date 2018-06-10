//
//  ReportTableViewController+CV.swift
//  SpaSpy
//
//  Created by C4Q on 5/7/18.
//  Copyright © 2018 C4Q. All rights reserved.
//

import UIKit

extension ReportTableViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDelegate, UICollectionViewDataSource {
    
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView.tag {
        case 0:
            if uploadedPhotos.count > 0 {
                return uploadedPhotos.count
            } else {
                return 1
            }
        case 1:
            return businessTypes.count
        default:
            return 1
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch collectionView.tag {
        case 0:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AddPhotoCollectionViewCell", for: indexPath) as! AddPhotoCollectionViewCell
            if indexPath.row < uploadedPhotos.count {
                let uploadedImage = uploadedPhotos[indexPath.row]
                cell.addImageIcon.image = uploadedImage
                cell.addImageButton.isHidden = true
                return cell
            } else {
                cell.addImageIcon.image = #imageLiteral(resourceName: "camerawhite2")
                cell.addImageIcon.backgroundColor = .clear
                cell.addImageButton.isHidden = false
                cell.addImageButton.addTarget(self, action: #selector(addImageButtonPressed), for: .touchUpInside)
                return cell
            }
        case 1:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BusinessTypeCollectionViewCell", for: indexPath) as! BusinessTypeCollectionViewCell
            let businessType = businessTypes[indexPath.row]
            cell.businessTypeLabel.text = businessType
            collectionView.allowsMultipleSelection = true
            return cell
        default:
            let cell = UICollectionViewCell()
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        switch collectionView.tag {
        case 0:
            let paddingSpace = sectionInsets.left * (itemsPerRow + 1)
            let availableWidth = view.frame.width - paddingSpace
            let widthPerItem = availableWidth / itemsPerRow
            return CGSize(width: widthPerItem, height: widthPerItem)
        case 1:
            let paddingSpace = sectionInsets.left * (5 + 1)
            let availableWidth = view.frame.width - paddingSpace
            let widthPerItem = availableWidth / 4
            return CGSize(width: widthPerItem, height: widthPerItem * 0.4)
        default:
            return CGSize(width: 5.0, height: 5.0)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        return sectionInsets
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return sectionInsets.left
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch collectionView.tag {
        case 0:
            let cell = collectionView.cellForItem(at: indexPath) as! AddPhotoCollectionViewCell
            if cell.addImageIcon.image == UIImage(named: "cam1") {
                print("add photo cell selected")
                addImageButtonPressed()
            }
        case 1:
            print("select business type cell selected")
            let cell = collectionView.cellForItem(at: indexPath) as! BusinessTypeCollectionViewCell
            let businessType = businessTypes[indexPath.row]
        default:
            print("")
        }
    }
    
    
    

}

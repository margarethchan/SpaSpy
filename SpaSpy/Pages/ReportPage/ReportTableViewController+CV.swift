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
            //        return uploadedPhotos.count
            return 10
        case 1:
            //            return selectedBusinessTypes.count
            return 5
        default:
            return 1
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch collectionView.tag {
        case 0:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AddPhotoCollectionViewCell", for: indexPath) as! AddPhotoCollectionViewCell
            let addPhotoIcon = #imageLiteral(resourceName: "cam1")
            cell.addImageIcon.image = addPhotoIcon
            return cell
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
            let widthPerItem = availableWidth / itemsPerRow - 5
            return CGSize(width: widthPerItem, height: widthPerItem)
        case 1:
            let paddingSpace = sectionInsets.left * (itemsPerRow + 1)
            let availableWidth = view.frame.width - paddingSpace
            let widthPerItem = availableWidth / itemsPerRow - 10
            return CGSize(width: widthPerItem, height: widthPerItem / 2)
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
            print("add photo cell selected")
        case 1:
            print("select business type cell selected")
            let cell = collectionView.cellForItem(at: indexPath)as! BusinessTypeCollectionViewCell
            let businessType = businessTypes[indexPath.row]
            
            
            /// do this at completion submission of report, not here
            //            if cell.isSelected {
            //                selectedBusinessTypes.append(businessType)
            //                print(selectedBusinessTypes)
            //            }
            ///
            
        default:
            print("")
        }
    }
}

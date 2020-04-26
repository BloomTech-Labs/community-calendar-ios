//
//  EventVC+CVDelegateFlowLayout.swift
//  Community Calendar
//
//  Created by Michael on 4/21/20.
//  Copyright © 2020 Mazjap Co. All rights reserved.
//

import UIKit



extension EventViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == myEventsCollectionView {
            return CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height / 9)
        } else if collectionView == detailAndCalendarCollectionView {
            if indexPath.item == 0 {
                return CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.width / 1.5)
            } else if indexPath.item == 1 {
                return CGSize(width: UIScreen.main.bounds.width, height: detailAndCalendarCollectionView.bounds.height - 10)
            }
                
//                view.bounds.height - myEventsCollectionView.bounds.height - 100)
        }
        return CGSize()
    }
    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
//        CGSize(width: collectionView.bounds.width, height: 40)
//    }
    
//    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
//        guard kind == UICollectionView.elementKindSectionHeader else {
//            return UICollectionReusableView()
//        }
//        let view = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "FilterHeaderView", for: indexPath)
//        
//        
//        return view
//    }
}

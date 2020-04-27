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
                return CGSize(width: UIScreen.main.bounds.width, height: detailAndCalendarCollectionView.bounds.height - 10)
            } else if indexPath.item == 1 {
                return CGSize(width: UIScreen.main.bounds.width, height: detailAndCalendarCollectionView.bounds.height - 10)
            }
        }
        return CGSize()
    }
}

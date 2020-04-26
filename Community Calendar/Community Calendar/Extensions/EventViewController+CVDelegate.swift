//
//  EventViewController+CVDelegate.swift
//  Community Calendar
//
//  Created by Michael on 4/16/20.
//  Copyright © 2020 Mazjap Co. All rights reserved.
//

import UIKit

extension EventViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == myEventsCollectionView {
            collectionView.scrollToItem(at: indexPath, at: .top, animated: true)
        } else if collectionView == detailAndCalendarCollectionView {
            collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        }
    }
}

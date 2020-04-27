//
//  MyEventsCVDataSource.swift
//  Community Calendar
//
//  Created by Michael on 4/16/20.
//  Copyright © 2020 Mazjap Co. All rights reserved.
//

import UIKit

extension EventViewController: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == myEventsCollectionView {
            return tmController.events.count
        }
        if collectionView == detailAndCalendarCollectionView {
            
            return DetailCalendar.allCases.count
        }
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == myEventsCollectionView {
            guard let cell = myEventsCollectionView.dequeueReusableCell(withReuseIdentifier: "MyEventCell", for: indexPath) as? MyEventCollectionViewCell else { return UICollectionViewCell() }
            
            let event = tmController.events[indexPath.item]
            
            cell.event = event
            return cell
        } else if collectionView == detailAndCalendarCollectionView {
            guard let cell = detailAndCalendarCollectionView.dequeueReusableCell(withReuseIdentifier: "DetailCalendarCell", for: indexPath) as? Detail_CalendarCollectionViewCell else { return UICollectionViewCell() }
            
            switch indexPath.item {
            case 0:
                cell.viewType = .detail
                if cell.event == nil {
                    cell.detailView.isHidden = true
                } else {
                    cell.detailView.isHidden = false
                }
                
                if tmController.events.count > 0 {
                    cell.event = self.detailEvent
                }
            case 1:
                cell.viewType = .calendar
            default:
                cell.viewType = .detail
            }
            return cell
        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, didHighlightItemAt indexPath: IndexPath) {

    }

}

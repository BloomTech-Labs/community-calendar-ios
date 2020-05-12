//
//  EventVC+CollectionView.swift
//  Community Calendar
//
//  Created by Michael on 5/8/20.
//  Copyright © 2020 Mazjap Co. All rights reserved.
//

import UIKit

extension EventViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == myEventsCollectionView {
//            return Apollo.shared.createdEvents.count
            return self.events?.count ?? 0
        }
        if collectionView == detailAndCalendarCollectionView {
            
            return ViewType.allCases.count
        }
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == myEventsCollectionView {
            guard let cell = myEventsCollectionView.dequeueReusableCell(withReuseIdentifier: "MyEventCell", for: indexPath) as? MyEventCollectionViewCell else { return UICollectionViewCell() }
            let events = self.events?.sorted(by: {$0.startDate < $1.startDate })
            let event = events?[indexPath.item]

            cell.event = event

            return cell
        } else if collectionView == detailAndCalendarCollectionView {
            guard let cell = detailAndCalendarCollectionView.dequeueReusableCell(withReuseIdentifier: "DetailCalendarCell", for: indexPath) as? Detail_CalendarCollectionViewCell else { return UICollectionViewCell() }
            
            switch indexPath.item {
            case 0:
                cell.event = self.detailEvent
                cell.viewType = .detail
//                if cell.event == nil {
//                    cell.detailView.isHidden = true
//                } else {
//                    cell.detailView.isHidden = false
//                }
                
            case 1:
                cell.viewType = .calendar
                cell.event = self.detailEvent
            default:
                cell.viewType = .detail
            }
            return cell
        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == myEventsCollectionView {
            collectionView.scrollToItem(at: indexPath, at: .top, animated: true)
            self.featuredIndexPath = indexPath
        } else if collectionView == detailAndCalendarCollectionView {
            collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        }
    }
    
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
    
    func getUsersEvents(completion: @escaping (Swift.Result<[FetchUserIdQuery.Data.User.CreatedEvent], Error>) -> Void) {
        if let oktaID = authController?.oktaID {
            Apollo.shared.fetchUserID(oktaID: oktaID) { result in
                if let user = try? result.get(), let createdEvents = user.createdEvents {
                    let sortedEvents = createdEvents.sorted(by: { $0.start < $1.start })
                    self.events = sortedEvents
                    self.events?.sort(by: { $0.startDate < $1.startDate } )
                    print(self.events?.count as Any)
                    print(createdEvents.count)
                    completion(.success(sortedEvents))
                }
            }
        }
    }
}

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
            switch userEvents {
            case .created:
                return createdEvents?.count ?? 0
            case .saved:
                return savedEvents?.count ?? 0
            case .attending:
                return attendingEvents?.count ?? 0
            case .none:
                return 0
            }
        }
        if collectionView == detailAndCalendarCollectionView {
            
            return ViewType.allCases.count
        }
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == myEventsCollectionView {
            guard let cell = myEventsCollectionView.dequeueReusableCell(withReuseIdentifier: "MyEventCell", for: indexPath) as? MyEventCollectionViewCell else { return UICollectionViewCell() }
            
            if userEvents == .created {
                let event = createdEvents?[indexPath.item]
                cell.createdEvent = event
            } else if userEvents == .saved {
                let event = savedEvents?[indexPath.item]
                cell.savedEvent = event
            } else if userEvents == .attending {
                let event = attendingEvents?[indexPath.item]
                cell.attendingEvent = event
            }
            
            return cell
        } else if collectionView == detailAndCalendarCollectionView {
            guard let cell = detailAndCalendarCollectionView.dequeueReusableCell(withReuseIdentifier: "DetailCalendarCell", for: indexPath) as? Detail_CalendarCollectionViewCell else { return UICollectionViewCell() }
            
            switch indexPath.item {
            case 0:
                cell.event = self.detailEvent
                cell.viewType = .detail
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
            let dynamicMargin = detailAndCalendarCollectionView.bounds.height / 10
            return CGSize(width: detailAndCalendarCollectionView.bounds.width, height: detailAndCalendarCollectionView.bounds.height - dynamicMargin)
        }
        return CGSize()
    }
    
    func getUsersEvents(completion: @escaping (Swift.Result<FetchUserIdQuery.Data.User, Error>) -> Void) {
        if let oktaID = authController?.oktaID {
            Apollo.shared.fetchUserID(oktaID: oktaID) { result in
                if let user = try? result.get(), let createdEvents = user.createdEvents, let savedEvents = user.saved, let attendingEvents = user.rsvps {
                    let sortedCreated = createdEvents.sorted(by: { $0.startDate < $1.startDate })
                    let sortedSaved = savedEvents.sorted(by: { $0.startDate < $1.startDate })
                    let sortedAttending = attendingEvents.sorted(by: { $0.startDate < $1.startDate })
                    self.createdEvents = sortedCreated
                    self.savedEvents = sortedSaved
                    self.attendingEvents = sortedAttending
//                    self.createdEvents?.sort(by: { $0.startDate < $1.startDate } )
                    print("Created Events: \(String(describing: self.createdEvents?.count)), Saved Events: \(String(describing: self.savedEvents?.count)), Attending Events: \(String(describing: self.attendingEvents?.count))")
                    completion(.success(user))
                }
            }
        }
    }
}

//
//  MyEventsCVDataSource.swift
//  Community Calendar
//
//  Created by Michael on 4/16/20.
//  Copyright © 2020 Mazjap Co. All rights reserved.
//

import UIKit

class TestEventObject {
    let eventName: String
    let eventImage: UIImage
    let eventDate: String
    let eventLocation: String
    
    init(eventName: String, eventImage: UIImage, eventDate: String, eventLocation: String) {
        self.eventName = eventName
        self.eventImage = eventImage.decompressedImage
        self.eventDate = eventDate
        self.eventLocation = eventLocation
    }
}


extension EventViewController: UICollectionViewDataSource {
    
    func addEvents() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        let eventDate = dateFormatter.string(from: Date())
        myEvents = [TestEventObject(eventName: "Snow Globe Music Festival",
                                    eventImage: UIImage(named: "TestEvent-4")!,
                                    eventDate: eventDate,
                                    eventLocation: "Lake Tahoe Community College Field - South Lake Tahoe, CA"),
                    TestEventObject(eventName: "Cypress Hill 420 Show",
                                    eventImage: UIImage(named: "TestEvent-6")!,
                                    eventDate: eventDate,
                                    eventLocation: "Fox Theater - Oakland, CA"),
                    TestEventObject(eventName: "Oracle OpenWorld",
                                    eventImage: UIImage(named: "TestEvent-7")!,
                                    eventDate: eventDate,
                                    eventLocation: "Mascone Center - San Francisco, CA"),
                    TestEventObject(eventName: "Burning Man",
                                    eventImage: UIImage(named: "TestEvent-8")!,
                                    eventDate: eventDate,
                                    eventLocation: "Black Rock Desert - Black Rock City, NV")]
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == myEventsCollectionView {
            return tmController.events.count
        }
        if collectionView == detailAndCalendarCollectionView {
            
            return DetailCalendar.allCases.count
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView == myEventsCollectionView {
            guard let cell = myEventsCollectionView.dequeueReusableCell(withReuseIdentifier: "MyEventCell", for: indexPath) as? MyEventCollectionViewCell else { return UICollectionViewCell() }
            
            let event = tmController.events[indexPath.item]
            
//            if let topCell = myEventsCollectionView.visibleCells.first {
//                let firstItemIndexPath = myEventsCollectionView.indexPath(for: topCell)
//                self.featuredIndexPath = firstItemIndexPath
//                print("This is the first item index path: \(String(describing: firstItemIndexPath))")
//                print("This is the featured index path: \(String(describing: self.featuredIndexPath))")
//            }
            cell.event = event
            return cell
        } else if collectionView == detailAndCalendarCollectionView {
            guard let cell = detailAndCalendarCollectionView.dequeueReusableCell(withReuseIdentifier: "DetailCalendarCell", for: indexPath) as? Detail_CalendarCollectionViewCell else { return UICollectionViewCell() }
            
            switch indexPath.item {
            case 0:
                cell.viewType = .detail
                if let featuredIndexPath = featuredIndexPath {
                    cell.event = tmController.events[featuredIndexPath.item]
                }
            case 1:
                cell.viewType = .calendar
            default:
                cell.viewType = .detail
            }
            print(collectionView.indexPathsForVisibleItems)
            return cell
        }
        
            
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, didHighlightItemAt indexPath: IndexPath) {
//        collectionView.index
    }

}

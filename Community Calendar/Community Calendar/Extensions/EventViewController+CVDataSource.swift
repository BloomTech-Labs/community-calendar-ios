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
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tmController.events.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = myEventsCollectionView.dequeueReusableCell(withReuseIdentifier: "MyEventCell", for: indexPath) as? MyEventCollectionViewCell else { return UICollectionViewCell() }
        
        
        let event = tmController.events[indexPath.item]
            
        cell.event = event
            
        return cell
    }
}

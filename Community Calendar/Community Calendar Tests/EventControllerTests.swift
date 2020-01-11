//
//  Community_Calendar_Tests.swift
//  Community Calendar Tests
//
//  Created by Jordan Christensen on 1/9/20.
//  Copyright © 2020 Mazjap Co. All rights reserved.
//

import XCTest
@testable import Community_Calendar

class EventControllerTests: XCTestCase {
    
    private let eventController = EventController()

    func testGettingEvents() {
        var events = [Event]()
        eventController.getEvents { result in
            switch result {
            case .success(let eventList):
                XCTAssertTrue(events.count == 0)
                events = eventList
                XCTAssertTrue(events.count > 0)
                XCTAssertNotNil(events.first?.title)
                XCTAssertNotNil(events.first?.description)
            case .failure(let error):
                XCTFail("\(error)")
            }
        }
    }
    
    func testDownloadingImage() {
        NotificationCenter.default.addObserver(self, selector: #selector(testDownloadingImageHelper), name: .imageWasLoaded, object: nil)
        
        eventController.loadImage(for: "https://images.pexels.com/photos/414612/pexels-photo-414612.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500")
    }
    
    @objc
    func testDownloadingImageHelper(_ notification: Notification) {
        guard let imageNotification = notification.object as? ImageNotification else {
            assertionFailure("Object type could not be inferred: \(notification.object as Any)")
            return
        }
        if imageNotification.url == "https://images.pexels.com/photos/414612/pexels-photo-414612.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500" {
            DispatchQueue.main.async {
                XCTAssertNotNil(imageNotification.image)
            }
        } else {
            XCTFail("Image returned was nil")
        }
    }
    
    func testFetchingImageFromCache() {
        NotificationCenter.default.addObserver(self, selector: #selector(testFetchingImageFromCacheHelper), name: .imageWasLoaded, object: nil)
        
        eventController.loadImage(for: "https://images.pexels.com/photos/414612/pexels-photo-414612.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500")
    }
    
    @objc
    func testFetchingImageFromCacheHelper(_ notification: Notification) {
        let cache = eventController.cache
        guard let _ = notification.object as? ImageNotification else {
            assertionFailure("Object type could not be inferred: \(notification.object as Any)")
            return
        }
        
        let image = cache.fetch(key: "https://images.pexels.com/photos/414612/pexels-photo-414612.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500")
        XCTAssertNotNil(image)
    }
}

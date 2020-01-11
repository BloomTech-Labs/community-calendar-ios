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
        eventController.loadImage(for: "https://images.pexels.com/photos/414612/pexels-photo-414612.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500", cache: nil) { result in
            switch result {
            case .success(let image):
                DispatchQueue.main.async {
                    XCTAssertNotNil(image)
                }
            case .failure:
                XCTFail("Could not fetch image")
            }
        }
    }
    
    func testFetchingImageFromCache() {
        let cache = Cache<String, UIImage>()
        eventController.loadImage(for: "https://images.pexels.com/photos/414612/pexels-photo-414612.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500", cache: cache) { result in
            switch result {
            case .success(let image):
                DispatchQueue.main.async {
                    XCTAssertNotNil(image)
                }
                XCTAssertNotNil(cache.fetch(key: "https://images.pexels.com/photos/414612/pexels-photo-414612.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500"))
            case .failure:
                XCTFail("Could not fetch image")
            }
        }
    }
}

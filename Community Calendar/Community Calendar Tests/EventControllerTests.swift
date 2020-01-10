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

    func testGettingEvents() {
        let eventController = EventController()
        eventController.getEvents()
    }
}

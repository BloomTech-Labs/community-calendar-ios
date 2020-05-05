//
//  EasyEvent.swift
//  Community Calendar
//
//  Created by Michael on 4/20/20.
//  Copyright © 2020 Mazjap Co. All rights reserved.
//

import UIKit

class EasyEvent {
    var eventName: String
    var eventImage: UIImage?
    var eventDate: Date?
    var stringEventDate: String?
    var eventAddress: String?
    var city: String?
    var state: String?
    var venueName: String?
    
    init(eventName: String, eventImage: UIImage?, eventDate: Date?, stringEventDate: String?, eventAddress: String?, city: String?, state: String?, venueName: String?) {
        self.eventName = eventName
        self.eventImage = eventImage
        self.eventDate = eventDate
        self.stringEventDate = stringEventDate
        self.eventAddress = eventAddress
        self.city = city
        self.state = state
        self.venueName = venueName
    }
    
    convenience init?(ticketMasterEvent: TicketMasterEvent) {
        guard
            let stringURL = ticketMasterEvent.images.first?.url,
            let imageURL = URL(string: stringURL),
            let data = try? Data(contentsOf: imageURL),
            let streetAddress = ticketMasterEvent.embedded.venues.first?.address.line1,
            let city = ticketMasterEvent.embedded.venues.first?.city.name,
            let state = ticketMasterEvent.embedded.venues.first?.state.stateCode,
            let zipCode = ticketMasterEvent.embedded.venues.first?.postalCode,
            let date = ticketMasterEvent.dates.start.dateTime
            else { return nil }
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .short
        
        self.init(eventName: ticketMasterEvent.name,
                  eventImage: UIImage(data: data),
                  eventDate: ticketMasterEvent.dates.start.dateTime,
                  stringEventDate: dateFormatter.string(from: date),
                  eventAddress: "\(streetAddress) \(city), \(state) \(zipCode)",
                  city: city,
                  state: state,
                  venueName: ticketMasterEvent.embedded.venues.first?.name)
    }
}


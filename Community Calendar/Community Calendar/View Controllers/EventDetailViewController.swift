//
//  EventDetailViewController.swift
//  Community Calendar
//
//  Created by Jordan Christensen on 1/11/20.
//  Copyright © 2020 Mazjap Co. All rights reserved.
//

import UIKit
import EventKit

class EventDetailViewController: UIViewController {
    
    var event: Event? {
        didSet {
            updateViews()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        updateViews()
    }
    
    private func updateViews() {
        guard isViewLoaded, let event = event else { return }
        title = event.title
    }
    
    @IBAction func showInMaps(_ sender: UIButton) {
        if let event = event, let address = event.locations.first?.streetAddress, let zip = event.locations.first?.zipcode {
            let baseURL = URL(string: "http://maps.apple.com/")!
            var components = URLComponents(url: baseURL, resolvingAgainstBaseURL: true)
            var addressNoSpaces = ""
            var isFirstSpace = true
            for letter in address {
                if letter != " " {
                    addressNoSpaces = "\(addressNoSpaces)\(letter)"
                } else if isFirstSpace {
                    isFirstSpace = false
                    addressNoSpaces = "\(addressNoSpaces),"
                }
            }
            
            let addressQuery = URLQueryItem(name: "address", value: "\(addressNoSpaces),\(zip)")
            components?.queryItems = [addressQuery]
            UIApplication.shared.open(components?.url ?? baseURL)
        } else if event?.locations.first == nil {
            print("Event has no location listed!")
        }
    }
    
    @IBAction func showInCalendar(_ sender: Any) {
        let eventStore = EKEventStore()
        eventStore.requestAccess(to: .event) { (granted, error) in
            if let error = error {
                NSLog("\(#file):L\(#line): Unable to request access to calendar in \(#function) with error: \(error)")
                return
            }

            if granted {
                guard let event = self.event else { return }
                
                let calendarEvent = EKEvent(eventStore: eventStore)

                calendarEvent.title = event.title
                calendarEvent.startDate = event.startDate
                calendarEvent.endDate = event.endDate
                calendarEvent.notes = event.description
                calendarEvent.calendar = eventStore.defaultCalendarForNewEvents
                do {
                    try eventStore.save(calendarEvent, span: .thisEvent)
                } catch let error {
                    print("Failed to save event with error: \(error)")
                    return
                }
                DispatchQueue.main.async {
                    self.openCalendar(with: calendarEvent.startDate)
                }
            }
            else {
                print("Access to calendar is not granted on device!") // TODO: Alert user and link to settings to change permissions
            }
        }
    }
    
    func openCalendar(with date: Date) {
        let alert = UIAlertController(title: "Open Calendar?", message: "The event has been added successfully. Would you like to view it in the Calendar?", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "No", style: .cancel))
        alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: { _ in
            let interval = date.timeIntervalSinceReferenceDate
            let url = URL(string: "calshow:\(interval)")!
            UIApplication.shared.open(url)
        }))
        self.present(alert, animated: true, completion: nil)
    }
}

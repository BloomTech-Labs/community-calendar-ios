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
    var eventController: EventController?
    var indexPath: IndexPath?
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var eventImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        observeImage()
        updateViews()
    }
    
    private func updateViews() {
        guard isViewLoaded, let event = event else { return }
        titleLabel.text = event.title
        
        if let eventController = eventController, let imageUrl = event.images.first {
            eventController.loadImage(for: imageUrl)
        } else {
            if let indexPath = indexPath {
                eventImageView.image = UIImage(named: "placeholder\(indexPath.row % 6)")
            } else {
                eventImageView.image = UIImage(named: "lambda")
            }
        }
    }
    
    @IBAction func showInMaps(_ sender: UIButton) {
        if let event = event, let address = event.locations.first?.streetAddress, let zip = event.locations.first?.zipcode {
            let baseURL = URL(string: "http://maps.apple.com/")!
            var components = URLComponents(url: baseURL, resolvingAgainstBaseURL: true)
            let addressQuery = URLQueryItem(name: "address", value: "\(address), \(zip)")
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
                guard let event = self.event, let startDate = event.startDate, let endDate = event.endDate else { return }
                
                if startDate > endDate {
                    let alert = UIAlertController(title: "Unable to add event to calendar", message: "The event's start date is after it's endDate. Would you like to add it to calendar with the start and end dates switched?", preferredStyle: .alert)
                    let yesAction = UIAlertAction(title: "Yes", style: .default) { _ in
                        let calendarEvent = EKEvent(eventStore: eventStore)

                        calendarEvent.title = event.title
                        calendarEvent.startDate = event.endDate
                        calendarEvent.endDate = event.startDate
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
                    let noAction = UIAlertAction(title: "No", style: .destructive, handler: nil)
                    alert.addAction(noAction)
                    alert.addAction(yesAction)
                    DispatchQueue.main.async {
                        self.present(alert, animated: true, completion: nil)
                    }
                } else {
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
            } else {
                print("Access to calendar is not granted on device!") // TODO: Alert user and link to settings to change permissions
            }
        }
    }
    
    func openCalendar(with date: Date) {
        let alert = UIAlertController(title: "Open Calendar", message: "The event has been added successfully. Would you like to view it in the Calendar?", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "No", style: .cancel))
        alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: { _ in
            let interval = date.timeIntervalSinceReferenceDate
            let url = URL(string: "calshow:\(interval)")!
            UIApplication.shared.open(url)
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    @objc
    func receiveImage(_ notification: Notification) {
        guard let imageNot = notification.object as? ImageNotification else {
            assertionFailure("Object type could not be inferred: \(notification.object as Any)")
            return
        }
        if let eventImageUrl = event?.images.first, imageNot.url == eventImageUrl {
            DispatchQueue.main.async {
                self.eventImageView.image = imageNot.image
            }
        }
    }
    
    func observeImage() {
        NotificationCenter.default.addObserver(self, selector: #selector(receiveImage), name: .imageWasLoaded, object: nil)
    }
}

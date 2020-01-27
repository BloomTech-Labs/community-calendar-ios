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
    // MARK: - Variables
    var event: Event? {
        didSet {
            updateViews()
        }
    }
    var eventController: EventController?
    var indexPath: IndexPath?
    let eventStore = EKEventStore()
    
    // MARK: - IBOutlets
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var eventImageView: UIImageView!
    
    // MARK: - Lifecycle Functions
    override func viewDidLoad() {
        super.viewDidLoad()

        observeImage()
        updateViews()
    }
    
    // MARK: - Functions
    private func updateViews() {
        guard isViewLoaded, let event = event else { return }
        titleLabel.text = event.title
        
        if let imageURL = event.images.first, !imageURL.isEmpty {
            if eventController?.cache.fetch(key: imageURL) == nil {
                eventImageView.image = nil
            }
            eventController?.loadImage(for: imageURL)
        } else {
            if let indexPath = indexPath {
                eventImageView.image = UIImage(named: "placeholder\(indexPath.row % 6)")
            } else {
                eventImageView.image = UIImage(named: "lambda")
            }
        }
    }
    
    func addToCalendar(event: Event, startDate: Date, endDate: Date?) {
        let calendarEvent = EKEvent(eventStore: eventStore)

        calendarEvent.title = event.title
        calendarEvent.startDate = startDate
        calendarEvent.endDate = endDate
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
    
    // MARK: - IBActions
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
        eventStore.requestAccess(to: .event) { (granted, error) in
            if let error = error {
                NSLog("\(#file):L\(#line): Unable to request access to calendar in \(#function) with error: \(error)")
                return
            }

            if granted {
                guard let event = self.event, let startDate = event.startDate, let endDate = event.endDate else {
                    var message = ""
                    if self.event?.startDate == nil && self.event?.endDate == nil {
                        message = "\(self.event?.title ?? "Event") has no start or end dates. It cannot be added to the calendar"
                    } else if self.event?.startDate == nil && self.event?.endDate != nil {
                        message = "\(self.event?.title ?? "Event") has no start date. It cannot be added to the calendar"
                    } else if self.event?.endDate == nil && self.event?.startDate != nil {
                        message = "\(self.event?.title ?? "Event") has no end date. It cannot be added to the calendar"
                    }
                    let alert = UIAlertController(title: "Unable to add to calendar", message: message, preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
                    
                    return
                }
                if startDate > endDate {
                    let alert = UIAlertController(title: "Unable to add event to calendar", message: "The event's start date is after it's endDate. Would you like to add it to calendar with the start and end dates switched?", preferredStyle: .alert)
                    let yesAction = UIAlertAction(title: "Yes", style: .default) { _ in
                        self.addToCalendar(event: event, startDate: endDate, endDate: startDate)
                    }
                    alert.addAction(UIAlertAction(title: "No", style: .destructive, handler: nil))
                    alert.addAction(yesAction)
                    DispatchQueue.main.sync {
                        self.present(alert, animated: true, completion: nil)
                    }
                }
                self.addToCalendar(event: event, startDate: startDate, endDate: endDate)
            } else {
                print("Access to calendar is not granted on device!") // TODO: Alert user and link to settings to change permissions
            }
        }
    }
}

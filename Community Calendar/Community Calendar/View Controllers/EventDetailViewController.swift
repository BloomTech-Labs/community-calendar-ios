//
//  EventDetailViewController.swift
//  Community Calendar
//
//  Created by Jordan Christensen on 1/11/20.
//  Copyright © 2020 Mazjap Co. All rights reserved.
//

import UIKit
import EventKit
import JWTDecode

class EventDetailViewController: UIViewController, UIScrollViewDelegate {
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
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var eventImageView: UIImageView!
    @IBOutlet private weak var attendButton: UIButton!
    @IBOutlet private weak var openInMapsButton: UIButton!
    @IBOutlet private weak var addToCalendarButton: UIButton!
    
    @IBOutlet private weak var hostImageView: UIImageView!
    @IBOutlet weak var hostShadowView: UIView!
    @IBOutlet private weak var hostNameLabel: UILabel!
    @IBOutlet private weak var timeLabel: UILabel! // Three lines
    @IBOutlet private weak var priceLabel: UILabel! // Red if free
    @IBOutlet private weak var eventDescTextView: UILabel!
    @IBOutlet private weak var dateLabel: UILabel!
    @IBOutlet private weak var addressLabel: UILabel!
    @IBOutlet weak var scrollView: UIScrollView!
    
    // MARK: - Lifecycle Functions
    override func viewDidLoad() {
        super.viewDidLoad()

        observeImage()
        setUp()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        checkForRSVP()
    }
    
    // MARK: - Functions
    private func setUp() {
        scrollView.delegate = self
        updateViews()
        fetchProfileImage()
    }
    
    func fetchProfileImage() {
        if let eventController = eventController, let event = event,
            let key = event.profileImageURL {
            eventController.fetchImage(for: key)
        }
    }
    
    private func updateViews() {
        guard isViewLoaded, let event = event else { return }
        
        titleLabel.text = event.title
        eventDescTextView.text = event.description
        hostNameLabel.text = event.creator
        hostImageView.layer.cornerRadius = hostImageView.frame.height/2
        hostShadowView.layer.cornerRadius = hostShadowView.frame.height/2
        hostShadowView.layer.shadowColor = UIColor.darkGray.cgColor
        hostShadowView.layer.shadowOpacity = 1.0
        hostShadowView.layer.shadowRadius = 1.5
        hostShadowView.layer.shadowOffset = CGSize(width: -1, height: 1)
        addressLabel.text = "\(event.locations.first?.streetAddress ?? ""), \(event.locations.first?.city ?? "")"
        if let startDate = event.startDate, let endDate = event.endDate {
            dateLabel.text = todayDateFormatter.string(from: startDate)
            timeLabel.text = "\(cellDateFormatter.string(from: startDate))\n-\n\(cellDateFormatter.string(from: endDate))"
        } else {
            timeLabel.text = "No time given"
        }
        priceLabel.text = "\(event.ticketPrice == 0.0 ? "Free" : "$\(event.ticketPrice)")"
        
        
        checkForRSVP()
        attendButton.layer.cornerRadius = 6
        attendButton.layer.borderWidth = 1
        attendButton.layer.borderColor = UIColor(red: 1, green: 0.404, blue: 0.408, alpha: 1).cgColor
        
        openInMapsButton.setTitleColor(.white, for: .normal)
        openInMapsButton.backgroundColor = UIColor(red: 0.129, green: 0.141, blue: 0.173, alpha: 1)
        openInMapsButton.layer.cornerRadius = 6
        
        addToCalendarButton.setTitleColor(.white, for: .normal)
        addToCalendarButton.backgroundColor = UIColor(red: 1, green: 0.404, blue: 0.408, alpha: 1)
        addToCalendarButton.layer.cornerRadius = 6
        
        if let imageURL = event.images.first, !imageURL.isEmpty {
            if eventController?.cache.fetch(key: imageURL) == nil {
                eventImageView.image = nil
            }
            eventController?.fetchImage(for: imageURL)
        } else {
            if let indexPath = indexPath {
                eventImageView.image = UIImage(named: "placeholder\(indexPath.row % 6)")
            } else {
                eventImageView.image = UIImage(named: "lambda")
            }
        }
    }
    
    func checkForRSVP() {
        self.attendButton.attrText("Attend")
        self.addToCalendarButton.isHidden = true
        guard let event = event, let eventController = eventController, let userToken = userToken else { return }
        do {
            let decodedToken = try decode(jwt: userToken)
            guard let userId = decodedToken.ccId else { return }
            eventController.checkForRsvp(with: userId) { ids, error  in
                if let error = error {
                    NSLog("\(#file):L\(#line): Configuration failed inside \(#function) with error: \(error)")
                    return
                }
                if let ids = ids, ids.contains(event.id) {
                    DispatchQueue.main.async {
                        self.attendButton.attrText("Unattend")
                        self.addToCalendarButton.isHidden = false
                    }
                }
            }
        } catch {
            NSLog("\(#file):L\(#line): Configuration failed inside \(#function) with error: \(error)")
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
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        scrollView.contentOffset.x = 0
    }
    
    func loginAlert(with message: String) {
        let alert = UIAlertController(title: "Please log in", message: "You must be logged in to \(message)", preferredStyle: .alert)
        let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        let login = UIAlertAction(title: "Log in", style: .default) { action in
            self.presentingViewController?.tabBarController?.selectedIndex = (self.presentingViewController?.tabBarController?.viewControllers?.count ?? 1) - 1
            alert.dismiss(animated: true, completion: nil)
            self.dismiss(animated: true)
        }
        alert.addAction(cancel)
        alert.addAction(login)
        self.present(alert, animated: true)
    }
    
    @objc
    func receiveImage(_ notification: Notification) {
        guard let imageNot = notification.object as? ImageNotification else {
            assertionFailure("Object type could not be inferred: \(notification.object as Any)")
            return
        }
        if let eventImageUrl = event?.images.first {
            if imageNot.url == eventImageUrl  {
                DispatchQueue.main.async {
                    self.eventImageView.image = imageNot.image
                }
            } else if let profileImage = event?.profileImageURL, profileImage == imageNot.url {
                DispatchQueue.main.async {
                    self.hostImageView.image = imageNot.image
                }
            }
        }
    }
    
    func observeImage() {
        NotificationCenter.default.addObserver(self, selector: #selector(receiveImage), name: .imageWasLoaded, object: nil)
    }
    
    // MARK: - IBActions
    @IBAction func followHost(_ sender: UIButton) {
        
    }
    
    @IBAction func attendEvent(_ sender: UIButton) {
        guard let eventController = eventController, let event = event else { return }
        eventController.rsvpToEvent(with: event.id) { bool, error in
            if let error = error {
                var presentLogin = false
                switch error {
                case .ql(let errors):
                    for qlrr in errors {
                        if let errorMessage = qlrr.message, errorMessage.contains("No token was found in header") {
                            presentLogin = true
                        }
                    }
                case .rr(let singleError):
                    NSLog("\(#file):L\(#line): Configuration failed inside \(#function) with error: \(singleError)")
                }
                if presentLogin {
                    self.loginAlert(with: "rsvp to an event")
                }
            }
            guard let bool = bool else {
                // TODO: Handle error
                return
            }
            DispatchQueue.main.async {
                self.attendButton.attrText(bool ? "Unattend" : "Attend")
                bool ? (self.addToCalendarButton.isHidden = false) : (self.addToCalendarButton.isHidden = true)
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

//
//  EventDetailViewController.swift
//  Community Calendar
//
//  Created by Jordan Christensen on 1/11/20.
//  Copyright © 2020 Lambda School All rights reserved.
//

import UIKit
import EventKit
import EMTNeumorphicView

class EventDetailViewController: UIViewController, UIScrollViewDelegate {
    
    // MARK: - Properties
    
    var event: Event? {
        didSet {
            updateViews()
        }
    }
    
    var apolloController: ApolloController? {
        didSet {
            print("Detail View Controller: \(String(describing: apolloController))")
        }
    }
    
    var userEvents: [Event]? {
        didSet {
            print("DetailVC User Events Array Count: \(String(describing: self.userEvents?.count))")
            
        }
    }

    var indexPath: IndexPath?
    let eventStore = EKEventStore()
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var eventImageView: UIImageView!
    @IBOutlet weak var attendButton: EMTNeumorphicButton!
    @IBOutlet weak var openInMapsButton: EMTNeumorphicButton!
    @IBOutlet weak var addToCalendarButton: EMTNeumorphicButton!
    @IBOutlet weak var hostImageView: UIImageView!
    @IBOutlet weak var hostShadowView: UIView!
    @IBOutlet weak var hostNameLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel! // Three lines
    @IBOutlet weak var priceLabel: UILabel! // Red if free
    @IBOutlet weak var eventDescTextView: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var descLabelHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var favoriteButton: EMTNeumorphicButton!
    @IBOutlet weak var favoriteButtonView: UIView!
    @IBOutlet weak var ticketView: UIView!
    @IBOutlet weak var checkmarkImageView: UIImageView!
    
    // MARK: - Lifecycle Functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        observeImage()
        setUp()
        configureButtons()
        updateUserEventViews()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
//        checkForRSVP()
        updateUserEventViews()
    }
    
    // MARK: - Functions
    private func setUp() {
        scrollView.delegate = self
        setupSubviews()
        configureViews()
    }
    
    func setupSubviews() {
        checkmarkImageView.anchor(top: nil, leading: attendButton.centerXAnchor, trailing: nil, bottom: nil, centerX: nil, centerY: attendButton.centerYAnchor, padding: .init(top: 0, left: 25, bottom: 0, right: 0), size: .init(width: attendButton.bounds.height - 8, height: attendButton.bounds.height - 8))
        
        checkmarkImageView.contentMode = .scaleAspectFit
        checkmarkImageView.isHidden = true
        checkmarkImageView.image = UIImage(named: "checkmark")
    }
    
    func configureViews() {
        self.hostImageView.layer.cornerRadius = self.hostImageView.frame.height / 2
        self.hostShadowView.layer.cornerRadius = self.hostShadowView.frame.height / 2
        self.hostShadowView.layer.shadowColor = UIColor.darkGray.cgColor
        self.hostShadowView.layer.shadowOpacity = 1.0
        self.hostShadowView.layer.shadowRadius = 1.5
        self.hostShadowView.layer.shadowOffset = CGSize(width: -1, height: 1)
        self.attendButton.layer.cornerRadius = 6
        self.attendButton.layer.borderWidth = 1
        self.attendButton.layer.borderColor = UIColor(red: 1, green: 0.404, blue: 0.408, alpha: 1).cgColor
        self.openInMapsButton.setTitleColor(.white, for: .normal)
        self.openInMapsButton.backgroundColor = UIColor(red: 0.129, green: 0.141, blue: 0.173, alpha: 1)
        self.openInMapsButton.layer.cornerRadius = 6
        
        self.addToCalendarButton.setTitleColor(.white, for: .normal)
        self.addToCalendarButton.backgroundColor = UIColor(red: 1, green: 0.404, blue: 0.408, alpha: 1)
        self.addToCalendarButton.layer.cornerRadius = 6
        titleLabel.font = UIFont(name: PoppinsFont.medium.rawValue, size: 20)
        eventDescTextView.textColor = .black
        timeLabel.textColor = .black
    }
    
    func configureButtons() {
        favoriteButton.setImage(UIImage(named: "coral-heart-outline"), for: .normal)
        favoriteButton.setImage(UIImage(named: "coral-heart"), for: .selected)
        favoriteButton.contentVerticalAlignment = .fill
        favoriteButton.contentHorizontalAlignment = .fill
        favoriteButton.imageEdgeInsets = UIEdgeInsets(top: 12, left: 12, bottom: 12, right: 12)
        favoriteButton.layer.cornerRadius = 12

        favoriteButton.neumorphicLayer?.edged = true
        favoriteButton.neumorphicLayer?.elementColor = UIColor.white.cgColor
        favoriteButton.neumorphicLayer?.elementBackgroundColor = UIColor.white.cgColor
        favoriteButton.neumorphicLayer?.depthType = .convex
        favoriteButton.neumorphicLayer?.elementDepth = 10
        favoriteButton.neumorphicLayer?.darkShadowOpacity = 1.0
        favoriteButton.neumorphicLayer?.lightShadowOpacity = 0.2

        
        favoriteButton.backgroundColor = .white
        favoriteButtonView.layer.cornerRadius = 20
        ticketView.layer.cornerRadius = 20
        favoriteButtonView.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        ticketView.layer.maskedCorners = [.layerMaxXMinYCorner]
        
        attendButton.contentVerticalAlignment = .fill
        attendButton.contentHorizontalAlignment = .fill
        attendButton.imageEdgeInsets = UIEdgeInsets(top: 14, left: 12, bottom: 10, right: 12)
        attendButton.layer.cornerRadius = 12
        attendButton.setTitle("Attend", for: .normal)

        attendButton.neumorphicLayer?.edged = false
        attendButton.neumorphicLayer?.elementColor = UIColor.white.cgColor
        attendButton.neumorphicLayer?.elementBackgroundColor = UIColor.white.cgColor
        attendButton.neumorphicLayer?.depthType = .convex
        attendButton.neumorphicLayer?.elementDepth = 4
        attendButton.neumorphicLayer?.darkShadowOpacity = 1.0
        attendButton.neumorphicLayer?.lightShadowOpacity = 0.2
        attendButton.layer.borderColor = UIColor.white.cgColor
        attendButton.titleLabel?.textAlignment = .center
        attendButton.setTitle("Attend", for: .normal)
        
        attendButton.backgroundColor = .white
        
        openInMapsButton.contentVerticalAlignment = .fill
        openInMapsButton.contentHorizontalAlignment = .fill
        openInMapsButton.imageEdgeInsets = UIEdgeInsets(top: 14, left: 12, bottom: 10, right: 12)
        openInMapsButton.layer.cornerRadius = 12

        

        openInMapsButton.neumorphicLayer?.edged = false
        openInMapsButton.neumorphicLayer?.elementColor = #colorLiteral(red: 1, green: 0.3987820148, blue: 0.4111615121, alpha: 1)
        openInMapsButton.neumorphicLayer?.elementBackgroundColor = UIColor.lightGray.cgColor
        openInMapsButton.neumorphicLayer?.depthType = .convex
        openInMapsButton.neumorphicLayer?.elementDepth = 4
        openInMapsButton.neumorphicLayer?.darkShadowOpacity = 1.0
        openInMapsButton.neumorphicLayer?.lightShadowOpacity = 0.2
        openInMapsButton.titleLabel?.textAlignment = .center
        openInMapsButton.setTitle("Open in Maps", for: .normal)
       
        addToCalendarButton.contentVerticalAlignment = .fill
        addToCalendarButton.contentHorizontalAlignment = .fill
        addToCalendarButton.imageEdgeInsets = UIEdgeInsets(top: 14, left: 12, bottom: 10, right: 12)
        addToCalendarButton.layer.cornerRadius = 12
        
        
        addToCalendarButton.neumorphicLayer?.edged = false
        addToCalendarButton.neumorphicLayer?.elementColor = #colorLiteral(red: 0.1799933612, green: 0.1916823089, blue: 0.2126363814, alpha: 1)
        addToCalendarButton.neumorphicLayer?.elementBackgroundColor = UIColor.white.cgColor
        addToCalendarButton.neumorphicLayer?.depthType = .convex
        addToCalendarButton.neumorphicLayer?.elementDepth = 4
        addToCalendarButton.neumorphicLayer?.darkShadowOpacity = 1.0
        addToCalendarButton.neumorphicLayer?.lightShadowOpacity = 0.2
        addToCalendarButton.titleLabel?.textAlignment = .center
        
    }
    
    
    func updateViews() {
        guard
            let event = event,
            let urlString = event.image,
            let url = URL(string: urlString),
            let data = try? Data(contentsOf: url),
            let streetAddress = event.location?.streetAddress,
            let city = event.location?.city,
            let state = event.location?.state,
            let zipcode = event.location?.zipcode
            else { return }
        
        let startDate = event.startDate
        let endDate = event.endDate
        DispatchQueue.main.async {
            if let urlCreatorString = event.creator.profileImage, let urlCreator = URL(string: urlCreatorString), let imageData = try? Data(contentsOf: urlCreator) {
                self.hostImageView.image = UIImage(data: imageData)
            }
            if let hostFirstName = event.creator.firstName, let hostLastName = event.creator.lastName {
                self.hostNameLabel.text = "\(hostFirstName) \(hostLastName)"
            } else {
                self.hostNameLabel.text = "N/A"
            }
            self.eventImageView.image = UIImage(data: data)
            self.dateLabel.text = featuredEventDateFormatter.string(from: startDate)
            self.titleLabel.text = event.title
            self.eventDescTextView.text = event.description
            self.priceLabel.attributedText = event.ticketPrice == 0.0 ? (NSAttributedString(string: "Free", attributes: [NSAttributedString.Key.foregroundColor : UIColor(red: 1, green: 0.404, blue: 0.408, alpha: 1)])) : (NSAttributedString(string: "$\(event.ticketPrice)", attributes: [NSAttributedString.Key.foregroundColor : UIColor.black]))
            self.timeLabel.text = "\(cellDateFormatter.string(from: startDate)) \n to \n \(cellDateFormatter.string(from: endDate))"
            
            self.addressLabel.text = "\(streetAddress) \(city), \(state) \(zipcode)"
            
            let height = event.description.height(with: self.view.frame.width - 32, font: UIFont(name: PoppinsFont.light.rawValue, size: 12)!)
            height < 100 ? (self.descLabelHeightConstraint.constant = height) : (self.descLabelHeightConstraint.constant = 100.0)
            
        }
    }
    
    func updateUserEventViews() {
        guard
            let event = self.event,
            let apolloController = self.apolloController
            else { return }
        
        let filteredUserEvents = apolloController.userEvents.filter({ $0.id == event.id })
        
        if filteredUserEvents.count > 0 {
            for event in filteredUserEvents {
                if event.eventType == .attending {
                    self.attendButton.isSelected = true
                    self.checkmarkImageView.isHidden = false
                } else if event.eventType == .saved {
                    self.favoriteButton.isSelected = true
                }
            }
        }
        if attendButton.isSelected {
            checkmarkImageView.isHidden = false
        } else {
            checkmarkImageView.isHidden = true
        }
    }
 
    func updateRSVP(with bool: Bool) {
        DispatchQueue.main.async {
            self.attendButton.attrText(bool ? "Unattend" : "Attend")
            bool ? (self.addToCalendarButton.isHidden = false) : (self.addToCalendarButton.isHidden = true)
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
            if let tabVC = self.presentingViewController as? EventTabBarController {
                tabVC.selectedIndex = (tabVC.viewControllers?.count ?? 1) - 1
            }
            alert.dismiss(animated: true, completion: nil)
            self.dismiss(animated: true)
        }
        alert.addAction(cancel)
        alert.addAction(login)
        self.present(alert, animated: true)
    }
    
    // MARK: - IBActions
    @IBAction func favoriteButtonTapped(_ sender: Any) {
        favoriteButton.isSelected.toggle()
        guard let event = event else { return }
        
        if apolloController?.currentUser != nil {
            apolloController?.saveEvent(eventID: event.id, completion: { result in
                if let bool = try? result.get() {
                    if bool == false {
                        self.apolloController?.userEvents.removeAll(where: { $0.id == self.event?.id && event.eventType == .saved })
                    } else {
                        let newEvent = Event(id: event.id, title: event.title, description: event.description, start: event.start, end: event.end, ticketPrice: event.ticketPrice, location: event.location, image: event.image, creator: event.creator, eventType: .saved)
                        self.apolloController?.userEvents.append(newEvent)
                    }
                }
            })
        }
    }
    
    @IBAction func attendEvent(_ sender: UIButton) {
        attendButton.isSelected.toggle()
        if attendButton.isSelected {
            checkmarkImageView.isHidden = false
        } else {
            checkmarkImageView.isHidden = true
        }
        guard
            let event = event,
            let apolloController = apolloController
            else { return }
        
        if apolloController.currentUser != nil {
            apolloController.attendEvent(eventID: event.id, completion: { result in
                if let bool = try? result.get() {
                    if bool == false {
                        self.apolloController?.userEvents.removeAll(where: { $0.id == self.event?.id && event.eventType == .attending })
                    } else {
                        let newEvent = Event(id: event.id, title: event.title, description: event.description, start: event.start, end: event.end, ticketPrice: event.ticketPrice, location: event.location, image: event.image, creator: event.creator, eventType: .attending)
                        self.apolloController?.userEvents.append(newEvent)
                    }
                }
            })
        }
        
//        if attendButton.isSelected {
//            checkmarkImageView.isHidden = false
//            checkmarkImageView.springIn()
//            if apolloController.currentUser != nil {
//                apolloController.attendEvent(eventID: event.id, completion: { result in
//                    if let bool = try? result.get() {
//                        print(bool)
//                        let newEvent = Event(id: event.id, title: event.title, description: event.description, start: event.start, end: event.end, ticketPrice: event.ticketPrice, location: event.location, image: event.image, creator: event.creator, eventType: .attending)
//                        apolloController.userEvents.append(newEvent)
//                    }
//                })
//            } else {
//                self.presentUserInfoAlert(title: "Error!", message: "Please Login to RSVP to Events.")
//                attendButton.isSelected = false
//                checkmarkImageView.isHidden = true
//            }
//
//            attendButton.setTitleColor(UIColor.black, for: .normal)
//            attendButton.neumorphicLayer?.elementBackgroundColor = UIColor.white.cgColor
//            attendButton.neumorphicLayer?.lightShadowOpacity = 0.3
//        } else {
//            if apolloController.currentUser != nil {
//                apolloController.attendEvent(eventID: event.id, completion: { result in
//                    if let bool = try? result.get() {
//                        print(bool)
//                        apolloController.userEvents.removeAll(where: { $0.id == self.event?.id && event.eventType == .attending })
//                    }
//                })
//            } else {
//                self.presentUserInfoAlert(title: "Error!", message: "Please Login to RSVP to Events")
//                attendButton.isSelected = false
//                checkmarkImageView.isHidden = true
//                attendButton.imageView?.image = nil
//            }
//            checkmarkImageView.isHidden = true
//            attendButton.imageView?.image = nil
//            attendButton.setTitleColor(UIColor.black, for: .normal)
//            attendButton.neumorphicLayer?.elementBackgroundColor = UIColor.white.cgColor
//            attendButton.neumorphicLayer?.elementColor = UIColor.white.cgColor
//            attendButton.neumorphicLayer?.elementDepth = 5
//            attendButton.neumorphicLayer?.lightShadowOpacity = 0.3
//        }
    }
    
    @IBAction func showMore(_ sender: UIButton) {
        let height = event?.description.height(with: view.frame.width - 32, font: UIFont(name: PoppinsFont.light.rawValue, size: 12)!)
        if descLabelHeightConstraint.constant != height {
            descLabelHeightConstraint.constant = (height ?? 10) + 3
        }
        sender.isHidden = true
    }
    
    
    @IBAction func showInMaps(_ sender: UIButton) {
        
        if let event = event, let address = event.location?.streetAddress, let zip = event.location?.zipcode {
            let baseURL = URL(string: "http://maps.apple.com/")!
            var components = URLComponents(url: baseURL, resolvingAgainstBaseURL: true)
            let addressQuery = URLQueryItem(name: "address", value: "\(address), \(zip)")
            components?.queryItems = [addressQuery]
            UIApplication.shared.open(components?.url ?? baseURL)
        } else if event?.location == nil {
            print("Event has no location listed!")
        }
    }
    
    @IBAction func showInCalendar(_ sender: Any) {
        addToCalendarButton.isSelected.toggle()
        eventStore.requestAccess(to: .event) { (granted, error) in
            if let error = error {
                NSLog("\(#file):L\(#line): Unable to request access to calendar in \(#function) with error: \(error)")
                return
            }

            if granted {
            
                guard let event = self.event, let startDate = self.event?.startDate, let endDate = self.event?.endDate else {
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

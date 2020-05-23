//
//  EventViewController.swift
//  Community Calendar
//
//  Created by Jordan Christensen on 2/5/20.
//  Copyright © 2020 Lambda School All rights reserved.
//

import UIKit
import OktaOidc
import JTAppleCalendar

enum MyTheme {
      case light
      case dark
  }

class EventViewController: UIViewController, ControllerDelegate {
 
    //MARK: - Properties
    var user: FetchUserIdQuery.Data.User? {
        didSet {
            print("Event View Controller User: \(String(describing: user))")
        }
    }
    
    var oktaUserInfo: [String]? {
        didSet {
            print("Event View Controller Okta ID: \(String(describing: oktaUserInfo?.first)), Okta Email: \(String(describing: oktaUserInfo?.last))")
        }
    }
    
    var authController: AuthController? {
        didSet {
            print("Event View Controller Auth Controller: \(String(describing: authController))")
        }
    }
    var apolloController: ApolloController? {
        didSet {
            print("Event View Controller Apollo Controller: \(String(describing: apolloController))")
        }
    }
 
    var userEvents: UserEvents? {
        didSet {
            self.myEventsCollectionView.reloadData()
            self.calendarView.reloadData()
        }
    }
    
    var events: [Event] = [] {
        didSet {
            self.sortEvents()
        }
    }
    var filteredEvents: [Event] = [] {
        didSet {
//            self.myEventsCollectionView.reloadData()
        }
    }
    
    var currentUser: User? {
        didSet {
            guard
                let user = currentUser,
                let events = user.userEvents
                else { return }
                
            for event in events {
                self.events.append(event)
            }
        }
    }
    
    var dateSelected: Date? {
        didSet {
            dateTapped(_: self)
        }
    }
    
    var createdEvents: [Event]? {
        didSet {
            self.populateDataSource()
        }
    }
    var attendingEvents: [Event]? {
        didSet {
            self.populateDataSource()
        }
    }
    
    var savedEvents: [Event]? {
        didSet {
            self.populateDataSource()
        }
    }
    
    var createdCalDataSource: [String : String] = [:]
    var savedCalDataSource: [String : String] = [:]
    var attendingCalDataSource: [String : String] = [:]
    var detailEvent: FetchUserIdQuery.Data.User.CreatedEvent? {
        didSet {
            self.calendarView.reloadData()
        }
    }
    
    //MARK: - IBOutlets
    
    @IBOutlet weak var calendarView: JTACMonthView!
    @IBOutlet weak var myEventsCollectionView: UICollectionView!
    @IBOutlet weak var attendingButton: UIButton!
    @IBOutlet weak var savedButton: UIButton!
    @IBOutlet weak var createdButton: UIButton!
    @IBOutlet weak var filterView: UIView!
    @IBOutlet weak var filterButtonStackView: UIStackView!
    @IBOutlet weak var calendarBackgroundView: UIView!
    @IBOutlet weak var attendingEventsIndicator: UIView!
    @IBOutlet weak var savedEventsIndicator: UIView!
    @IBOutlet weak var createdEventsIndicator: UIView!
    @IBOutlet weak var noEventsLabel: UILabel!
    
    
    //MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupSubViews()
        guard let tabBar = tabBarController as? EventTabBarController else { return }
        authController = tabBar.authController
        apolloController = tabBar.apolloController
//        if tabBar.authController.accessToken != nil {
//            getUsersEvents { _ in
//                self.createdButtonTapped(UIButton())
//                self.myEventsCollectionView.reloadData()
//                self.calendarView.scrollToDate(Date())
//            }
//        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        guard let tabBar = tabBarController as? EventTabBarController else { return }
        
        if tabBar.authController.isUserLoggedIn == false {
            self.userEvents = nil
            self.filteredEvents.removeAll()
            self.myEventsCollectionView.reloadData()
            self.calendarView.scrollToDate(Date())
        } else {
            if let accesstoken = tabBar.authController.accessToken, let oktaID = tabBar.apolloController.defaults.string(forKey: UserDefaults.Keys.oktaID.rawValue) {
                tabBar.apolloController.apollo = tabBar.apolloController.configureApolloClient(accessToken: accesstoken)
                getUsersEvents(oktaID: oktaID) { _ in
                    
                    self.myEventsCollectionView.reloadData()
                    self.calendarView.scrollToDate(Date())
                }
            }
//            createdButtonTapped(UIButton())
//            myEventsCollectionView.reloadData()
        }
        
//        if let tabBar = tabBarController as? EventTabBarController, let accessToken = tabBar.authController.stateManager?.accessToken {
//            if tabBar.authController.accessToken != nil {
//                tabBar.apolloController.apollo = tabBar.apolloController.configureApolloClient(accessToken: accessToken)
//
//            }
//        }
    }
//        if user == nil {
//            if let accessToken = authController?.accessToken {
//                authController?.getUser(completion: { result in
//                                    })
//            }
//        }
//    }
    
    @objc func dateTapped(_ sender: Any) {
        attendingButton.setAttributedTitle(createAttrText(with: "Attending", color: .unselectedDayButton, fontName: PoppinsFont.light.rawValue), for: .normal)
        savedButton.setAttributedTitle(createAttrText(with: "Saved", color: .unselectedDayButton, fontName: PoppinsFont.light.rawValue), for: .normal)
        createdButton.setAttributedTitle(createAttrText(with: "Created", color: .unselectedDayButton, fontName: PoppinsFont.light.rawValue), for: .normal)
        if let date = self.dateSelected {
            let range = Apollo.shared.selectedDate(date: date)
            filteredEvents = []
            if let start = range.first, let end = range.last {
                let selectedEvents = events.filter({ ($0.startDate?.isBetween(start, and: end))!})
                removeDuplicates(array: selectedEvents) { reducedEvents in
                    self.filteredEvents = reducedEvents
                    if self.filteredEvents.count < 1 {
                        let prettyDate = featuredEventDateFormatter.string(from: date)
                        self.noEventsLabel.text = "You have no events on \(prettyDate)."
                        self.noEventsLabel.isHidden = false
                    } else {
                        self.noEventsLabel.isHidden = true
                    }
                    
                    self.myEventsCollectionView.reloadData()
                }
                
            }
        }
        attendingEventsIndicator.alpha = 0.5
        savedEventsIndicator.alpha = 0.5
        createdEventsIndicator.alpha = 0.5
        
    }
    
    @objc func attendingButtonTapped2(_ sender: Any) {
        noEventsLabel.isHidden = true
        attendingButton.setAttributedTitle(createAttrText(with: "Attending", color: .selectedButton, fontName: PoppinsFont.semiBold.rawValue), for: .normal)
        savedButton.setAttributedTitle(createAttrText(with: "Saved", color: .unselectedDayButton, fontName: PoppinsFont.light.rawValue), for: .normal)
        createdButton.setAttributedTitle(createAttrText(with: "Created", color: .unselectedDayButton, fontName: PoppinsFont.light.rawValue), for: .normal)
        userEvents = .attending
        filteredEvents = events.filter({ $0.eventType == .attending })
        attendingEventsIndicator.alpha = 1
        savedEventsIndicator.alpha = 0.5
        createdEventsIndicator.alpha = 0.5
        myEventsCollectionView.reloadData()
    }
    
    @objc func savedButtonTapped2(_ sender: Any) {
        noEventsLabel.isHidden = true
        attendingButton.setAttributedTitle(createAttrText(with: "Attending", color: .unselectedDayButton, fontName: PoppinsFont.light.rawValue), for: .normal)
        savedButton.setAttributedTitle(createAttrText(with: "Saved", color: .selectedButton, fontName: PoppinsFont.semiBold.rawValue), for: .normal)
        createdButton.setAttributedTitle(createAttrText(with: "Created", color: .unselectedDayButton, fontName: PoppinsFont.light.rawValue), for: .normal)
        userEvents = .saved
        filteredEvents = events.filter({ $0.eventType == .saved })
        attendingEventsIndicator.alpha = 0.5
        savedEventsIndicator.alpha = 1
        createdEventsIndicator.alpha = 0.5
        myEventsCollectionView.reloadData()
    }
    
    @objc func createdButtonTapped2(_ sender: Any) {
        noEventsLabel.isHidden = true
        attendingButton.setAttributedTitle(createAttrText(with: "Attending", color: .unselectedDayButton, fontName: PoppinsFont.light.rawValue), for: .normal)
        savedButton.setAttributedTitle(createAttrText(with: "Saved", color: .unselectedDayButton, fontName: PoppinsFont.light.rawValue), for: .normal)
        createdButton.setAttributedTitle(createAttrText(with: "Created", color: .selectedButton, fontName: PoppinsFont.semiBold.rawValue), for: .normal)
        userEvents = .created
        filteredEvents = events.filter({ $0.eventType == .created })
        attendingEventsIndicator.alpha = 0.5
        savedEventsIndicator.alpha = 0.5
        createdEventsIndicator.alpha = 1
        myEventsCollectionView.reloadData()
        
    }
    
    func removeDuplicates(array: [Event], completion: @escaping ([Event]) -> Void)  {
        var set = Set<Event>()
        var result: [Event] = []
        for event in array {
            if set.contains(event) {
                
            } else {
                set.insert(event)
                result.append(event)
            }
        }
        completion(result)
    }
    
    // MARK: - IBActions
    
    @IBAction func attendingButtonTapped(_ sender: Any) {
        attendingButton.setAttributedTitle(createAttrText(with: "Attending", color: .selectedButton, fontName: PoppinsFont.semiBold.rawValue), for: .normal)
        savedButton.setAttributedTitle(createAttrText(with: "Saved", color: .unselectedDayButton, fontName: PoppinsFont.light.rawValue), for: .normal)
        createdButton.setAttributedTitle(createAttrText(with: "Created", color: .unselectedDayButton, fontName: PoppinsFont.light.rawValue), for: .normal)
        userEvents = .attending
        filteredEvents = events.filter({ $0.eventType == .attending })
        attendingEventsIndicator.alpha = 1
        savedEventsIndicator.alpha = 0.5
        createdEventsIndicator.alpha = 0.5
        myEventsCollectionView.reloadData()
        noEventsLabel.isHidden = true
    }
    
    @IBAction func savedButtonTapped(_ sender: Any) {
        attendingButton.setAttributedTitle(createAttrText(with: "Attending", color: .unselectedDayButton, fontName: PoppinsFont.light.rawValue), for: .normal)
        savedButton.setAttributedTitle(createAttrText(with: "Saved", color: .selectedButton, fontName: PoppinsFont.semiBold.rawValue), for: .normal)
        createdButton.setAttributedTitle(createAttrText(with: "Created", color: .unselectedDayButton, fontName: PoppinsFont.light.rawValue), for: .normal)
        userEvents = .saved
        filteredEvents = events.filter({ $0.eventType == .saved })
        attendingEventsIndicator.alpha = 0.5
        savedEventsIndicator.alpha = 1
        createdEventsIndicator.alpha = 0.5
        myEventsCollectionView.reloadData()
        noEventsLabel.isHidden = true
    }
    
    @IBAction func createdButtonTapped(_ sender: Any) {
        attendingButton.setAttributedTitle(createAttrText(with: "Attending", color: .unselectedDayButton, fontName: PoppinsFont.light.rawValue), for: .normal)
        savedButton.setAttributedTitle(createAttrText(with: "Saved", color: .unselectedDayButton, fontName: PoppinsFont.light.rawValue), for: .normal)
        createdButton.setAttributedTitle(createAttrText(with: "Created", color: .selectedButton, fontName: PoppinsFont.semiBold.rawValue), for: .normal)
        userEvents = .created
        filteredEvents = events.filter({ $0.eventType == .created })
        attendingEventsIndicator.alpha = 0.5
        savedEventsIndicator.alpha = 0.5
        createdEventsIndicator.alpha = 1
        myEventsCollectionView.reloadData()
        noEventsLabel.isHidden = true
    }
    
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        if scrollView == myEventsCollectionView {

            scrollView.decelerationRate = .fast
            scrollView.bouncesZoom = true
        }
    }
    
    func setupSubViews() {
        myEventsCollectionView.dataSource = self
        myEventsCollectionView.delegate = self
        calendarView.layer.borderColor = #colorLiteral(red: 0.1722870469, green: 0.1891334951, blue: 0.2275838256, alpha: 1)
        calendarView.backgroundColor = .white
        calendarView.layer.borderWidth = 1.0
        calendarView.layer.cornerRadius = 12
        calendarBackgroundView.layer.cornerRadius = 12
        calendarBackgroundView.contactShadow()
        calendarView.scrollingMode = .stopAtEachCalendarFrame
        calendarView.allowsRangedSelection = true 
        createdButtonTapped(UIButton())
        //        let dynamicMargin = detailAndCalendarCollectionView.bounds.height / 5
        filterView.translatesAutoresizingMaskIntoConstraints = false
        calendarView.translatesAutoresizingMaskIntoConstraints = false
        
        calendarView.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height / 2.3).isActive = true
        calendarView.scrollDirection = .horizontal
        calendarView.scrollingMode = .stopAtEachCalendarFrame
        calendarView.showsHorizontalScrollIndicator = false
        
        //        NSLayoutConstraint.activate([
        //            filterView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        //            filterView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -dynamicMargin),
        //            filterView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
        //            filterView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
        //            filterButtonStackView.centerXAnchor.constraint(equalTo: filterView.centerXAnchor),
        //            filterButtonStackView.centerYAnchor.constraint(equalTo: filterView.centerYAnchor),
        //            filterButtonStackView.topAnchor.constraint(equalTo: filterView.topAnchor, constant: 0),
        //            filterButtonStackView.bottomAnchor.constraint(equalTo: filterView.bottomAnchor, constant: 0)
        //        ])
        //
        //        detailAndCalendarCollectionView.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: view.leadingAnchor, trailing: view.trailingAnchor, bottom: filterView.topAnchor, centerX: nil, centerY: nil, padding: .init(top: 0, left: 0, bottom: 0, right: 0), size: .zero)
        //
        //        myEventsCollectionView.anchor(top: filterView.bottomAnchor, leading: view.leadingAnchor, trailing: view.trailingAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, centerX: nil, centerY: nil, padding: .init(top: 0, left: 0, bottom: 0, right: 0), size: .zero)
        
        
        //        if let flowLayout = calendarView.collectionViewLayout as? UICollectionViewFlowLayout {
        //            flowLayout.scrollDirection = .horizontal
        //            flowLayout.minimumLineSpacing = 0
        //            calendarView.isPagingEnabled = true
        //        }
    }
 
    func createAttrText(with title: String, color: UIColor, fontName: String) -> NSAttributedString {
        guard let font = UIFont(name: fontName, size: 14) else { return NSAttributedString() }
        let attrString = NSAttributedString(string: title,
                                            attributes: [NSAttributedString.Key.foregroundColor: color, NSAttributedString.Key.font: font])
        return attrString
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowDetailSegue" {
            guard
                let detailVC = segue.destination as? EventDetailViewController,
                let indexPath = myEventsCollectionView.indexPathsForSelectedItems?.first else { return }
            let event = filteredEvents[indexPath.item]
            if let passedEvent = events.first(where: { $0.id == event.id }) {
                detailVC.event = passedEvent
            }
        }
    }
}


    
    
    





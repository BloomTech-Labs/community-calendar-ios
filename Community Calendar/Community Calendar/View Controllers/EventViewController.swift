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

class EventViewController: UIViewController, ControllerDelegate {
 
    //MARK: - Properties
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

        }
    }
    
    var currentUser: User? {
        didSet {
            print("This is the current user: \(String(describing: currentUser?.firstName)) \(String(describing: currentUser?.lastName))")
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
    @IBOutlet var attendingGestureRecognizer: UITapGestureRecognizer!
    @IBOutlet var savedGestureRecognizer: UITapGestureRecognizer!
    @IBOutlet var createdGestureRecognizer: UITapGestureRecognizer!
    
    
    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let tabBar = tabBarController as? EventTabBarController else { return }
        apolloController = tabBar.apolloController
        authController = tabBar.authController
        setupSubViews()
        configureViews()
        self.calendarView.scrollToDate(Date())
        attendingButtonTapped(UIButton())
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        checkCurrentuser()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        guard let userEvents = self.apolloController?.userEvents else { return }
        self.events = userEvents
    }

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .darkContent
    }
    
    // MARK: - IBActions
    @IBAction func attendingViewTapped(_ sender: Any) {
        filterAttendingEvents()
    }
    
    @IBAction func attendingButtonTapped(_ sender: Any) {
        filterAttendingEvents()
    }
    @IBAction func savedViewTapped(_ sender: Any) {
        filterSavedEvents()
    }
    
    @IBAction func savedButtonTapped(_ sender: Any) {
        filterSavedEvents()
    }
    
    @IBAction func createdViewTapped(_ sender: Any) {
        filterCreatedEvents()
    }
    
    @IBAction func createdButtonTapped(_ sender: Any) {
        filterCreatedEvents()
    }
 
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowDetailSegue" {
            guard
                let detailVC = segue.destination as? EventDetailViewController,
                let indexPath = myEventsCollectionView.indexPathsForSelectedItems?.first else { return }
            let event = filteredEvents[indexPath.item]
            detailVC.event = event
            detailVC.apolloController = apolloController
//            if let passedEvent = events.first(where: { $0.id == event.id }) {
//                detailVC.event = passedEvent
//            }
        }
    }
}

//
//  HomeViewController.swift
//  Community Calendar
//
//  Created by Jordan Christensen on 12/16/19.
//  Copyright © 2019 Lambda School All rights reserved.
//
//  Dev Notes:
//  "If you can't fix it, it's a feature."

import UIKit
import OktaOidc

class HomeViewController: UIViewController, ControllerDelegate {
    
    // MARK: - Properties
    
    var user: FetchUserIdQuery.Data.User? {
        didSet {
            print("Home View Controller User: \(String(describing: user))")
        }
    }
    
    var oktaUserInfo: [String]? {
        didSet {
            print("Home View Controller Okta ID: \(String(describing: oktaUserInfo?.first)), Okta Email: \(String(describing: oktaUserInfo?.last))")
        }
    }
    
    var apolloController: ApolloController? {
        didSet {
            print("Home View Controller ApolloController: \(String(describing: apolloController))")
        }
    }
    var authController: AuthController? {
        didSet {
            print("Home View Controller AuthController: \(String(describing: authController))")
        }
    }
    var testing = false
    var repeatCount = 1
    var fetchEventsTimer: Timer?
    var shouldDismissFilterScreen = true
    var unfilteredEvents: [Event]? {        // Varible events' data source
        didSet {
            todayTapped(UIButton())
        }
    }
    var events: [FetchEventsQuery.Data.Event]? {
        didSet {
            guard isViewLoaded else { return }
            self.featuredCollectionView.reloadData()
            self.eventCollectionView.reloadData()
            self.eventTableView.reloadData()
        }
    }
    
    var currentFilter: Filter? {
        didSet {
            updateFilterCount()
        }
    }
    
    // MARK: - Lists IBOutles
    @IBOutlet weak var featuredCollectionView: UICollectionView!
    @IBOutlet weak var eventCollectionView: UICollectionView!
    @IBOutlet weak var eventTableView: UITableView!
    
    @IBOutlet weak var collectionViewButton: UIButton!
    @IBOutlet weak var tableViewButton: UIButton!
    @IBOutlet weak var seperatorView: UIView!
    @IBOutlet weak var dateLabel: UILabel!
    
    @IBOutlet private weak var noResultsLabel: UILabel!
    
    // MARK: - Filter Buttons IBOutles
    @IBOutlet weak var thisWeekendButton: UIButton!
    @IBOutlet weak var allUpcomingButton: UIButton!
    @IBOutlet weak var tomorrowButton: UIButton!
    @IBOutlet weak var todayButton: UIButton!
    @IBOutlet weak var seeAllButton: UIButton!
    
    // MARK: - Search IBOutles
    @IBOutlet weak var eventSearchBar: UISearchBar!
    @IBOutlet weak var searchView: SearchView!
    @IBOutlet weak var searchBarCancelButton: UIButton!
    @IBOutlet weak var searchBarTrailingConstraint: NSLayoutConstraint!
    
    // MARK: - Lifecycle Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        searchView.homeVC = self
        searchView.setUp()
        setUp()
        
        self.featuredCollectionView.reloadData()
        self.eventCollectionView.reloadData()
        self.eventTableView.reloadData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        apolloController?.fetchEvents(completion: { result in
            self.featuredCollectionView.reloadData()
            self.eventCollectionView.reloadData()
            self.eventTableView.reloadData()
        })
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if testing {
//            unfilteredEvents = testData
        } else {
            setUpTimer()
        }
        noResultsLabel.isHidden = true
    }
    
    // MARK: - View Functions
    private func setUp() { // Things that only need to be set once
        eventTableView.delegate = self
        eventTableView.dataSource = self
        eventTableView.showsVerticalScrollIndicator = false
        
        eventCollectionView.delegate = self
        eventCollectionView.dataSource = self
        eventCollectionView.showsVerticalScrollIndicator = false
        
        featuredCollectionView.delegate = self
        featuredCollectionView.dataSource = self
        featuredCollectionView.showsHorizontalScrollIndicator = false
        
        tableViewButtonTapped(UIButton())
        todayTapped(UIButton())
        
        
        eventSearchBar.delegate = self
        self.navigationController?.delegate = self
        shouldShowSearchView(false, shouldAnimate: false)               // Hide searchview on launch
        
        
        todayButton.titleLabel?.adjustsFontSizeToFitWidth = true
        tomorrowButton.titleLabel?.adjustsFontSizeToFitWidth = true
        thisWeekendButton.titleLabel?.adjustsFontSizeToFitWidth = true
        allUpcomingButton.titleLabel?.adjustsFontSizeToFitWidth = true
        
        updateViews()
        
        Timer.scheduledTimer(withTimeInterval: 600.0, repeats: true) { timer in
            self.setUpTimer()                                           // Timer that checks for new event updates every 10 mins
        }
    }
    
    private func updateViews() {
        setUpSearchBar()
        searchView.layoutSubviews()
        
        seperatorView.layer.cornerRadius = 3
        
        dateLabel.text = todayDateFormatter.string(from: Date())
        eventTableView.separatorColor = .clear
        
        
        guard let poppinsFont = UIFont(name: PoppinsFont.regular.rawValue, size: 10) else { return }
        self.tabBarController?.tabBar.tintColor = .tabBarTint
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.font: poppinsFont], for: .normal)
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.font: poppinsFont], for: .selected)
    }
    
    private func setUpSearchBar() {
        eventSearchBar.backgroundColor = .white
        eventSearchBar.setBackgroundImage(UIImage(), for: .any, barMetrics: .default)
        eventSearchBar.setImage(UIImage(), for: .search, state: .normal)
        eventSearchBar.isTranslucent = true
        eventSearchBar.searchTextField.backgroundColor = .clear
        eventSearchBar.layer.cornerRadius = 6
        eventSearchBar.layer.shadowColor = UIColor.lightGray.cgColor
        eventSearchBar.layer.shadowOpacity = 1.0
        eventSearchBar.layer.shadowRadius = 2
        eventSearchBar.layer.shadowOffset = CGSize(width: 0, height: 0)
        eventSearchBar.searchTextField.placeholder = ""
        
        if let font = UIFont(name: PoppinsFont.medium.rawValue, size: 14.0) {
            eventSearchBar.searchTextField.attributedPlaceholder = NSAttributedString(string: "Search", attributes: [
                NSAttributedString.Key.font: font,
                NSAttributedString.Key.foregroundColor: UIColor.lightGray
            ])
            eventSearchBar.searchTextField.font = font
        } else {
            eventSearchBar.searchTextField.placeholder = "Search"
        }
    }
    
    // MARK: - Data Functions
    
    private func fixDates(_ eventsList: [Event]) -> [Event] {
        var events = eventsList
        for (index, event) in events.enumerated() {
            if let startDate = event.startDate {
                events[index].startDate = backendDateFormatter.date(from: backendDateFormatter.string(from: startDate))
            }
            if let endDate = event.endDate {
                events[index].endDate = backendDateFormatter.date(from: backendDateFormatter.string(from: endDate))
            }
        }
        return events
    }
    
    @objc
    private func setUpTimer() {
        fetchEventsTimer = Timer.scheduledTimer(withTimeInterval: 5.0, repeats: true) { timer in
            if self.repeatCount >= 4 {
                timer.invalidate()
                self.fetchEventsTimer = nil
                self.repeatCount = 1
                if self.unfilteredEvents == nil || self.unfilteredEvents?.isEmpty ?? true {
                    NSLog("Unable to fetch events, all attemps failed. Is device connected to internet?")
                    let alert = UIAlertController(title: "Unable to get events", message: "Please make sure your device is connect to wifi or cellular data.", preferredStyle: .alert)
                    DispatchQueue.main.async { self.present(alert, animated: true) }
                    Timer.scheduledTimer(withTimeInterval: 2.5, repeats: false) { _ in
                        alert.dismiss(animated: true, completion: nil)
                    }
                } else {
                    NSLog("Timer is nil, but selector was called. Possible concurrency issue")
                }
            } else {
                print("Timer #\(self.repeatCount) ended")
                self.repeatCount += 1
            }
        }
    }
    
    private func createMockData(eventList: [Event]) { // For testing without wifi
        print("let testData = [")
        for event in eventList {
            var addComma = ","
            if event == eventList.last! {
                addComma = ""
            }
            print("Event(title: \"\(event.title)\", description: \"\(event.description)\", startDate: backendDateFormatter.date(from: \"\(backendDateFormatter.string(from: event.startDate ?? Date()))\") ?? Date(), endDate: backendDateFormatter.date(from: \"\(backendDateFormatter.string(from: event.endDate ?? Date()))\") ?? Date(), creator: \"\(event.creator)\", urls: \(event.urls), images: \(event.images), rsvps: \(event.rsvps), locations: \(event.locations), tags: \(event.tags), ticketPrice: \(event.ticketPrice))\(addComma)")
        }
        print("]")
    }
    
    // MARK: - Search/Filter Functions
    func shouldShowSearchView(_ bool: Bool, shouldAnimate: Bool = true) {
        searchView.shouldShowSearchView(bool, shouldAnimate: shouldAnimate)
    }
    
    func updateFilterCount() {
        searchView.updateFilterCount(filter: currentFilter)
    }
    
    // MARK: - Helper Functions
    func printFonts() {
        // To test if fonts were added correctly: (Common mistakes: Incorrect/no target membership, not listed in info.plist)
        for fam in UIFont.familyNames {
            print("Family: \(fam)")
            for fontName in UIFont.fontNames(forFamilyName: fam) {
                print("Name: \(fontName)")
                // If font is here ^, you can use it in storyboard or code, if not, there is an issue
            }
        }
    }
    
    func createAttrText(with title: String, color: UIColor, fontName: String) -> NSAttributedString {
        guard let font = UIFont(name: fontName, size: 14) else { return NSAttributedString() }
        let attrString = NSAttributedString(string: title,
            attributes: [NSAttributedString.Key.foregroundColor: color, NSAttributedString.Key.font: font])
        return attrString
    }
    
    // MARK: - IBActions
    @IBAction func tableViewButtonTapped(_ sender: UIButton) {
        eventCollectionView.isHidden = true
        eventTableView.isHidden = false
        eventTableView.reloadData()
        tableViewButton.imageView?.image = UIImage(named: "list-selected")
        collectionViewButton.imageView?.image = UIImage(named: "grid")
    }
    
    @IBAction func collectionViewButtonTapped(_ sender: UIButton) {
        eventCollectionView.isHidden = false
        eventTableView.isHidden = true
        eventCollectionView.reloadData()
        tableViewButton.imageView?.image = UIImage(named: "list")
        collectionViewButton.imageView?.image = UIImage(named: "grid-selected")
    }
    
    @IBAction func seeAllTapped(_ sender: UIButton) {
        self.currentFilter = Filter()
        performSegue(withIdentifier: "ShowSearchResultsSegue", sender: self)
    }
    
    // MARK: - Filter Buttons IBActions
    @IBAction func todayTapped(_ sender: UIButton) {
        todayButton.setAttributedTitle(createAttrText(with: "Today", color: .selectedButton, fontName: PoppinsFont.semiBold.rawValue), for: .normal)
        tomorrowButton.setAttributedTitle(createAttrText(with: "Tomorrow", color: .unselectedDayButton, fontName: PoppinsFont.light.rawValue), for: .normal)
        thisWeekendButton.setAttributedTitle(createAttrText(with: "This weekend", color: .unselectedDayButton, fontName: PoppinsFont.light.rawValue), for: .normal)
        allUpcomingButton.setAttributedTitle(createAttrText(with: "All upcoming", color: .unselectedDayButton, fontName: PoppinsFont.light.rawValue), for: .normal)
//        events = unfilteredEvents?.filter({ Calendar.current.dateComponents([.day, .month, .year], from: $0.startDate ?? Date(timeIntervalSince1970: 0)) == Calendar.current.dateComponents([.day, .month, .year], from: Date()) })
        eventTableView.reloadData()
        dateLabel.text = todayDateFormatter.string(from: Date())
    }
    
    @IBAction func tomorrowTapped(_ sender: UIButton) {
        todayButton.setAttributedTitle(createAttrText(with: "Today", color: .unselectedDayButton, fontName: PoppinsFont.light.rawValue), for: .normal)
        tomorrowButton.setAttributedTitle(createAttrText(with: "Tomorrow", color: .selectedButton, fontName: PoppinsFont.semiBold.rawValue), for: .normal)
        thisWeekendButton.setAttributedTitle(createAttrText(with: "This weekend", color: .unselectedDayButton, fontName: PoppinsFont.light.rawValue), for: .normal)
        allUpcomingButton.setAttributedTitle(createAttrText(with: "All upcoming", color: .unselectedDayButton, fontName: PoppinsFont.light.rawValue), for: .normal)
//        let filterDate = Calendar.current.dateComponents([.day, .month, .year], from: Date().tomorrow)
//        events = unfilteredEvents?.filter({
//            return filterDate == Calendar.current.dateComponents([.day, .month, .year], from: $0.startDate ?? Date(timeIntervalSince1970: 0))
//        })
        eventTableView.reloadData()
        dateLabel.text = todayDateFormatter.string(from: Date().tomorrow)
    }
    
    @IBAction func thisWeekendTapped(_ sender: UIButton) {
//        todayButton.setAttributedTitle(createAttrText(with: "Today", color: .unselectedDayButton, fontName: PoppinsFont.light.rawValue), for: .normal)
//        tomorrowButton.setAttributedTitle(createAttrText(with: "Tomorrow", color: .unselectedDayButton, fontName: PoppinsFont.light.rawValue), for: .normal)
//        thisWeekendButton.setAttributedTitle(createAttrText(with: "This weekend", color: .selectedButton, fontName: PoppinsFont.semiBold.rawValue), for: .normal)
//        allUpcomingButton.setAttributedTitle(createAttrText(with: "All upcoming", color: .unselectedDayButton, fontName: PoppinsFont.light.rawValue), for: .normal)
//
//        let arrWeekDays = Date().getWeekDays()
//        let saturdayFilterDate = Calendar.current.dateComponents([.day, .month, .year], from: arrWeekDays.thisWeek[arrWeekDays.thisWeek.count - 2])
//        let sundayFilterDate = Calendar.current.dateComponents([.day, .month, .year], from: arrWeekDays.thisWeek[arrWeekDays.thisWeek.count - 1])
//        events = unfilteredEvents?.filter({
//            let comp = Calendar.current.dateComponents([.day, .month, .year], from: $0.startDate ?? Date(timeIntervalSince1970: 0))
//            return saturdayFilterDate == comp || sundayFilterDate == comp
//        })
//        eventTableView.reloadData()
//        dateLabel.text = "\(weekdayDateFormatter.string(from: arrWeekDays.thisWeek[arrWeekDays.thisWeek.count - 2])) - \(todayDateFormatter.string(from: arrWeekDays.thisWeek[arrWeekDays.thisWeek.count - 1]))"
    }
    
    @IBAction func allUpcomingTapped(_ sender: UIButton) {
//        todayButton.setAttributedTitle(createAttrText(with: "Today", color: .unselectedDayButton, fontName: PoppinsFont.light.rawValue), for: .normal)
//        tomorrowButton.setAttributedTitle(createAttrText(with: "Tomorrow", color: .unselectedDayButton, fontName: PoppinsFont.light.rawValue), for: .normal)
//        thisWeekendButton.setAttributedTitle(createAttrText(with: "This weekend", color: .unselectedDayButton, fontName: PoppinsFont.light.rawValue), for: .normal)
//        allUpcomingButton.setAttributedTitle(createAttrText(with: "All upcoming", color: .selectedButton, fontName: PoppinsFont.semiBold.rawValue), for: .normal)
//        events = unfilteredEvents?.filter {
//            return Date() < $0.endDate ?? Date(timeIntervalSince1970: 0)
//        }
//        eventTableView.reloadData()
//        dateLabel.text = "\(todayDateFormatter.string(from: Date()))+"
    }
    
    // MARK: - Search IBActions
    @IBAction func searchBarCancelButtonTapped(_ sender: UIButton) {
        searchBarCancelButtonClicked(eventSearchBar)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowFeaturedDetailSegue" {
            guard let detailVC = segue.destination as? EventDetailViewController,
                let indexPath = featuredCollectionView.indexPathsForSelectedItems?.first,
                let events = unfilteredEvents else { return }
//            detailVC.controller = controller
            detailVC.indexPath = indexPath
            detailVC.event = apolloController?.events[indexPath.row]
        } else if segue.identifier == "ShowEventsTableDetailSegue" {
            guard let detailVC = segue.destination as? EventDetailViewController,
            let indexPath = eventTableView.indexPathForSelectedRow,
            let events = events else { return }
//            detailVC.controller = controller
            detailVC.indexPath = indexPath
            detailVC.event = apolloController?.events[indexPath.row]
        } else if segue.identifier == "ShowEventsCollectionDetailSegue" {
            guard let detailVC = segue.destination as? EventDetailViewController,
            let indexPath = eventCollectionView.indexPathsForSelectedItems?.first,
            let events = events else { return }
//            detailVC.controller = controller
            detailVC.indexPath = indexPath
            detailVC.event = events[indexPath.row]
        } else if segue.identifier == "CustomShowFilterSegue" {
            shouldDismissFilterScreen = false
            guard let filterVC = segue.destination as? FilterViewController else { return }
            filterVC.events = unfilteredEvents
//            filterVC.controller = controller
            if let filter = self.currentFilter {
                filterVC.filter = filter
            }
            filterVC.delegate = self
        } else if segue.identifier == "ShowSearchResultsSegue" {
            guard let resultsVC = segue.destination as? SearchResultViewController else { return }
//            resultsVC.controller = controller
            resultsVC.filter = currentFilter
            currentFilter = nil
        } else if segue.identifier == "ByDistanceSegue" {
            guard let resultsVC = segue.destination as? SearchResultViewController else { return }
//            resultsVC.controller = controller
            resultsVC.events = unfilteredEvents
            currentFilter = nil
        }
    }
}
// MARK: - Filter Extension
extension HomeViewController: FilterDelegate {
    func receive(filters: Filter) {
        self.currentFilter = filters
    }
}

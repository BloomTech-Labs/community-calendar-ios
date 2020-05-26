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
    var apolloController: ApolloController? {
        didSet {
            self.apolloController?.fetchEvents(completion: { _ in
                self.events = self.apolloController?.events
            })
            print("Home View Controller ApolloController: \(String(describing: apolloController))")
        }
    }
    var authController: AuthController? {
        didSet {
            print("Home View Controller AuthController: \(String(describing: authController))")
        }
    }
    
    var events: [Event]? {
        didSet {
            print("These are the Home View Controllers events count: \(String(describing: self.events?.count))")
            self.filteredEvents = self.events
//            self.featuredCollectionView.reloadData()
        }
    }

    var filteredEvents: [Event]? {
        didSet {
            self.featuredCollectionView.reloadData()
            self.eventTableView.reloadData()
            self.eventCollectionView.reloadData()
        }
    }
    
    var filter: FilterEventType? = .all {
        didSet {
            self.eventTableView.reloadData()
            self.eventCollectionView.reloadData()
        }
    }
    
    let photoFetchQueue = OperationQueue()
    let cache = Cache<String, UIImage>()
    var operations = [String : Operation]()
    
    var testing = false
    var repeatCount = 1
    var shouldDismissFilterScreen = true
    var unfilteredEvents: [FetchEventsQuery.Data.Event]? {        // Varible events' data source
        didSet {
            allUpcomingTapped(UIButton())
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
    
    @IBOutlet weak var noResultsLabel: UILabel!
    
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
        passControllers {
//            self.events = self.apolloController?.events
//            self.apolloController?.fetchEvents(completion: { result in
//                if let fetchedEvents = try? result.get() {
////                    self.events = fetchedEvents
//                    self.featuredCollectionView.reloadData()
//                    self.eventCollectionView.reloadData()
//                    self.eventTableView.reloadData()
//                }
//            })
        }
        
//        apolloController?.fetchEvents { _ in
//            self.events = self.apolloController?.events
//            self.filteredEvents = self.apolloController?.events
//            self.eventCollectionView.reloadData()
//            self.eventTableView.reloadData()
//            self.featuredCollectionView.reloadData()
//        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        noResultsLabel.isHidden = true
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
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
        allUpcomingTapped(UIButton())
        
        eventSearchBar.delegate = self
        self.navigationController?.delegate = self
        shouldShowSearchView(false, shouldAnimate: false)               // Hide searchview on launch
        
        todayButton.titleLabel?.adjustsFontSizeToFitWidth = true
        tomorrowButton.titleLabel?.adjustsFontSizeToFitWidth = true
        thisWeekendButton.titleLabel?.adjustsFontSizeToFitWidth = true
        allUpcomingButton.titleLabel?.adjustsFontSizeToFitWidth = true
        
        updateViews()
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
    
//    private func createMockData(eventList: [Event]) { // For testing without wifi
//        print("let testData = [")
//        for event in eventList {
//            var addComma = ","
//            if event == eventList.last! {
//                addComma = ""
//            }
//            print("Event(title: \"\(event.title)\", description: \"\(event.description)\", startDate: backendDateFormatter.date(from: \"\(backendDateFormatter.string(from: event.startDate ?? Date()))\") ?? Date(), endDate: backendDateFormatter.date(from: \"\(backendDateFormatter.string(from: event.endDate ?? Date()))\") ?? Date(), creator: \"\(event.creator)\", urls: \(event.urls), images: \(event.images), rsvps: \(event.rsvps), locations: \(event.locations), tags: \(event.tags), ticketPrice: \(event.ticketPrice))\(addComma)")
//        }
//        print("]")
//    }
    
    
    
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
        filter = .today
        
        let dates = Apollo.shared.todaysDateRange()
        guard let startDate = dates.first, let endDate = dates.last else { return }
        
        filteredEvents = events?.filter({ ($0.startDate.isBetween(startDate, and: endDate)) })
        dateLabel.text = todayDateFormatter.string(from: startDate)
        eventTableView.reloadData()
        eventCollectionView.reloadData()
    }
    
    @IBAction func tomorrowTapped(_ sender: UIButton) {
        todayButton.setAttributedTitle(createAttrText(with: "Today", color: .unselectedDayButton, fontName: PoppinsFont.light.rawValue), for: .normal)
        tomorrowButton.setAttributedTitle(createAttrText(with: "Tomorrow", color: .selectedButton, fontName: PoppinsFont.semiBold.rawValue), for: .normal)
        thisWeekendButton.setAttributedTitle(createAttrText(with: "This weekend", color: .unselectedDayButton, fontName: PoppinsFont.light.rawValue), for: .normal)
        allUpcomingButton.setAttributedTitle(createAttrText(with: "All upcoming", color: .unselectedDayButton, fontName: PoppinsFont.light.rawValue), for: .normal)
        filter = .tomorrow
    
        let dates = Apollo.shared.tomorrowsDateRange()
        guard let startDate = dates.first, let endDate = dates.last else { return }
        
        filteredEvents = events?.filter({ ($0.startDate.isBetween(startDate, and: endDate)) })
        dateLabel.text = todayDateFormatter.string(from: startDate)
        eventTableView.reloadData()
        eventCollectionView.reloadData()
        
    }
    
    @IBAction func thisWeekendTapped(_ sender: UIButton) {
        todayButton.setAttributedTitle(createAttrText(with: "Today", color: .unselectedDayButton, fontName: PoppinsFont.light.rawValue), for: .normal)
        tomorrowButton.setAttributedTitle(createAttrText(with: "Tomorrow", color: .unselectedDayButton, fontName: PoppinsFont.light.rawValue), for: .normal)
        thisWeekendButton.setAttributedTitle(createAttrText(with: "This weekend", color: .selectedButton, fontName: PoppinsFont.semiBold.rawValue), for: .normal)
        allUpcomingButton.setAttributedTitle(createAttrText(with: "All upcoming", color: .unselectedDayButton, fontName: PoppinsFont.light.rawValue), for: .normal)
        filter = .weekend
        
        let dates = Apollo.shared.weekendDateRange()
        guard let startDate = dates.first, let endDate = dates.last else { return }
        
        filteredEvents = events?.filter({ ($0.startDate.isBetween(startDate, and: endDate)) })
        dateLabel.text = "\(todayDateFormatter.string(from: startDate)) - \(todayDateFormatter.string(from: endDate.addingTimeInterval(-1)))"
        eventTableView.reloadData()
        eventCollectionView.reloadData()
        
    }
    
    @IBAction func allUpcomingTapped(_ sender: UIButton) {
        todayButton.setAttributedTitle(createAttrText(with: "Today", color: .unselectedDayButton, fontName: PoppinsFont.light.rawValue), for: .normal)
        tomorrowButton.setAttributedTitle(createAttrText(with: "Tomorrow", color: .unselectedDayButton, fontName: PoppinsFont.light.rawValue), for: .normal)
        thisWeekendButton.setAttributedTitle(createAttrText(with: "This weekend", color: .unselectedDayButton, fontName: PoppinsFont.light.rawValue), for: .normal)
        allUpcomingButton.setAttributedTitle(createAttrText(with: "All upcoming", color: .selectedButton, fontName: PoppinsFont.semiBold.rawValue), for: .normal)
        filter = .all
        
        let dates = Apollo.shared.allEventsRange()
        guard let startDate = dates.first, let endDate = dates.last else { return }
        
        filteredEvents = events?.filter({ ($0.startDate.isBetween(startDate, and: endDate)) })
        dateLabel.text = todayDateFormatter.string(from: Date())
        eventTableView.reloadData()
        eventCollectionView.reloadData()
        
    }
    
    // MARK: - Search IBActions
    @IBAction func searchBarCancelButtonTapped(_ sender: UIButton) {
        searchBarCancelButtonClicked(eventSearchBar)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowFeaturedDetailSegue" {
            guard let detailVC = segue.destination as? EventDetailViewController,
                let indexPath = featuredCollectionView.indexPathsForSelectedItems?.first else { return }
            detailVC.indexPath = indexPath
            detailVC.event = events?[indexPath.item]
        } else if segue.identifier == "ShowEventsTableDetailSegue" {
            guard let detailVC = segue.destination as? EventDetailViewController,
            let indexPath = eventTableView.indexPathForSelectedRow else { return }
            
            detailVC.indexPath = indexPath
            detailVC.event = filteredEvents?[indexPath.row]
        } else if segue.identifier == "ShowEventsCollectionDetailSegue" {
            guard let detailVC = segue.destination as? EventDetailViewController,
            let indexPath = eventCollectionView.indexPathsForSelectedItems?.first else { return }
            detailVC.indexPath = indexPath
            detailVC.event = filteredEvents?[indexPath.row]
        } else if segue.identifier == "CustomShowFilterSegue" {
            shouldDismissFilterScreen = false
            guard let filterVC = segue.destination as? FilterViewController else { return }
            filterVC.events = filteredEvents
            if let filter = self.currentFilter {
                filterVC.filter = filter
            }
            filterVC.delegate = self
        } else if segue.identifier == "ShowSearchResultsSegue" {
            guard let resultsVC = segue.destination as? SearchResultViewController else { return }
            resultsVC.filter = currentFilter
            currentFilter = nil
        } else if segue.identifier == "ByDistanceSegue" {
            guard let resultsVC = segue.destination as? SearchResultViewController else { return }
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

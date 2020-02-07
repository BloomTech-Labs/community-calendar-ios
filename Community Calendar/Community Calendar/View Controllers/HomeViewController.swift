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
import CoreLocation

class HomeViewController: UIViewController, ControllerDelegate {
    // MARK: - Varibles
    var testing = false                             // Use the test data from Variables.swift
    var repeatCount = 1
    var fetchEventsTimer: Timer?
    
    var shouldDismissFilterScreen = true
    var controller: Controller?
    private var unfilteredEvents: [Event]? {        // Varible events' data source
        didSet {
            todayTapped(UIButton())
        }
    }
    private var recentFiltersList = [Filter]() {
        didSet {
            recentSearchesTableView.reloadData()
        }
    }
    private var events: [Event]?                    // Table/Collection view data source
    var currentFilter: Filter? {
        didSet {
            updateFilterCount()
        }
    }
    
    // MARK: - Lists IBOutles
    @IBOutlet private weak var featuredCollectionView: UICollectionView!
    @IBOutlet private weak var eventCollectionView: UICollectionView!
    @IBOutlet private weak var eventTableView: UITableView!
    
    @IBOutlet private weak var collectionViewButton: UIButton!
    @IBOutlet private weak var tableViewButton: UIButton!
    @IBOutlet private weak var seperatorView: UIView!
    @IBOutlet private weak var dateLabel: UILabel!
    
    @IBOutlet private weak var noResultsLabel: UILabel!
    
    // MARK: - Filter Buttons IBOutles
    @IBOutlet private weak var thisWeekendButton: UIButton!
    @IBOutlet private weak var allUpcomingButton: UIButton!
    @IBOutlet private weak var tomorrowButton: UIButton!
    @IBOutlet private weak var todayButton: UIButton!
    @IBOutlet private weak var seeAllButton: UIButton!
    
    // MARK: - Search IBOutles
    @IBOutlet private weak var searchBar: UISearchBar!
    @IBOutlet private weak var filterButton: UIButton!
    @IBOutlet private weak var nearbyButton: UIButton!
    @IBOutlet private weak var nearbyLabel: UILabel!
    @IBOutlet private weak var recentSearchesLabel: UILabel!
    @IBOutlet private weak var recentSearchesTableView: UITableView!
    @IBOutlet private weak var searchView: UIView!
    @IBOutlet private weak var searchBarCancelButton: UIButton!
    @IBOutlet private weak var searchBarTrailingConstraint: NSLayoutConstraint!
    @IBOutlet private var searchViewTopConstraint: NSLayoutConstraint!      // Strong reference so that it wont be deallocated when setting new value
    @IBOutlet private var searchViewBottomConstraint: NSLayoutConstraint!   // ^
    
    // MARK: - Lifecycle Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
//        printFonts()
        
        self.tabBarController?.setViewControllers([tabBarController?.viewControllers?[0] ?? UIViewController(), tabBarController?.viewControllers?[2] ?? UIViewController()], animated: false); #warning("Changed for presentation, please remove")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if testing {
            unfilteredEvents = testData
        } else {
            setUpTimer()
            fetchEvents()
        }
        
        noResultsLabel.isHidden = true
    }
    
    // MARK: - View Functions
    private func setUp() { // Things that only need to be set once
        eventTableView.delegate = self
        eventTableView.dataSource = self
        eventTableView.showsVerticalScrollIndicator = false
        
        recentSearchesTableView.delegate = self
        recentSearchesTableView.dataSource = self
        recentSearchesTableView.showsVerticalScrollIndicator = false
        
        eventCollectionView.delegate = self
        eventCollectionView.dataSource = self
        eventCollectionView.showsVerticalScrollIndicator = false
        
        featuredCollectionView.delegate = self
        featuredCollectionView.dataSource = self
        featuredCollectionView.showsHorizontalScrollIndicator = false
        
        tableViewButtonTapped(0)
        
        
        searchBar.delegate = self
        self.navigationController?.delegate = self
        searchView.translatesAutoresizingMaskIntoConstraints = false
        searchBar.translatesAutoresizingMaskIntoConstraints = false
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
        searchBorderDesigns()

        seperatorView.layer.cornerRadius = 3
        
        dateLabel.text = todayDateFormatter.string(from: Date())
        eventTableView.separatorColor = .clear
        recentSearchesTableView.separatorColor = .clear
        
        
        guard let poppinsFont = UIFont(name: PoppinsFont.regular.rawValue, size: 10) else { return }
        self.tabBarController?.tabBar.tintColor = .tabBarTint
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.font: poppinsFont], for: .normal)
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.font: poppinsFont], for: .selected)
    }
    
    private func setUpSearchBar() {
        searchBar.backgroundColor = .white
        searchBar.setBackgroundImage(UIImage(), for: .any, barMetrics: .default)
        searchBar.setImage(UIImage(), for: .search, state: .normal)
        searchBar.isTranslucent = true
        searchBar.searchTextField.backgroundColor = .clear
        searchBar.layer.cornerRadius = 6
        searchBar.layer.shadowColor = UIColor.lightGray.cgColor
        searchBar.layer.shadowOpacity = 1.0
        searchBar.layer.shadowRadius = 2
        searchBar.layer.shadowOffset = CGSize(width: 0, height: 0)
        searchBar.searchTextField.placeholder = ""
        
        if let font = UIFont(name: PoppinsFont.medium.rawValue, size: 14.0) {
            searchBar.searchTextField.attributedPlaceholder = NSAttributedString(string: "Search", attributes: [
                NSAttributedString.Key.font: font,
                NSAttributedString.Key.foregroundColor: UIColor.lightGray
            ])
            searchBar.searchTextField.font = font
        } else {
            searchBar.searchTextField.placeholder = "Search"
        }
    }
    
    // MARK: - Data Functions
    private func fetchEvents() {
        controller?.getEvents { result in
            switch result {
            case .success(let eventList):
                if self.unfilteredEvents != eventList {
                    if self.fetchEventsTimer != nil {
                        self.fetchEventsTimer!.invalidate()
                        self.fetchEventsTimer = nil
                        NSLog("Fetched events successfully after \(self.repeatCount) attempt\(self.repeatCount == 1 ? "" : "s")")
                        self.repeatCount = 1
                    }
                    self.unfilteredEvents = eventList
                    self.featuredCollectionView.reloadData()
//                    createMockData()
                }
            case .failure(let error):
                NSLog("\(#file):L\(#line): Configuration failed inside \(#function) with error: \(error)")
            }
        }
    }
    
    @objc
    private func setUpTimer() {
        fetchEventsTimer = Timer.scheduledTimer(timeInterval: 10.0, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
    }
    
    @objc
    private func updateTimer() {
        if repeatCount >= 4 {
            if fetchEventsTimer != nil {
                fetchEventsTimer!.invalidate()
                fetchEventsTimer = nil
                repeatCount = 1
                let alert = UIAlertController(title: "Unable to get events", message: "Please make sure your device is connect to wifi or cellular data.", preferredStyle: .alert)
                self.present(alert, animated: true)
            } else {
                NSLog("Timer is nil, but selector was called. Possible concurrency issue")
            }
            NSLog("Unable to fetch events, all attemps failed. Is device connected to internet?")
        } else {
            print("Timer fired!")
            repeatCount += 1
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
    
    // MARK: - Search Functions
    private func shouldShowSearchView(_ bool: Bool, shouldAnimate: Bool = true) {
        searchViewTopConstraint.isActive = false
        if bool {
            searchViewTopConstraint = NSLayoutConstraint(item: searchView!, attribute: .top, relatedBy: .equal, toItem: searchBar, attribute: .bottom, multiplier: 1, constant: 3)
        } else {
            searchViewTopConstraint = NSLayoutConstraint(item: searchView!, attribute: .top, relatedBy: .equal, toItem: view, attribute: .bottom, multiplier: 1, constant: 0)
        }
        searchViewTopConstraint.isActive = true
        searchViewBottomConstraint.isActive = bool
        
        if shouldAnimate {
            UIView.animate(withDuration: 0.5) {
                self.searchView.layoutIfNeeded()
            }
        } else {
            self.searchView.layoutIfNeeded()
        }
    }
    
    private func searchBorderDesigns() {
        // Set filter button's border
        filterButton.setTitleColor(UIColor(red: 0, green: 0, blue: 0, alpha: 0.5), for: .normal)
        filterButton.layer.cornerRadius = 29 / 1.6
        filterButton.layer.borderWidth = 1
        filterButton.layer.borderColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.5).cgColor
        
        // Set nearby button's boarder
        nearbyButton.layer.backgroundColor = UIColor(red: 0.842, green: 0.842, blue: 0.842, alpha: 1).cgColor
        nearbyButton.layer.cornerRadius = 5
        nearbyButton.layer.borderWidth = 1
        nearbyButton.layer.borderColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.1).cgColor
        
        // Change text color
        nearbyLabel.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.6)
        recentSearchesLabel.textColor = UIColor(red: 0.129, green: 0.141, blue: 0.173, alpha: 1)
    }
    
    private func updateFilterCount() {
        guard let currentFilter = currentFilter else {
            filterButton.text("Filters")
            return
        }
        var filterCount = 0
        
        if currentFilter.dateRange != nil {
            filterCount += 1
        }
        if currentFilter.index != nil {
            filterCount += 1
        }
        if currentFilter.location != nil {
            filterCount += 1
        }
        if currentFilter.zipCode != nil {
            filterCount += 1
        }
        if currentFilter.ticketPrice != nil {
            filterCount += 1
        }
        if currentFilter.tags != nil {
            filterCount += currentFilter.tags?.count ?? 0
        }
        filterButton.text("Filters\(filterCount == 0 ? "" : "(\(filterCount))")")
    }
    
    func setUpLocation() -> Bool {
        var alert: UIAlertController?
        switch CLLocationManager.authorizationStatus() {
        case .authorizedAlways, .authorizedWhenInUse:
            return true
        case .denied:
            alert = UIAlertController(title: "Location disabled", message: "Please turn on location services in settings", preferredStyle: .alert)
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
            let openSettings = UIAlertAction(title: "Settings", style: .default) { action in
                UIApplication.shared.open(URL(string: UIApplication.openSettingsURLString)!, options: [:], completionHandler: nil)
            }
            alert?.addAction(cancelAction)
            alert?.addAction(openSettings)
            return false
        case .notDetermined:
            controller?.locationManager.requestWhenInUseAuthorization()
        case .restricted:
            alert = UIAlertController(title: "You are restricted", message: "Please request access from restrictor (generally from parental or administrative controls)", preferredStyle: .alert)
            alert?.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
            return false
        @unknown default:
            return false
        }
        return false
    }
    
    // MARK: - Extra Functions
    private func printFonts() {
        // To test if fonts were added correctly: (Common mistakes: Incorrect/no target membership, not listed in info.plist)
        for fam in UIFont.familyNames {
            print("Family: \(fam)")
            for fontName in UIFont.fontNames(forFamilyName: fam) {
                print("Name: \(fontName)")
                // If font is here ^, you can use it in storyboard or code, if not, there is an issue
            }
        }
    }
    
    private func createAttrText(with title: String, color: UIColor, fontName: String) -> NSAttributedString {
        guard let font = UIFont(name: fontName, size: 14) else { return NSAttributedString() }
        let attrString = NSAttributedString(string: title,
            attributes: [NSAttributedString.Key.foregroundColor: color, NSAttributedString.Key.font: font])
        return attrString
    }
    
    // MARK: - IBActions
    @IBAction func tableViewButtonTapped(_ sender: Any) {
        eventCollectionView.isHidden = true
        eventTableView.isHidden = false
        tableViewButton.imageView?.image = UIImage(named: "list-selected")
        collectionViewButton.imageView?.image = UIImage(named: "grid")
    }
    
    @IBAction func collectionViewButtonTapped(_ sender: Any) {
        eventCollectionView.isHidden = false
        eventTableView.isHidden = true
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
        events = unfilteredEvents?.filter({ Calendar.current.dateComponents([.day, .month, .year], from: $0.startDate ?? Date(timeIntervalSince1970: 0)) == Calendar.current.dateComponents([.day, .month, .year], from: Date()) })
        eventTableView.reloadData()
        dateLabel.text = todayDateFormatter.string(from: Date())
    }
    
    @IBAction func tomorrowTapped(_ sender: UIButton) {
        todayButton.setAttributedTitle(createAttrText(with: "Today", color: .unselectedDayButton, fontName: PoppinsFont.light.rawValue), for: .normal)
        tomorrowButton.setAttributedTitle(createAttrText(with: "Tomorrow", color: .selectedButton, fontName: PoppinsFont.semiBold.rawValue), for: .normal)
        thisWeekendButton.setAttributedTitle(createAttrText(with: "This weekend", color: .unselectedDayButton, fontName: PoppinsFont.light.rawValue), for: .normal)
        allUpcomingButton.setAttributedTitle(createAttrText(with: "All upcoming", color: .unselectedDayButton, fontName: PoppinsFont.light.rawValue), for: .normal)
        let filterDate = Calendar.current.dateComponents([.day, .month, .year], from: Date().tomorrow)
        events = unfilteredEvents?.filter({
            return filterDate == Calendar.current.dateComponents([.day, .month, .year], from: $0.startDate ?? Date(timeIntervalSince1970: 0))
        })
        eventTableView.reloadData()
        dateLabel.text = todayDateFormatter.string(from: Date().tomorrow)
    }
    
    @IBAction func thisWeekendTapped(_ sender: UIButton) {
        todayButton.setAttributedTitle(createAttrText(with: "Today", color: .unselectedDayButton, fontName: PoppinsFont.light.rawValue), for: .normal)
        tomorrowButton.setAttributedTitle(createAttrText(with: "Tomorrow", color: .unselectedDayButton, fontName: PoppinsFont.light.rawValue), for: .normal)
        thisWeekendButton.setAttributedTitle(createAttrText(with: "This weekend", color: .selectedButton, fontName: PoppinsFont.semiBold.rawValue), for: .normal)
        allUpcomingButton.setAttributedTitle(createAttrText(with: "All upcoming", color: .unselectedDayButton, fontName: PoppinsFont.light.rawValue), for: .normal)
        
        let arrWeekDays = Date().getWeekDays()
        let saturdayFilterDate = Calendar.current.dateComponents([.day, .month, .year], from: arrWeekDays.thisWeek[arrWeekDays.thisWeek.count - 2])
        let sundayFilterDate = Calendar.current.dateComponents([.day, .month, .year], from: arrWeekDays.thisWeek[arrWeekDays.thisWeek.count - 1])
        events = unfilteredEvents?.filter({
            let comp = Calendar.current.dateComponents([.day, .month, .year], from: $0.startDate ?? Date(timeIntervalSince1970: 0))
            return saturdayFilterDate == comp || sundayFilterDate == comp
        })
        eventTableView.reloadData()
        dateLabel.text = "\(weekdayDateFormatter.string(from: arrWeekDays.thisWeek[arrWeekDays.thisWeek.count - 2])) - \(todayDateFormatter.string(from: arrWeekDays.thisWeek[arrWeekDays.thisWeek.count - 1]))"
    }
    
    @IBAction func allUpcomingTapped(_ sender: UIButton) {
        todayButton.setAttributedTitle(createAttrText(with: "Today", color: .unselectedDayButton, fontName: PoppinsFont.light.rawValue), for: .normal)
        tomorrowButton.setAttributedTitle(createAttrText(with: "Tomorrow", color: .unselectedDayButton, fontName: PoppinsFont.light.rawValue), for: .normal)
        thisWeekendButton.setAttributedTitle(createAttrText(with: "This weekend", color: .unselectedDayButton, fontName: PoppinsFont.light.rawValue), for: .normal)
        allUpcomingButton.setAttributedTitle(createAttrText(with: "All upcoming", color: .selectedButton, fontName: PoppinsFont.semiBold.rawValue), for: .normal)
        events = unfilteredEvents?.filter {
            return Date() < $0.endDate ?? Date(timeIntervalSince1970: 0)
        }
        eventTableView.reloadData()
        dateLabel.text = "\(todayDateFormatter.string(from: Date()))+"
    }
    
    // MARK: - Search IBActions
    @IBAction func filterButtonTapped(_ sender: UIButton) {
        
    }
    
    @IBAction func nearByButtonTapped(_ sender: UIButton) {
        if setUpLocation() {
            currentFilter = nil
        }
    }
    
    @IBAction func searchBarCancelButtonTapped(_ sender: UIButton) {
        searchBarCancelButtonClicked(searchBar)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowFeaturedDetailSegue" {
            guard let detailVC = segue.destination as? EventDetailViewController,
                let indexPath = featuredCollectionView.indexPathsForSelectedItems?.first,
                let events = unfilteredEvents else { return }
            detailVC.controller = controller
            detailVC.indexPath = indexPath
            detailVC.event = events[indexPath.row]
        } else if segue.identifier == "ShowEventsTableDetailSegue" {
            guard let detailVC = segue.destination as? EventDetailViewController,
            let indexPath = eventTableView.indexPathForSelectedRow,
            let events = events else { return }
            detailVC.controller = controller
            detailVC.indexPath = indexPath
            detailVC.event = events[indexPath.row]
        } else if segue.identifier == "ShowEventsCollectionDetailSegue" {
            guard let detailVC = segue.destination as? EventDetailViewController,
            let indexPath = eventCollectionView.indexPathsForSelectedItems?.first,
            let events = events else { return }
            detailVC.controller = controller
            detailVC.indexPath = indexPath
            detailVC.event = events[indexPath.row]
        } else if segue.identifier == "CustomShowFilterSegue" {
            shouldDismissFilterScreen = false
            guard let filterVC = segue.destination as? FilterViewController else { return }
            filterVC.events = unfilteredEvents
            filterVC.controller = controller
            if let filter = self.currentFilter {
                filterVC.filter = filter
            }
            filterVC.delegate = self
        } else if segue.identifier == "ShowSearchResultsSegue" {
            guard let resultsVC = segue.destination as? SearchResultViewController else { return }
            resultsVC.controller = controller
            resultsVC.filter = currentFilter
            currentFilter = nil
        } else if segue.identifier == "ByDistanceSegue" {
            guard let resultsVC = segue.destination as? SearchResultViewController else { return }
            resultsVC.controller = controller
            resultsVC.events = unfilteredEvents
            currentFilter = nil
        }
    }
}

// MARK: - Table View Extension
extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == eventTableView {
            if events?.count == 0 || events == nil {
                noResultsLabel.isHidden = false
            } else {
                noResultsLabel.isHidden = true
            }
            return events?.count ?? 0
        } else if tableView == recentSearchesTableView {
            return recentFiltersList.count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == eventTableView {
            guard let cell = eventTableView.dequeueReusableCell(withIdentifier: "EventTableViewCell", for: indexPath) as? EventTableViewCell,
            let events = events else { return UITableViewCell() }
            
            cell.indexPath = indexPath
            cell.controller = controller
            cell.event = events[indexPath.row]
            
            return cell
        } else if tableView == recentSearchesTableView {
            guard let cell = recentSearchesTableView.dequeueReusableCell(withIdentifier: "RecentSearchCell", for: indexPath) as? RecentSearchesTableViewCell else { return UITableViewCell() }
            
            cell.filter = recentFiltersList[indexPath.row]
            
            return cell
        }
        
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if tableView == recentSearchesTableView {
            currentFilter = recentFiltersList[indexPath.row]
            performSegue(withIdentifier: "ShowSearchResultsSegue", sender: self)
        }
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        if tableView == eventTableView {
            return true
        }
        return false
    }
    
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        if tableView == eventTableView {
            let favoriteAction = UIContextualAction(style: .normal, title: "Favorite") { (action, view, handler) in
                print("Favorite tapped")
                // TODO: Add event to favorites
            }
            favoriteAction.backgroundColor = UIColor.systemPink
            let configuration = UISwipeActionsConfiguration(actions: [favoriteAction])
            return configuration
        }
        return nil
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        if tableView == eventTableView {
            let hideAction = UIContextualAction(style: .destructive, title: "Hide") { (action, view, handler) in
                print("Hide tapped")
                self.events?.remove(at: indexPath.row)
                self.eventTableView.deleteRows(at: [indexPath], with: .fade)
            }
            hideAction.backgroundColor = UIColor.blue
            let configuration = UISwipeActionsConfiguration(actions: [hideAction])
            return configuration
        }
        return nil
    }
}

// MARK: - Collection View Extension
extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == eventCollectionView {
            return events?.count ?? 0
        } else if collectionView == featuredCollectionView {
            return unfilteredEvents?.count ?? 0
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == eventCollectionView {
            guard let cell = eventCollectionView.dequeueReusableCell(withReuseIdentifier: "EventCollectionViewCell", for: indexPath) as? EventCollectionViewCell,
            let events = events else { return UICollectionViewCell() }
            
            cell.indexPath = indexPath
            cell.controller = controller
            cell.event = events[indexPath.row]
            
            return cell
            
        } else if collectionView == featuredCollectionView {
            guard let cell = featuredCollectionView.dequeueReusableCell(withReuseIdentifier: "FeaturedCell", for: indexPath) as? FeaturedCollectionViewCell,
            let events = unfilteredEvents else { return UICollectionViewCell() }
            
            cell.indexPath = indexPath
            cell.controller = controller
            cell.event = events[indexPath.row]
            
            return cell
        }
        return UICollectionViewCell()
    }
}

// MARK: - Search Bar Extension
extension HomeViewController: UISearchBarDelegate {
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        recentFiltersList = controller!.loadFromPersistantStore()
        shouldShowSearchView(true)
        searchBarTrailingConstraint.constant = -searchBarCancelButton.frame.width - 32
        UIView.animate(withDuration: 0.25) {
            searchBar.layoutIfNeeded()
            searchBar.superview?.layoutIfNeeded()
        }
        shouldDismissFilterScreen = true
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if let currentFilter = currentFilter {
            performSegue(withIdentifier: "ShowSearchResultsSegue", sender: self)
            controller?.save(filteredSearch: currentFilter)
            recentFiltersList.insert(currentFilter, at: 0)
        }
        shouldDismissFilterScreen = true
        searchBar.endEditing(true)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        shouldDismissFilterScreen = true
        searchBar.endEditing(true)
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        if shouldDismissFilterScreen {
            searchBar.setShowsCancelButton(false, animated: true)
            shouldShowSearchView(false)
            searchBarTrailingConstraint.constant = -16
            UIView.animate(withDuration: 0.25) {
                searchBar.layoutIfNeeded()
                searchBar.superview?.layoutIfNeeded()
            }
        }
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if currentFilter != nil {
            if searchText == "" {
                currentFilter?.index = nil
            } else {
                self.currentFilter?.index = searchText
            }
        } else {
            currentFilter = Filter(index: searchText)
        }
    }
    
    func setSearchBarText(to text: String = "") {
        searchBar.text = text
    }
}

// MARK: - Navigation Extension
extension HomeViewController: UINavigationControllerDelegate {

    func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationController.Operation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        guard let view = self.navigationController?.view else { return nil }
        // This function calls a custom segue animation when transitioning to an instance of FilterViewController
        switch operation {
        case .push:
            view.endEditing(true)
            if let _ = toVC as? FilterViewController {
                return CustomPushAnimator(view: view)
            } else {
                return nil
            }
        case .pop:
            if let _ = fromVC as? FilterViewController {
                searchBar.becomeFirstResponder()
                return CustomPopAnimator(view: view)
            }
            return nil
        default:
            return nil
        }
    }
}

// MARK: - Filter Extension
extension HomeViewController: FilterDelegate {
    func receive(filters: Filter) {
        self.currentFilter = filters
    }
}

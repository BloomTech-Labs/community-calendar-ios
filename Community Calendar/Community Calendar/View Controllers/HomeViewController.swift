//
//  HomeViewController.swift
//  Community Calendar
//
//  Created by Jordan Christensen on 12/16/19.
//  Copyright © 2019 Mazjap Co. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    // MARK: - Varibles
    var testing = false // Set this to true if you wish to use the test data located in Variables.swift
    
    var shouldDismissFilterScreen = true
    private let eventController = EventController()
    private var unfilteredEvents: [Event]? {
        didSet {
            allUpcomingTapped(UIButton())
        }
    }
    private var events: [Event]? {
        didSet {
            updateLists()
        }
    }
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
    
    // MARK: - Filter Buttons IBOutles
    @IBOutlet private weak var thisWeekendButton: UIButton!
    @IBOutlet private weak var allUpcomingButton: UIButton!
    @IBOutlet private weak var tomorrowButton: UIButton!
    @IBOutlet private weak var todayButton: UIButton!
    
    // MARK: - Search IBOutles
    @IBOutlet private weak var searchBar: UISearchBar!
    @IBOutlet private weak var filterButton: UIButton!
    @IBOutlet private weak var nearbyButton: UIButton!
    @IBOutlet private weak var nearbyLabel: UILabel!
    @IBOutlet private weak var recentSearchesLabel: UILabel!
    @IBOutlet private weak var searchView: UIView!
    @IBOutlet private weak var searchBarCancelButton: UIButton!
    @IBOutlet private weak var searchBarTrailingConstraint: NSLayoutConstraint!
    @IBOutlet private var searchViewTopConstraint: NSLayoutConstraint! // Strong reference so that it wont be deallocated when setting new value
    @IBOutlet private var searchViewBottomConstraint: NSLayoutConstraint! // ""
    
    // MARK: - Lifecycle Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
//        printFonts()
        
        nearbyButton.backgroundColor = .clear // Remove and implement
        nearbyLabel.textColor = .clear // Remove and implement
        nearbyButton.imageView?.image = nil // Remove
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if testing {
            unfilteredEvents = testData
        } else {
            fetchEvents()
        }
    }
    
    // MARK: - Functions
    private func setUp() { // Things that only need to be set once
        // Table and collection view set up
        eventTableView.delegate = self
        eventTableView.dataSource = self
        eventTableView.showsVerticalScrollIndicator = false
        
        eventCollectionView.delegate = self
        eventCollectionView.dataSource = self
        eventCollectionView.showsVerticalScrollIndicator = false
        
        featuredCollectionView.delegate = self
        featuredCollectionView.dataSource = self
        featuredCollectionView.showsHorizontalScrollIndicator = false
        
        tableViewButtonTapped(0)
        

        // Searchbar/search set up
        searchBar.delegate = self
        self.navigationController?.delegate = self
        searchView.translatesAutoresizingMaskIntoConstraints = false
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        shouldShowSearchView(false, shouldAnimate: false)
        
        
        // Filter buttons set up
        allUpcomingTapped(UIButton())
        todayButton.titleLabel?.adjustsFontSizeToFitWidth = true
        tomorrowButton.titleLabel?.adjustsFontSizeToFitWidth = true
        thisWeekendButton.titleLabel?.adjustsFontSizeToFitWidth = true
        allUpcomingButton.titleLabel?.adjustsFontSizeToFitWidth = true
        
        updateViews()
    }
    
    private func updateViews() {
        setUpSearchBar()
        searchBorderDesigns()

        seperatorView.layer.cornerRadius = 3
        
        dateLabel.text = todayDateFormatter.string(from: Date())
        eventTableView.separatorColor = UIColor.clear
        
        guard let poppinsFont = UIFont(name: "Poppins", size: 10) else { return }
        self.tabBarController?.tabBar.tintColor = .tabBarTint
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.font: poppinsFont], for: .normal)
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.font: poppinsFont], for: .selected)
    }
    
    private func fetchEvents() {
        eventController.getEvents { result in
            switch result {
            case .success(let eventList):
                if self.unfilteredEvents != eventList {
                    self.unfilteredEvents = eventList
                    
//                    for event in eventList {
//                        print("Event(title: \"\(event.title)\", description: \"\(event.description)\", startDate: backendDateFormatter.date(from: \"\(backendDateFormatter.string(from: event.startDate ?? Date()))\") ?? Date(), endDate: backendDateFormatter.date(from: \"\(backendDateFormatter.string(from: event.endDate ?? Date()))\") ?? Date(), creator: \"\(event.creator)\", urls: \(event.urls), images: \(event.images), rsvps: \(event.rsvps), locations: \(event.locations), tags: \(event.tags), ticketPrice: \(event.ticketPrice))")
//                    }
                }
            case .failure(let error):
                NSLog("\(#file):L\(#line): Configuration failed inside \(#function) with error: \(error)")
            }
        }
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
        
        if let font = UIFont(name: "Poppins-Medium", size: 14.0) {
            searchBar.searchTextField.attributedPlaceholder = NSAttributedString(string: "Search", attributes: [
                NSAttributedString.Key.font: font,
                NSAttributedString.Key.foregroundColor: UIColor.lightGray
            ])
            searchBar.searchTextField.font = font
        } else {
            searchBar.searchTextField.placeholder = "Search"
        }
    }
    
    private func updateLists() { // Refresh all three lists in one function
        eventTableView.reloadData()
        eventCollectionView.reloadData()
        featuredCollectionView.reloadData()
    }
    
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
    
    // MARK: - Search Functions
    func shouldShowSearchView(_ bool: Bool, shouldAnimate: Bool = true) {
        searchViewTopConstraint.isActive = false
        if bool {
            searchViewTopConstraint = NSLayoutConstraint(item: searchView!, attribute: .top, relatedBy: .equal, toItem: searchBar, attribute: .bottom, multiplier: 1, constant: 3)
            searchViewBottomConstraint.isActive = true
        } else {
            searchViewTopConstraint = NSLayoutConstraint(item: searchView!, attribute: .top, relatedBy: .equal, toItem: view, attribute: .bottom, multiplier: 1, constant: 0)
            searchViewBottomConstraint.isActive = false
        }
        searchViewTopConstraint.isActive = true
        if shouldAnimate {
            UIView.animate(withDuration: 0.5) {
                self.searchView.layoutIfNeeded()
            }
        } else {
            self.searchView.layoutIfNeeded()
        }
    }
    
    func searchBorderDesigns() {
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
    
    func updateFilterCount() {
        guard let currentFilter = currentFilter else {
            filterButton.setTitle("Filters", for: .normal)
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
        if currentFilter.ticketPrice != nil {
            filterCount += 1
        }
        if currentFilter.tags != nil {
            filterCount += currentFilter.tags?.count ?? 0
        }
        filterButton.setTitle("Filters\(filterCount == 0 ? "" : "(\(filterCount))")", for: .normal)
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
        
    }
    
    // MARK: - Filter Buttons IBActions
    @IBAction func todayTapped(_ sender: UIButton) {
        todayButton.setAttributedTitle(createAttrText(with: "Today", color: .selectedButton, fontName: "Poppins-SemiBold"), for: .normal)
        tomorrowButton.setAttributedTitle(createAttrText(with: "Tomorrow", color: .unselectedDayButton, fontName: "Poppins-Light"), for: .normal)
        thisWeekendButton.setAttributedTitle(createAttrText(with: "This weekend", color: .unselectedDayButton, fontName: "Poppins-Light"), for: .normal)
        allUpcomingButton.setAttributedTitle(createAttrText(with: "All upcoming", color: .unselectedDayButton, fontName: "Poppins-Light"), for: .normal)
        events = unfilteredEvents?.filter({ Calendar.current.dateComponents([.day, .month, .year], from: $0.startDate ?? Date(timeIntervalSince1970: 0)) == Calendar.current.dateComponents([.day, .month, .year], from: Date()) })
        eventTableView.reloadData()
    }
    
    @IBAction func tomorrowTapped(_ sender: UIButton) {
        todayButton.setAttributedTitle(createAttrText(with: "Today", color: .unselectedDayButton, fontName: "Poppins-Light"), for: .normal)
        tomorrowButton.setAttributedTitle(createAttrText(with: "Tomorrow", color: .selectedButton, fontName: "Poppins-SemiBold"), for: .normal)
        thisWeekendButton.setAttributedTitle(createAttrText(with: "This weekend", color: .unselectedDayButton, fontName: "Poppins-Light"), for: .normal)
        allUpcomingButton.setAttributedTitle(createAttrText(with: "All upcoming", color: .unselectedDayButton, fontName: "Poppins-Light"), for: .normal)
        events = unfilteredEvents?.filter({
            let filterDate = Calendar.current.dateComponents([.day, .month, .year], from: Date().tomorrow)
            return filterDate == Calendar.current.dateComponents([.day, .month, .year], from: $0.startDate ?? Date(timeIntervalSince1970: 0))
        })
        eventTableView.reloadData()
    }
    
    @IBAction func thisWeekendTapped(_ sender: UIButton) {
        todayButton.setAttributedTitle(createAttrText(with: "Today", color: .unselectedDayButton, fontName: "Poppins-Light"), for: .normal)
        tomorrowButton.setAttributedTitle(createAttrText(with: "Tomorrow", color: .unselectedDayButton, fontName: "Poppins-Light"), for: .normal)
        thisWeekendButton.setAttributedTitle(createAttrText(with: "This weekend", color: .selectedButton, fontName: "Poppins-SemiBold"), for: .normal)
        allUpcomingButton.setAttributedTitle(createAttrText(with: "All upcoming", color: .unselectedDayButton, fontName: "Poppins-Light"), for: .normal)
        
        let arrWeekDays = Date().getWeekDays()
        events = unfilteredEvents?.filter({
            let saturdayFilterDate = Calendar.current.dateComponents([.day, .month, .year], from: arrWeekDays.nextWeek[arrWeekDays.nextWeek.count - 2])
            let sundayFilterDate = Calendar.current.dateComponents([.day, .month, .year], from: arrWeekDays.nextWeek[arrWeekDays.nextWeek.count - 1])
            return saturdayFilterDate == Calendar.current.dateComponents([.day, .month, .year], from: $0.startDate ?? Date(timeIntervalSince1970: 0)) || sundayFilterDate == Calendar.current.dateComponents([.day, .month, .year], from: $0.startDate ?? Date(timeIntervalSince1970: 0))
        })
        eventTableView.reloadData()
    }
    
    @IBAction func allUpcomingTapped(_ sender: UIButton) {
        todayButton.setAttributedTitle(createAttrText(with: "Today", color: .unselectedDayButton, fontName: "Poppins-Light"), for: .normal)
        tomorrowButton.setAttributedTitle(createAttrText(with: "Tomorrow", color: .unselectedDayButton, fontName: "Poppins-Light"), for: .normal)
        thisWeekendButton.setAttributedTitle(createAttrText(with: "This weekend", color: .unselectedDayButton, fontName: "Poppins-Light"), for: .normal)
        allUpcomingButton.setAttributedTitle(createAttrText(with: "All upcoming", color: .selectedButton, fontName: "Poppins-SemiBold"), for: .normal)
        events = unfilteredEvents
        eventTableView.reloadData()
    }
    
    // MARK: - Search IBActions
    @IBAction func filterButtonTapped(_ sender: UIButton) {
        
    }
    
    @IBAction func nearByButtonTapped(_ sender: UIButton) {
        
    }
    
    @IBAction func searchBarCancelButtonTapped(_ sender: UIButton) {
        searchBarCancelButtonClicked(searchBar)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowFeaturedDetailSegue" {
            guard let detailVC = segue.destination as? EventDetailViewController,
                let indexPath = featuredCollectionView.indexPathsForSelectedItems?.first,
                let events = events else { return }
            detailVC.eventController = eventController
            detailVC.indexPath = indexPath
            detailVC.event = events[indexPath.row]
        } else if segue.identifier == "ShowEventsTableDetailSegue" {
            guard let detailVC = segue.destination as? EventDetailViewController,
            let indexPath = eventTableView.indexPathForSelectedRow,
            let events = events else { return }
            detailVC.eventController = eventController
            detailVC.indexPath = indexPath
            detailVC.event = events[indexPath.row]
        } else if segue.identifier == "ShowEventsCollectionDetailSegue" {
            guard let detailVC = segue.destination as? EventDetailViewController,
            let indexPath = eventCollectionView.indexPathsForSelectedItems?.first,
            let events = events else { return }
            detailVC.eventController = eventController
            detailVC.indexPath = indexPath
            detailVC.event = events[indexPath.row]
        } else if segue.identifier == "CustomShowFilterSegue" {
            shouldDismissFilterScreen = false
            guard let filterVC = segue.destination as? FilterViewController else { return }
            filterVC.delegate = self
        } else if segue.identifier == "ShowSearchResultsSegue" {
            guard let resultsVC = segue.destination as? SearchResultViewController else { return }
            resultsVC.eventController = eventController
            resultsVC.filter = currentFilter
        }
    }
}

// MARK: - Table View Extension
extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return events?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = eventTableView.dequeueReusableCell(withIdentifier: "EventTableViewCell", for: indexPath) as? EventTableViewCell,
        let events = events else { return UITableViewCell() }
        
        cell.indexPath = indexPath
        cell.eventController = eventController
        cell.event = events[indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        eventTableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let favoriteAction = UIContextualAction(style: .normal, title: "Favorite") { (action, view, handler) in
            print("Favorite tapped")
            // TODO: Add event to favorites
        }
        favoriteAction.backgroundColor = UIColor.systemPink
        let configuration = UISwipeActionsConfiguration(actions: [favoriteAction])
        return configuration
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let hideAction = UIContextualAction(style: .destructive, title: "Hide") { (action, view, handler) in
            print("Hide tapped")
            self.events?.remove(at: indexPath.row)
            self.eventTableView.deleteRows(at: [indexPath], with: .fade)
        }
        hideAction.backgroundColor = UIColor.blue
        let configuration = UISwipeActionsConfiguration(actions: [hideAction])
        return configuration
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
            cell.eventController = eventController
            cell.event = events[indexPath.row]
            
            return cell
            
        } else if collectionView == featuredCollectionView {
            guard let cell = featuredCollectionView.dequeueReusableCell(withReuseIdentifier: "FeaturedCell", for: indexPath) as? FeaturedCollectionViewCell,
            let events = unfilteredEvents else { return UICollectionViewCell() }
            
            cell.indexPath = indexPath
            cell.eventController = eventController
            cell.event = events[indexPath.row]
            
            return cell
        }
        return UICollectionViewCell()
    }
}

// MARK: - Search Bar Extension
extension HomeViewController: UISearchBarDelegate {
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        if shouldDismissFilterScreen {
            shouldShowSearchView(true)
            searchBarTrailingConstraint.constant = -searchBarCancelButton.frame.width - 32
            UIView.animate(withDuration: 0.25) {
                searchBar.layoutIfNeeded()
                searchBar.superview?.layoutIfNeeded()
            }
        }
        shouldDismissFilterScreen = true
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if let currentFilter = currentFilter {
            performSegue(withIdentifier: "ShowSearchResultsSegue", sender: self)
            eventController.getEvents(by: currentFilter) { result in
                switch result {
                case .success(let eventList):
                    print(eventList)
                    self.currentFilter = nil
                case .failure(let error):
                    NSLog("\(#file):L\(#line): Configuration failed inside \(#function) with error: \(error)")
                }
            }
        } else {
            eventController.getEvents { result in
                switch result {
                case .success(let eventList):
                    print(eventList.count)
                case .failure(let error):
                    NSLog("\(#file):L\(#line): Configuration failed inside \(#function) with error: \(error)")
                }
            }
        }
        searchBar.endEditing(true)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
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
            self.currentFilter?.index = searchText
        } else if searchText == "" {
            currentFilter?.index = nil
        } else {
            currentFilter = Filter(index: searchText)
        }
    }
}

// MARK: - Navigation Extension
extension HomeViewController: UINavigationControllerDelegate {

    func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationController.Operation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        guard let view = self.navigationController?.view else { return nil }
        
        switch operation {
        case .push:
            view.endEditing(true)
            if let toVC = toVC as? FilterViewController {
                toVC.events = unfilteredEvents
                toVC.eventController = eventController
                if let filter = self.currentFilter {
                    toVC.filter = filter
                }
                return CustomPushAnimator(view: view)
            } else {
                return nil
            }
        case .pop:
            searchBar.becomeFirstResponder()
            return CustomPopAnimator(view: view)
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

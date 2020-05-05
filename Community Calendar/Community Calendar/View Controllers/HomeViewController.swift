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

class HomeViewController: UIViewController, ControllerDelegate {
    // MARK: - Varibles
    var testing = false                             // Use the test data from Variables.swift
    var repeatCount = 1
    var fetchEventsTimer: Timer?
    let eventController = EventController()
    var shouldDismissFilterScreen = true
    var controller: Controller?
    private var unfilteredEvents: [Event]? {        // Varible events' data source
        didSet {
            todayTapped(UIButton())
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
    @IBOutlet weak var eventSearchBar: UISearchBar!
    @IBOutlet private weak var searchView: SearchView!
    @IBOutlet weak var searchBarCancelButton: UIButton!
    @IBOutlet weak var searchBarTrailingConstraint: NSLayoutConstraint!
    
    // MARK: - Lifecycle Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        searchView.homeVC = self
        searchView.controller = controller
        searchView.setUp()
        setUp()
        eventController.fetchEvents { fetchedEvents in
            //todo: Nothing to pass in here.
        }
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
//    private func fetchEvents() {
//        controller?.getEvents { result in
//            switch result {
//            case .success(let eventList):
//                if self.fetchEventsTimer != nil {
//                    self.fetchEventsTimer!.invalidate()
//                    self.fetchEventsTimer = nil
//                    NSLog("Fetched events successfully after \(self.repeatCount) attempt\(self.repeatCount == 1 ? "" : "s")")
//                    self.repeatCount = 1
//                }
//
//                if self.unfilteredEvents != eventList {
//
//                    self.unfilteredEvents = self.fixDates(eventList)
//                    self.featuredCollectionView.reloadData()
////                    createMockData()
//                }
//            case .failure(let error):
//                NSLog("\(#file):L\(#line): Configuration failed inside \(#function) with error: \(error)")
//            }
//        }
//    }
    
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
    private func shouldShowSearchView(_ bool: Bool, shouldAnimate: Bool = true) {
        searchView.shouldShowSearchView(bool, shouldAnimate: shouldAnimate)
    }
    
    private func updateFilterCount() {
        searchView.updateFilterCount(filter: currentFilter)
    }
    
    // MARK: - Helper Functions
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
    @IBAction func searchBarCancelButtonTapped(_ sender: UIButton) {
        searchBarCancelButtonClicked(eventSearchBar)
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
        }
        
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
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
            print(events.count)
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
            searchView.insertFilter(currentFilter)
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
        eventSearchBar.text = text
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
                eventSearchBar.becomeFirstResponder()
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

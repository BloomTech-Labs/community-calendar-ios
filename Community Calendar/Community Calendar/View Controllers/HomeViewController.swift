//
//  HomeViewController.swift
//  Community Calendar
//
//  Created by Jordan Christensen on 12/16/19.
//  Copyright © 2019 Mazjap Co. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    
    private let eventController = EventController()
    private var events: [Event]? {
        didSet {
            updateLists()
        }
    }
    var shouldDismissFilterScreen = true
    
    
    @IBOutlet private weak var featuredCollectionView: UICollectionView!
    @IBOutlet private weak var eventCollectionView: UICollectionView!
    @IBOutlet private weak var eventTableView: UITableView!

    @IBOutlet private weak var thisWeekendButton: UIButton!
    @IBOutlet private weak var allUpcomingButton: UIButton!
    @IBOutlet private weak var tomorrowButton: UIButton!
    @IBOutlet private weak var todayButton: UIButton!
    
    @IBOutlet private weak var collectionViewButton: UIButton!
    @IBOutlet private weak var tableViewButton: UIButton!
    @IBOutlet private weak var seperatorView: UIView!
    
    @IBOutlet private weak var dateLabel: UILabel!
    
    // MARK: - IBOutles for Search
    @IBOutlet private weak var searchBar: UISearchBar!
    @IBOutlet private weak var filterButton: UIButton!
    @IBOutlet private weak var nearbyButton: UIButton!
    @IBOutlet private weak var nearbyLabel: UILabel!
    @IBOutlet private weak var recentSearchesLabel: UILabel!
    @IBOutlet private weak var searchView: UIView!
    @IBOutlet private weak var searchBarCancelButton: UIButton!
    @IBOutlet private weak var searchBarTrailingConstraint: NSLayoutConstraint!
    @IBOutlet private var searchViewTopConstraint: NSLayoutConstraint! // Strong reference so that it wont be deallocated when setting new value
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchEvents()
        setUp()
//        printFonts()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        fetchEvents()
    }
    
    private func setUp() {
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
        todayTapped(UIButton())
        todayButton.titleLabel?.adjustsFontSizeToFitWidth = true
        tomorrowButton.titleLabel?.adjustsFontSizeToFitWidth = true
        thisWeekendButton.titleLabel?.adjustsFontSizeToFitWidth = true
        allUpcomingButton.titleLabel?.adjustsFontSizeToFitWidth = true
        
        updateViews()
    }
    
    private func updateViews() {
        setUpSearchBar()
        self.tabBarController?.tabBar.tintColor = .tabBarTint
        
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.font: UIFont(name: "Poppins", size: 10)!], for: .normal)
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.font: UIFont(name: "Poppins", size: 10)!], for: .selected)

        seperatorView.layer.cornerRadius = 3
        
        dateLabel.text = todayDateFormatter.string(from: Date())
        eventTableView.separatorColor = UIColor.clear
        
        searchBorderDesigns()
    }
    
    private func fetchEvents() {
        eventController.getEvents { result in
            switch result {
            case .success(let eventList):
                if let events = self.events, events != eventList {
                    self.events = eventList
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
        for family in UIFont.familyNames {
            let sName: String = family as String
            print("Family: \(sName)")
            for name in UIFont.fontNames(forFamilyName: sName) {
                print("Name: \(name as String)")
            }
        }
    }
    
    private func createAttrText(with title: String, color: UIColor, fontName: String) -> NSAttributedString {
        let font = UIFont(name: fontName, size: 14)
        let attrString = NSAttributedString(string: title,
            attributes: [NSAttributedString.Key.foregroundColor: color, NSAttributedString.Key.font: font ?? UIFont()])
        return attrString
    }
    
    // MARK: - Search Functions
    
    func shouldShowSearchView(_ bool: Bool, shouldAnimate: Bool = true) {
        searchViewTopConstraint.isActive = false
        if bool {
            searchViewTopConstraint = NSLayoutConstraint(item: searchView!, attribute: .top, relatedBy: .equal, toItem: searchBar, attribute: .bottom, multiplier: 1, constant: 3)
            
        } else {
            searchViewTopConstraint = NSLayoutConstraint(item: searchView!, attribute: .top, relatedBy: .equal, toItem: view, attribute: .bottom, multiplier: 1, constant: 0)
//            searchView.isHidden = true
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
        // MARK: - Filter Button Border
        filterButton.setTitleColor(UIColor(red: 0, green: 0, blue: 0, alpha: 0.5), for: .normal)
        filterButton.layer.cornerRadius = 29 / 1.6
        filterButton.layer.borderWidth = 1
        filterButton.layer.borderColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.5).cgColor
        
        // MARK: - Nearby Button Border
        nearbyButton.layer.backgroundColor = UIColor(red: 0.842, green: 0.842, blue: 0.842, alpha: 1).cgColor
        nearbyButton.layer.cornerRadius = 5
        nearbyButton.layer.borderWidth = 1
        nearbyButton.layer.borderColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.1).cgColor
        
        // MARK: - Nearby Label color
        nearbyLabel.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.6)
        
        // MARK: - Recent Searches Label Color
        recentSearchesLabel.textColor = UIColor(red: 0.129, green: 0.141, blue: 0.173, alpha: 1)
    }
    
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
    
    @IBAction func todayTapped(_ sender: UIButton) {
        todayButton.setAttributedTitle(createAttrText(with: "Today", color: .selectedButton, fontName: "Poppins-SemiBold"), for: .normal)
        tomorrowButton.setAttributedTitle(createAttrText(with: "Tomorrow", color: .unselectedDayButton, fontName: "Poppins-Light"), for: .normal)
        thisWeekendButton.setAttributedTitle(createAttrText(with: "This weekend", color: .unselectedDayButton, fontName: "Poppins-Light"), for: .normal)
        allUpcomingButton.setAttributedTitle(createAttrText(with: "All upcoming", color: .unselectedDayButton, fontName: "Poppins-Light"), for: .normal)
    }
    
    @IBAction func tomorrowTapped(_ sender: UIButton) {
        todayButton.setAttributedTitle(createAttrText(with: "Today", color: .unselectedDayButton, fontName: "Poppins-Light"), for: .normal)
        tomorrowButton.setAttributedTitle(createAttrText(with: "Tomorrow", color: .selectedButton, fontName: "Poppins-SemiBold"), for: .normal)
        thisWeekendButton.setAttributedTitle(createAttrText(with: "This weekend", color: .unselectedDayButton, fontName: "Poppins-Light"), for: .normal)
        allUpcomingButton.setAttributedTitle(createAttrText(with: "All upcoming", color: .unselectedDayButton, fontName: "Poppins-Light"), for: .normal)
    }
    
    @IBAction func thisWeekendTapped(_ sender: UIButton) {
        todayButton.setAttributedTitle(createAttrText(with: "Today", color: .unselectedDayButton, fontName: "Poppins-Light"), for: .normal)
        tomorrowButton.setAttributedTitle(createAttrText(with: "Tomorrow", color: .unselectedDayButton, fontName: "Poppins-Light"), for: .normal)
        thisWeekendButton.setAttributedTitle(createAttrText(with: "This weekend", color: .selectedButton, fontName: "Poppins-SemiBold"), for: .normal)
        allUpcomingButton.setAttributedTitle(createAttrText(with: "All upcoming", color: .unselectedDayButton, fontName: "Poppins-Light"), for: .normal)
    }
    
    @IBAction func allUpcomingTapped(_ sender: UIButton) {
        todayButton.setAttributedTitle(createAttrText(with: "Today", color: .unselectedDayButton, fontName: "Poppins-Light"), for: .normal)
        tomorrowButton.setAttributedTitle(createAttrText(with: "Tomorrow", color: .unselectedDayButton, fontName: "Poppins-Light"), for: .normal)
        thisWeekendButton.setAttributedTitle(createAttrText(with: "This weekend", color: .unselectedDayButton, fontName: "Poppins-Light"), for: .normal)
        allUpcomingButton.setAttributedTitle(createAttrText(with: "All upcoming", color: .selectedButton, fontName: "Poppins-SemiBold"), for: .normal)
    }
    
    // MARK: - IBAction for Search
    @IBAction func filterButtonTapped(_ sender: UIButton) {
        
    }
    
    @IBAction func nearByButtonTapped(_ sender: UIButton) {
        
    }
    
    @IBAction func searchBarCancelButtonTapped(_ sender: UIButton) {
        searchBarSearchButtonClicked(searchBar)
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
        }
    }
}

// MARK: - Extensions

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

extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return events?.count ?? 0
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
            let events = events else { return UICollectionViewCell() }
            
            cell.indexPath = indexPath
            cell.eventController = eventController
            cell.event = events[indexPath.row]
            
            return cell
        }
        return UICollectionViewCell()
    }
}

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
}


extension HomeViewController: UINavigationControllerDelegate {

    func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationController.Operation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        guard let view = self.navigationController?.view else { return nil }
        
        switch operation {
        case .push:
            if let _ = toVC as? FilterViewController {
                return CustomPushAnimator(view: view)
            } else {
                return nil
            }
        case .pop:
            return CustomPopAnimator(view: view)
        default:
            return nil
        }
    }
}

extension HomeViewController: FilterDelegate {
    func receive(filters: [Tag]) {
        _ = filters.map({ print($0.title) })
    }
}

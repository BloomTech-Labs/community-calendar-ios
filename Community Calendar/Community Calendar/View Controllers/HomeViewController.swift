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
    
    @IBOutlet weak var featuredCollectionView: UICollectionView!
    @IBOutlet weak var eventCollectionView: UICollectionView!
    @IBOutlet weak var collectionViewButton: UIButton!
    @IBOutlet weak var eventTableView: UITableView!
    @IBOutlet weak var thisWeekendButton: UIButton!
    @IBOutlet weak var allUpcomingButton: UIButton!
    @IBOutlet weak var tableViewButton: UIButton!
    @IBOutlet weak var tomorrowButton: UIButton!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var todayButton: UIButton!
    @IBOutlet weak var seperatorView: UIView!
    @IBOutlet weak var dateLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUp()
        dateLabel.text = todayDateFormatter.string(from: Date())
        eventTableView.separatorColor = UIColor.clear;
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        eventController.getEvents { result in
            switch result {
            case .success(let eventList):
                self.events = eventList
            case .failure(let error):
                NSLog("\(#file):L\(#line): Configuration failed inside \(#function) with error: \(error)")
            }
        }
    }
    
    private func setUp() {
        eventTableView.delegate = self
        eventTableView.dataSource = self
        eventTableView.showsVerticalScrollIndicator = false
        
        eventCollectionView.delegate = self
        eventCollectionView.dataSource = self
        eventCollectionView.showsVerticalScrollIndicator = false
        
        featuredCollectionView.delegate = self
        featuredCollectionView.dataSource = self
        featuredCollectionView.showsHorizontalScrollIndicator = false
        
        searchBar.delegate = self
        
        updateViews()
        
        tableViewButtonTapped(0)
        todayTapped(UIButton())
    }
    
    private func updateViews() {
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
        
        self.tabBarController?.tabBar.tintColor = .tabBarTint
        
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.font: UIFont(name: "Poppins", size: 10)!], for: .normal)
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.font: UIFont(name: "Poppins", size: 10)!], for: .selected)

        seperatorView.layer.cornerRadius = 3
        
        
//        // To test if fonts were added correctly: (Common mistakes: Incorrect/no target membership, not listed in info.plist)
//        for family in UIFont.familyNames {
//
//            let sName: String = family as String
//            print("family: \(sName)")
//
//            for name in UIFont.fontNames(forFamilyName: sName) {
//                print("name: \(name as String)")
//            }
//        }
    }
    
    private func updateLists() {
        eventTableView.reloadData()
        eventCollectionView.reloadData()
        featuredCollectionView.reloadData()
    }
    
    private func createAttrText(with title: String, color: UIColor, fontName: String) -> NSAttributedString {
        let font = UIFont(name: fontName, size: 14)
        let attrString = NSAttributedString(string: title,
                                            attributes: [NSAttributedString.Key.foregroundColor: color, NSAttributedString.Key.font: font ?? UIFont()])
        return attrString
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
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        searchBar.endEditing(true)
    }
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return events?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = eventTableView.dequeueReusableCell(withIdentifier: "EventTableViewCell", for: indexPath) as? EventTableViewCell,
        let events = events else { return UITableViewCell() }
            
        cell.event = events[indexPath.row]
        
        if let imageURL = events[indexPath.row].images.first {
            eventController.loadImage(for: imageURL, cache: nil) { result in
                switch result {
                case .failure:
                    NSLog("\(#file):L\(#line): Configuration failed inside \(#function)")
                case .success(let image):
                    DispatchQueue.main.async {
                        cell.eventImageView.image = image
                    }
                }
            }
        }
        
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        guard let detailVC = segue.destination as? EventDetailViewController else { return }
        if segue.identifier == "ShowFeaturedDetailSegue" {
            guard let indexPath = featuredCollectionView.indexPathsForSelectedItems?.first,
                let events = events else { return }
            detailVC.event = events[indexPath.row]
        } else if segue.identifier == "ShowEventsTableDetailSegue" {
            guard let indexPath = eventTableView.indexPathForSelectedRow,
                let events = events else { return }
            detailVC.event = events[indexPath.row]
        } else if segue.identifier == "ShowEventsCollectionDetailSegue" {
            guard let indexPath = eventCollectionView.indexPathsForSelectedItems?.first,
                let events = events else { return }
            detailVC.event = events[indexPath.row]
        }
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
            
            cell.event = events[indexPath.row]
            
            if let imageURL = events[indexPath.row].images.first {
                eventController.loadImage(for: imageURL, cache: nil) { result in
                    switch result {
                    case .failure:
                        NSLog("\(#file):L\(#line): Configuration failed inside \(#function)")
                    case .success(let image):
                        DispatchQueue.main.async {
                            cell.eventImageView.image = image
                        }
                    }
                }
            }
            
            return cell
            
        } else if collectionView == featuredCollectionView {
            guard let cell = featuredCollectionView.dequeueReusableCell(withReuseIdentifier: "FeaturedCell", for: indexPath) as? FeaturedCollectionViewCell,
            let events = events else { return UICollectionViewCell() }
            
            cell.event = events[indexPath.row]
            
            if let imageURL = events[indexPath.row].images.first {
                eventController.loadImage(for: imageURL, cache: nil) { result in
                    switch result {
                    case .failure:
                        NSLog("\(#file):L\(#line): Configuration failed inside \(#function)")
                    case .success(let image):
                        DispatchQueue.main.async {
                            cell.eventImageView.image = image
                        }
                    }
                }
            }
            
            return cell
        }
        return UICollectionViewCell()
    }
}

extension HomeViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.endEditing(true)
    }
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.endEditing(true)
    }
}

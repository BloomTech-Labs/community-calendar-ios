//
//  ViewController.swift
//  Community Calendar
//
//  Created by Jordan Christensen on 12/16/19.
//  Copyright © 2019 Mazjap Co. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    let events = [
        Event(title: "Sitting", description: "Come and sit", image: "peopleSitting", startDate: Date(), endDate: Date()),
        Event(title: "Watching TV", description: "Come and sit", image: "peopleSitting", startDate: Date(), endDate: Date()),
        Event(title: "Watch a Movie", description: "Come and sit", image: "peopleSitting", startDate: Date(), endDate: Date()),
        Event(title: "Watch a Play", description: "Come and sit", image: "peopleSitting", startDate: Date(), endDate: Date()),
        Event(title: "Talking While Sitting", description: "Come and sit", image: "peopleSitting", startDate: Date(), endDate: Date()),
        Event(title: "Getting a Masage", description: "Come and sit", image: "peopleSitting", startDate: Date(), endDate: Date()),
        Event(title: "Singing While Sitting", description: "Come and sit", image: "peopleSitting", startDate: Date(), endDate: Date()),
        Event(title: "Sitting", description: "Come and sit", image: "peopleSitting", startDate: Date(), endDate: Date())
    ]
    
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
        
        self.tabBarController?.tabBar.layer.shadowColor = UIColor.gray.cgColor
        self.tabBarController?.tabBar.layer.shadowOpacity = 1.0
        self.tabBarController?.tabBar.layer.shadowRadius = 5
        self.tabBarController?.tabBar.layer.shadowOffset = CGSize(width: 0, height: 1)
        self.tabBarController?.tabBar.tintColor = UIColor.selectedButton
        
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.font: UIFont(name: "Poppins", size: 10)!], for: .normal)
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.font: UIFont(name: "Poppins", size: 10)!], for: .selected)

        
        
        seperatorView.layer.cornerRadius = 3
    }
    
    private func createAttrText(with title: String, color: UIColor) -> NSAttributedString {
        let textColor = NSAttributedString(string: title,
        attributes: [NSAttributedString.Key.foregroundColor: color])
        return textColor
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
        todayButton.setAttributedTitle(createAttrText(with: "Today", color: .selectedButton), for: .normal)
        tomorrowButton.setAttributedTitle(createAttrText(with: "Tomorrow", color: .unselectedDayButton), for: .normal)
        thisWeekendButton.setAttributedTitle(createAttrText(with: "This weekend", color: .unselectedDayButton), for: .normal)
        allUpcomingButton.setAttributedTitle(createAttrText(with: "All upcoming", color: .unselectedDayButton), for: .normal)
    }
    
    @IBAction func tomorrowTapped(_ sender: UIButton) {
        todayButton.setAttributedTitle(createAttrText(with: "Today", color: .unselectedDayButton), for: .normal)
        tomorrowButton.setAttributedTitle(createAttrText(with: "Tomorrow", color: .selectedButton), for: .normal)
        thisWeekendButton.setAttributedTitle(createAttrText(with: "This weekend", color: .unselectedDayButton), for: .normal)
        allUpcomingButton.setAttributedTitle(createAttrText(with: "All upcoming", color: .unselectedDayButton), for: .normal)
    }
    
    @IBAction func thisWeekendTapped(_ sender: UIButton) {
        todayButton.setAttributedTitle(createAttrText(with: "Today", color: .unselectedDayButton), for: .normal)
        tomorrowButton.setAttributedTitle(createAttrText(with: "Tomorrow", color: .unselectedDayButton), for: .normal)
        thisWeekendButton.setAttributedTitle(createAttrText(with: "This weekend", color: .selectedButton), for: .normal)
        allUpcomingButton.setAttributedTitle(createAttrText(with: "All upcoming", color: .unselectedDayButton), for: .normal)
    }
    
    @IBAction func allUpcomingTapped(_ sender: UIButton) {
        todayButton.setAttributedTitle(createAttrText(with: "Today", color: .unselectedDayButton), for: .normal)
        tomorrowButton.setAttributedTitle(createAttrText(with: "Tomorrow", color: .unselectedDayButton), for: .normal)
        thisWeekendButton.setAttributedTitle(createAttrText(with: "This weekend", color: .unselectedDayButton), for: .normal)
        allUpcomingButton.setAttributedTitle(createAttrText(with: "All upcoming", color: .selectedButton), for: .normal)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        searchBar.endEditing(true)
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return events.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = eventTableView.dequeueReusableCell(withIdentifier: "EventTableViewCell", for: indexPath) as? EventTableViewCell else { return UITableViewCell() }
            
        cell.event = events[indexPath.row]
            
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        eventTableView.deselectRow(at: indexPath, animated: true)
    }
}

extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return events.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == eventCollectionView {
            guard let cell = eventCollectionView.dequeueReusableCell(withReuseIdentifier: "EventCollectionViewCell", for: indexPath) as? EventCollectionViewCell else { return UICollectionViewCell() }
            
            cell.event = events[indexPath.row]
            
            return cell
            
        } else if collectionView == featuredCollectionView {
            guard let cell = featuredCollectionView.dequeueReusableCell(withReuseIdentifier: "FeaturedCell", for: indexPath) as? FeaturedCollectionViewCell else { return UICollectionViewCell() }
            
            cell.event = events[indexPath.row]
            
            return cell
        }
        return UICollectionViewCell()
    }
}

extension ViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.endEditing(true)
    }
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.endEditing(true)
    }
}

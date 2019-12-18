//
//  ViewController.swift
//  Community Calendar
//
//  Created by Jordan Christensen on 12/16/19.
//  Copyright © 2019 Mazjap Co. All rights reserved.
//

import UIKit

let dateFormatter: DateFormatter = {
    let df = DateFormatter()
    df.dateFormat = "EEEE, MMMM d, yyyy"
    return df
}()

class ViewController: UIViewController {
    let events = [
        Event(title: "Sitting", description: "Come and sit", image: "peopleSitting", startDate: Date(), endDate: Date()),
        Event(title: "Sitting", description: "Come and sit", image: "peopleSitting", startDate: Date(), endDate: Date()),
        Event(title: "Sitting", description: "Come and sit", image: "peopleSitting", startDate: Date(), endDate: Date()),
        Event(title: "Sitting", description: "Come and sit", image: "peopleSitting", startDate: Date(), endDate: Date()),
        Event(title: "Sitting", description: "Come and sit", image: "peopleSitting", startDate: Date(), endDate: Date()),
        Event(title: "Sitting", description: "Come and sit", image: "peopleSitting", startDate: Date(), endDate: Date()),
        Event(title: "Sitting", description: "Come and sit", image: "peopleSitting", startDate: Date(), endDate: Date()),
        Event(title: "Sitting", description: "Come and sit", image: "peopleSitting", startDate: Date(), endDate: Date())
    ]
    
    @IBOutlet weak var featuredCollectionView: UICollectionView!
    @IBOutlet weak var eventCollectionView: UICollectionView!
    @IBOutlet weak var eventTableView: UITableView!
    @IBOutlet weak var tableViewButton: UIButton!
    @IBOutlet weak var collectionViewButton: UIButton!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var todayButton: UIButton!
    @IBOutlet weak var tomorrowButton: UIButton!
    @IBOutlet weak var thisWeekendButton: UIButton!
    @IBOutlet weak var allUpcomingButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
        dateLabel.text = dateFormatter.string(from: Date())
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
        tableViewButtonTapped(0)
        todayTapped(UIButton())
    }
    
    private func createAttrText(with title: String, color: UIColor) -> NSAttributedString {
        let textColor = NSAttributedString(string: title,
        attributes: [NSAttributedString.Key.foregroundColor: color])
        return textColor
    }
    
    @IBAction func tableViewButtonTapped(_ sender: Any) {
        eventCollectionView.isHidden = true
        eventTableView.isHidden = false
        tableViewButton.tintColor = .selectedButton
        collectionViewButton.tintColor = .unselectedButton
    }
    
    @IBAction func collectionViewButtonTapped(_ sender: Any) {
        eventCollectionView.isHidden = false
        eventTableView.isHidden = true
        tableViewButton.tintColor = .unselectedButton
        collectionViewButton.tintColor = .selectedButton
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

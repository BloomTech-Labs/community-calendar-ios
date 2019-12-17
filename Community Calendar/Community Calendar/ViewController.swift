//
//  ViewController.swift
//  Community Calendar
//
//  Created by Jordan Christensen on 12/16/19.
//  Copyright © 2019 Mazjap Co. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UICollectionViewDelegate, UICollectionViewDataSource {
    let events = [Event(title: "Eating Cheetos", description: "Come and eat cheetos", image: "Cheetos", startDate: Date(), endDate: Date()), Event(title: "Eating Cheetos", description: "Come and eat cheetos", image: "Cheetos", startDate: Date(), endDate: Date()), Event(title: "Eating Cheetos", description: "Come and eat cheetos", image: "Cheetos", startDate: Date(), endDate: Date())]
    
    @IBOutlet weak var featuredCollectionView: UICollectionView!
    @IBOutlet weak var eventCollectionView: UICollectionView!
    @IBOutlet weak var eventTableView: UITableView!
    @IBOutlet weak var tableViewButton: UIButton!
    @IBOutlet weak var collectionViewButton: UIButton!
    @IBOutlet weak var filterSegmentedControl: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        eventTableView.delegate = self
        eventCollectionView.delegate = self
        eventTableView.dataSource = self
        eventCollectionView.dataSource = self
        
//        eventTableView.rowHeight = 76
        eventTableView.separatorColor = UIColor.clear;
        
        tableViewButtonTapped(0)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return events.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = eventTableView.dequeueReusableCell(withIdentifier: "EventTableViewCell", for: indexPath) as? EventTableViewCell else { return UITableViewCell() }
        
        cell.event = events[indexPath.row]
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return events.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = eventCollectionView.dequeueReusableCell(withReuseIdentifier: "EventCollectionViewCell", for: indexPath) as? EventCollectionViewCell else { return UICollectionViewCell() }
        
        cell.event = events[indexPath.row]
        
        return cell
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
}


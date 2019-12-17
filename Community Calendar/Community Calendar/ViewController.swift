//
//  ViewController.swift
//  Community Calendar
//
//  Created by Jordan Christensen on 12/16/19.
//  Copyright © 2019 Mazjap Co. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var featuredCollectionView: UICollectionView!
    @IBOutlet weak var eventCollectionView: UICollectionView!
    @IBOutlet weak var eventTableView: UITableView!
    @IBOutlet weak var tableViewButton: UIButton!
    @IBOutlet weak var collectionViewButton: UIButton!
    @IBOutlet weak var filterSegmentedControl: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableViewButtonTapped(0)
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


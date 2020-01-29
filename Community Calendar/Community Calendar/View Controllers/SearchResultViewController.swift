//
//  SearchResultViewController.swift
//  Community Calendar
//
//  Created by Jordan Christensen on 1/30/20.
//  Copyright © 2020 Mazjap Co. All rights reserved.
//

import UIKit

class SearchResultViewController: UIViewController {
    var eventController: EventController?
    var events: [Event]? {
        didSet {
            updateViews()
        }
    }
    var filter: Filter? {
        didSet {
            fetchFilteredEvents()
        }
    }
    
    @IBOutlet private weak var eventResultsCollectionView: UICollectionView!
    @IBOutlet private weak var eventResultsTableView: UITableView!
    
    @IBOutlet weak var goBackButton: UIButton!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet private weak var collectionViewButton: UIButton!
    @IBOutlet private weak var tableViewButton: UIButton!
    @IBOutlet private weak var seperatorView: UIView!
    @IBOutlet private weak var filterLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        eventResultsCollectionView.delegate = self
        eventResultsCollectionView.dataSource = self
        
        eventResultsTableView.delegate = self
        eventResultsTableView.dataSource = self
        
        updateViews()
        eventResultsCollectionView.isHidden = true
    }
    
    private func updateViews() {
        guard let _ = events, isViewLoaded else { return }
        eventResultsCollectionView.reloadData()
        eventResultsTableView.reloadData()
    }

    private func fetchFilteredEvents() {
        guard let filter = filter, let eventController = eventController else { return }
        eventController.getEvents(by: filter) { result in
            switch result {
            case .success(let filteredEvents):
                self.events = filteredEvents
            case .failure(let error):
                NSLog("\(#file):L\(#line): Configuration failed inside \(#function) with error: \(error)")
            }
        }
    }
    
    @IBAction func goBackPressed(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func tableViewPressed(_ sender: UIButton) {
        eventResultsTableView.isHidden = false
        eventResultsCollectionView.isHidden = true
    }
    
    @IBAction func collectionViewPressed(_ sender: UIButton) {
        eventResultsTableView.isHidden = true
        eventResultsCollectionView.isHidden = false
    }
}

extension SearchResultViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return events?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = eventResultsCollectionView.dequeueReusableCell(withReuseIdentifier: "EventCollectionViewCell", for: indexPath) as? EventCollectionViewCell,
        let events = events else { return UICollectionViewCell() }
        
        cell.indexPath = indexPath
        cell.eventController = eventController
        cell.event = events[indexPath.row]
        
        return cell
    }
}

extension SearchResultViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return events?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = eventResultsTableView.dequeueReusableCell(withIdentifier: "EventTableViewCell", for: indexPath) as? EventTableViewCell,
        let events = events else { return UITableViewCell() }
        
        cell.indexPath = indexPath
        cell.eventController = eventController
        cell.event = events[indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        eventResultsTableView.deselectRow(at: indexPath, animated: true)
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
            self.eventResultsTableView.deleteRows(at: [indexPath], with: .fade)
        }
        hideAction.backgroundColor = UIColor.blue
        let configuration = UISwipeActionsConfiguration(actions: [hideAction])
        return configuration
    }
}

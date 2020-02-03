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
            setFilterLabel()
            fetchFilteredEvents()
        }
    }
    var searchBar: UISearchBar?
    
    @IBOutlet private weak var eventResultsCollectionView: UICollectionView!
    @IBOutlet private weak var eventResultsTableView: UITableView!
    
    @IBOutlet weak var goBackButton: UIButton!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet private weak var collectionViewButton: UIButton!
    @IBOutlet private weak var tableViewButton: UIButton!
    @IBOutlet private weak var seperatorView: UIView!
    @IBOutlet private weak var filterLabel: UILabel!
    @IBOutlet weak var noResultsLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
        updateViews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        fetchFilteredEvents()
    }
    
    private func updateViews() {
        guard isViewLoaded else { return }
        eventResultsTableView.separatorColor = UIColor.clear
        
        guard let _ = events, isViewLoaded else { return }
        eventResultsCollectionView.reloadData()
        eventResultsTableView.reloadData()
        
        setFilterLabel()
    }
    
    private func setUp() {
        eventResultsCollectionView.delegate = self
        eventResultsCollectionView.dataSource = self
        
        eventResultsTableView.delegate = self
        eventResultsTableView.dataSource = self
        eventResultsTableView.showsVerticalScrollIndicator = false
        
        tableViewPressed(UIButton())
        
        noResultsLabel.isHidden = true
        
        updateViews()
        eventResultsCollectionView.isHidden = true
        
        navigationController?.interactivePopGestureRecognizer?.delegate = self
    }

    private func fetchFilteredEvents() {
        guard let filter = filter, let eventController = eventController else { return }
        eventController.getEvents(by: filter) { result in
            switch result {
            case .success(let filteredEvents):
                self.events = filteredEvents
                if self.events?.count == 0 {
                    DispatchQueue.main.async {
                        self.noResultsLabel.isHidden = false
                    }
                }
            case .failure(let error):
                NSLog("\(#file):L\(#line): Configuration failed inside \(#function) with error: \(error)")
            }
        }
    }
    
    private func setFilterLabel() {
        guard let filter = filter, let filterLabel = filterLabel else { return }
        filterLabel.text = ""
        if filter.index != nil {
            filterLabel.text = "By term \"\(filter.index!)\""
        } else if filter.dateRange != nil {
            filterLabel.text = "By dates \(filterDateFormatter.string(from: filter.dateRange!.min)) - \(filterDateFormatter.string(from: filter.dateRange!.max))"
        } else if filter.tags != nil {
            filterLabel.text = "By tag"
            if filter.tags!.count != 1 {
                filterLabel.text = "\(filterLabel.text ?? "")s"
            }
            if filter.tags!.count >= 3 {
                filterLabel.text = "\(filterLabel.text ?? "") \"\(filter.tags![0].title)\", \"\(filter.tags![1].title)\", \"\(filter.tags![2].title)\""
            } else {
                for tagIndex in 0..<filter.tags!.count {
                    if tagIndex == filter.tags!.count - 1 {
                        filterLabel.text = "\(filterLabel.text ?? "") \"\(filter.tags![tagIndex].title)\""
                    } else {
                        filterLabel.text = "\(filterLabel.text ?? "") \"\(filter.tags![tagIndex].title)\","
                    }
                }
            }
        } else if filter.location != nil {
            filterLabel.text = "By district \(filter.location!.name)"
        }
    }
    
    @IBAction func goBackPressed(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
        guard let toVC = navigationController?.topViewController as? HomeViewController else { return }
        toVC.setSearchBarText()
    }
    
    @IBAction func tableViewPressed(_ sender: UIButton) {
        eventResultsCollectionView.isHidden = true
        eventResultsTableView.isHidden = false
        tableViewButton.imageView?.image = UIImage(named: "list-selected")
        collectionViewButton.imageView?.image = UIImage(named: "grid")
    }
    
    @IBAction func collectionViewPressed(_ sender: UIButton) {
        eventResultsTableView.isHidden = true
        eventResultsCollectionView.isHidden = false
        tableViewButton.imageView?.image = UIImage(named: "list")
        collectionViewButton.imageView?.image = UIImage(named: "grid-selected")
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let detailVC = segue.destination as? EventDetailViewController else { return }
        detailVC.eventController = eventController
        if segue.identifier == "ShowDetailFromTable" {
            guard let indexPath = eventResultsTableView.indexPathForSelectedRow else { return }
            detailVC.event = events?[indexPath.row]
        } else if segue.identifier == "ShowDetailFromCollection" {
            guard let indexPaths = eventResultsCollectionView.indexPathsForSelectedItems, let indexPath = indexPaths.first else { return }
            detailVC.event = events?[indexPath.row]
        }
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

extension SearchResultViewController: UIGestureRecognizerDelegate, UINavigationControllerDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldBeRequiredToFailBy otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
    
    
}

//
//  SearchView.swift
//  Community Calendar
//
//  Created by Jordan Christensen on 2/6/20.
//  Copyright © 2020 Lambda School All rights reserved.
//

import UIKit
import CoreLocation

class SearchView: UIView, ControllerDelegate {
    //MARK: - Variables
    var homeVC: HomeViewController!
    var controller: Controller?
    private var recentFiltersList = [Filter]() {
        didSet {
            recentSearchesTableView.reloadData()
        }
    }
    
    //MARK: - IBOutlets
    @IBOutlet private weak var filterButton: UIButton!
    @IBOutlet private weak var nearbyButton: UIButton!
    @IBOutlet private weak var nearbyLabel: UILabel!
    @IBOutlet private weak var recentSearchesLabel: UILabel!
    @IBOutlet private weak var recentSearchesTableView: UITableView!
    @IBOutlet private var searchViewTopConstraint: NSLayoutConstraint!      // Strong reference so that it wont be deallocated when setting new value
    @IBOutlet private var searchViewBottomConstraint: NSLayoutConstraint!   // ^
    
    //MARK: - Public Functions
    override func layoutIfNeeded() {
        updateViews()
    }
    
    func setUp() {
        translatesAutoresizingMaskIntoConstraints = false
        translatesAutoresizingMaskIntoConstraints = false
        
        recentSearchesTableView.delegate = self
        recentSearchesTableView.dataSource = self
        
        recentSearchesTableView.separatorColor = .clear
        recentSearchesTableView.showsVerticalScrollIndicator = false
    }
    
    func shouldShowSearchView(_ bool: Bool, shouldAnimate: Bool = true) {
        searchViewTopConstraint.isActive = false
        
        if bool {
            searchViewTopConstraint = NSLayoutConstraint(item: self, attribute: .top, relatedBy: .equal, toItem: homeVC.eventSearchBar, attribute: .bottom, multiplier: 1, constant: 3)
        } else {
            searchViewTopConstraint = NSLayoutConstraint(item: self, attribute: .top, relatedBy: .equal, toItem: homeVC.view, attribute: .bottom, multiplier: 1, constant: 0)
        }
        searchViewTopConstraint.isActive = true
        searchViewBottomConstraint.isActive = bool
        
        if shouldAnimate {
            UIView.animate(withDuration: 0.5) {
                self.layoutIfNeeded()
            }
        } else {
            layoutIfNeeded()
        }
    }
    
    func updateFilterCount(filter: Filter?) {
        guard let currentFilter = filter else {
            filterButton.text("Filters")
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
        if currentFilter.zipCode != nil {
            filterCount += 1
        }
        if currentFilter.ticketPrice != nil {
            filterCount += 1
        }
        if currentFilter.tags != nil {
            filterCount += currentFilter.tags?.count ?? 0
        }
        filterButton.text("Filters\(filterCount == 0 ? "" : "(\(filterCount))")")
    }
    
    func insertFilter(_ filter: Filter) {
        recentFiltersList.insert(filter, at: 0)
    }
    
    // MARK: - Private Functions
    private func searchBorderDesigns() {
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
    
    private func updateViews() {
        searchBorderDesigns()
        
        if let controller = controller {
            recentFiltersList = controller.loadFromPersistantStore()
        }
        recentSearchesTableView.reloadData()
    }
    
    private func setUpLocation() -> Bool {
        var alert: UIAlertController?
        switch CLLocationManager.authorizationStatus() {
        case .authorizedAlways, .authorizedWhenInUse:
            return true
        case .denied:
            alert = UIAlertController(title: "Location disabled", message: "Please turn on location services in settings", preferredStyle: .alert)
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
            let openSettings = UIAlertAction(title: "Settings", style: .default) { action in
                let url: URL = self.getURL()
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            }
            alert?.addAction(cancelAction)
            alert?.addAction(openSettings)
        case .notDetermined:
            controller?.locationManager.requestWhenInUseAuthorization()
        case .restricted:
            alert = UIAlertController(title: "You are restricted", message: "Please request access from restrictor (generally from parental or administrative controls)", preferredStyle: .alert)
            alert?.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
        @unknown default:
            return false
        }
        
        if let alert = alert {
            homeVC.present(alert, animated: true)
        }
        
        return false
    }
    
    private func getURL() -> URL {
        if let bundleId = Bundle.main.bundleIdentifier, CLLocationManager.locationServicesEnabled() {
            // Attempt to open apps location preferences. Doesn't work, just opens settings
            return URL(string: "\(UIApplication.openSettingsURLString)&path=LOCATION/\(bundleId)")!
        }
        return URL(string: UIApplication.openSettingsURLString)!
    }
    
    //MARK: - IBActions
    @IBAction func nearByButtonTapped(_ sender: UIButton) {
        if setUpLocation() {
            homeVC.currentFilter = nil
        }
    }
}

// MARK: - Table View Extension
extension SearchView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recentFiltersList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
           guard let cell = recentSearchesTableView.dequeueReusableCell(withIdentifier: "RecentSearchCell", for: indexPath) as? RecentSearchesTableViewCell else { return UITableViewCell() }
           
           cell.filter = recentFiltersList[indexPath.row]
           
           return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        homeVC.currentFilter = recentFiltersList[indexPath.row]
        homeVC.performSegue(withIdentifier: "ShowSearchResultsSegue", sender: self)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let filter = recentFiltersList[indexPath.row]
            if controller?.remove(filter: filter) ?? false {
                recentFiltersList.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .automatic)
            }
        }
    }
}

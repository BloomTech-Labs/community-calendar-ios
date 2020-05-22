//
//  HomeVC+Ext.swift
//  Community Calendar
//
//  Created by Michael on 5/9/20.
//  Copyright © 2020 Mazjap Co. All rights reserved.
//

import UIKit

extension HomeViewController: UITableViewDelegate, UITableViewDataSource, UICollectionViewDelegate, UICollectionViewDataSource, UISearchBarDelegate, UINavigationControllerDelegate {
    
    // MARK: - UICollectionView Delegate & Data Source Methods
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == eventCollectionView {
            
            return self.filteredEvents?.count ?? 0

        } else if collectionView == featuredCollectionView {

            return events?.count ?? 0
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == eventCollectionView {
            guard let cell = eventCollectionView.dequeueReusableCell(withReuseIdentifier: "EventCollectionViewCell", for: indexPath) as? EventCollectionViewCell else { return UICollectionViewCell() }
            
            let event = filteredEvents?[indexPath.item]
            loadImageCV(forCell: cell, forItemAt: indexPath)
            cell.event = event
            
            return cell
            
        } else if collectionView == featuredCollectionView {
            guard let cell = featuredCollectionView.dequeueReusableCell(withReuseIdentifier: "FeaturedCell", for: indexPath) as? FeaturedCollectionViewCell else { return UICollectionViewCell() }
 
            cell.event = events?[indexPath.item]
            loadImageFT(forCell: cell, forItemAt: indexPath)
            
            return cell
        }
        return UICollectionViewCell()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == eventTableView {
            
            return filteredEvents?.count ?? 0

        }
        return 0
    }
    
    // MARK: - UITableView Delegate & Data Source Methods
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == eventTableView {
            guard let cell = eventTableView.dequeueReusableCell(withIdentifier: "EventTableViewCell", for: indexPath) as? EventTableViewCell
                else { return UITableViewCell() }
            
            let event = filteredEvents?[indexPath.row]
            loadImageTV(forCell: cell, forItemAt: indexPath)
            cell.event = event
            
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
//                self.events?.remove(at: indexPath.row)
                self.eventTableView.deleteRows(at: [indexPath], with: .fade)
            }
            hideAction.backgroundColor = UIColor.blue
            let configuration = UISwipeActionsConfiguration(actions: [hideAction])
            return configuration
        }
        return nil
    }
    
    // MARK: - UISearchBar Delegate Methods
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        shouldShowSearchView(true)
        searchBarBackgroundView.backgroundColor = .systemBackground
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
            //            controller?.save(filteredSearch: currentFilter)
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
    
    // MARK: - UINavigationController Delegate Methods
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
    
    func loadImageTV(forCell cell: EventTableViewCell, forItemAt indexPath: IndexPath) {
        guard let event = filteredEvents?[indexPath.item] else { return }
        
        if let cachedImage = cache.value(for: event.id) {
            cell.eventImageView?.image = cachedImage
            return
        }
        
        let fetchOp = FilteredEventPhotoOperation(event: event)
        let cacheOp = BlockOperation {
            if let image = fetchOp.image {
                self.cache.cache(value: image, for: event.id)
            }
        }
        let completionOp = BlockOperation {
            defer { self.operations.removeValue(forKey: event.id) }
            
            if let currentIndexPath = self.eventTableView.indexPath(for: cell),
                currentIndexPath != indexPath {
                return
            }
            
            if let image = fetchOp.image {
                cell.eventImageView?.image = image
            }
        }
        
        cacheOp.addDependency(fetchOp)
        completionOp.addDependency(fetchOp)
        
        photoFetchQueue.addOperation(fetchOp)
        photoFetchQueue.addOperation(cacheOp)
        OperationQueue.main.addOperation(completionOp)
        
        operations[event.id] = fetchOp
    }
    
    func loadImageCV(forCell cell: EventCollectionViewCell, forItemAt indexPath: IndexPath) {
        guard let event = filteredEvents?[indexPath.item] else { return }
        
        if let cachedImage = cache.value(for: event.id) {
            cell.eventImageView?.image = cachedImage
            return
        }
        
        let fetchOp = FilteredEventPhotoOperation(event: event)
        let cacheOp = BlockOperation {
            if let image = fetchOp.image {
                self.cache.cache(value: image, for: event.id)
            }
        }
        let completionOp = BlockOperation {
            defer { self.operations.removeValue(forKey: event.id) }
            
            if let currentIndexPath = self.eventCollectionView.indexPath(for: cell),
                currentIndexPath != indexPath {
                return
            }
            
            if let image = fetchOp.image {
                cell.eventImageView?.image = image
            }
        }
        
        cacheOp.addDependency(fetchOp)
        completionOp.addDependency(fetchOp)
        
        photoFetchQueue.addOperation(fetchOp)
        photoFetchQueue.addOperation(cacheOp)
        OperationQueue.main.addOperation(completionOp)
        
        operations[event.id] = fetchOp
    }
    
    func loadImageFT(forCell cell: FeaturedCollectionViewCell, forItemAt indexPath: IndexPath) {
        guard let event = events?[indexPath.item] else { return }
        
        if let cachedImage = cache.value(for: event.id) {
            cell.eventImageView?.image = cachedImage
            return
        }
        
        let fetchOp = FilteredEventPhotoOperation(event: event)
        let cacheOp = BlockOperation {
            if let image = fetchOp.image {
                self.cache.cache(value: image, for: event.id)
            }
        }
        let completionOp = BlockOperation {
            defer { self.operations.removeValue(forKey: event.id) }
            
            if let currentIndexPath = self.featuredCollectionView.indexPath(for: cell),
                currentIndexPath != indexPath {
                return
            }
            
            if let image = fetchOp.image {
                cell.eventImageView?.image = image
            }
        }
        
        cacheOp.addDependency(fetchOp)
        completionOp.addDependency(fetchOp)
        
        photoFetchQueue.addOperation(fetchOp)
        photoFetchQueue.addOperation(cacheOp)
        OperationQueue.main.addOperation(completionOp)
        
        operations[event.id] = fetchOp
    }
}



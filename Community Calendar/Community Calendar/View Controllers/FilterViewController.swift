//
//  FilterViewController.swift
//  Community Calendar
//
//  Created by Jordan Christensen on 1/15/20.
//  Copyright © 2020 Mazjap Co. All rights reserved.
//

import UIKit

protocol FilterDelegate {
    func receive(filters: [String])
}

class FilterViewController: UIViewController {
    
    @IBOutlet weak var exitButton: UIButton!
    @IBOutlet weak var tagsSearchBar: UISearchBar!
    @IBOutlet weak var applyButton: UIButton!
    @IBOutlet weak var selectedTagsCollectionView: UICollectionView!
    @IBOutlet weak var suggestedTagsCollectionView: UICollectionView!
    
    var delegate: FilterDelegate?
    
    var selectedFilters = [String]()
    var suggestedFilters = [String]()
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        .lightContent
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateViews()
        
        selectedTagsCollectionView.delegate = self
        selectedTagsCollectionView.dataSource = self
        
        suggestedTagsCollectionView.delegate = self
        suggestedTagsCollectionView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        addSuggestedFilters()
    }
    
    private func updateViews() {
        setUpSearchBar()
        applyButton.layer.cornerRadius = 6
    }
    
    private func setUpSearchBar() {
        tagsSearchBar.backgroundColor = .white
        tagsSearchBar.setBackgroundImage(UIImage(), for: .any, barMetrics: .default)
        tagsSearchBar.setImage(UIImage(named: "magnifying-glass"), for: .search, state: .normal)
        tagsSearchBar.isTranslucent = true
        tagsSearchBar.searchTextField.backgroundColor = .clear
        tagsSearchBar.layer.cornerRadius = 4
        tagsSearchBar.layer.borderColor = UIColor(red: 0.13, green: 0.14, blue: 0.17, alpha: 1.0).cgColor
        tagsSearchBar.layer.borderWidth = 1
        tagsSearchBar.searchTextField.placeholder = ""
        if let font = UIFont(name: "Poppins-Medium", size: 14.0) {
            tagsSearchBar.searchTextField.attributedPlaceholder = NSAttributedString(string: "Search for tags", attributes: [
                NSAttributedString.Key.font: font,
                NSAttributedString.Key.foregroundColor: UIColor.lightGray
            ])
            tagsSearchBar.searchTextField.font = font
        } else {
            tagsSearchBar.searchTextField.placeholder = "Search for tags"
        }
    }
    
    private func addSuggestedFilters() {
        // TODO: Get data from back end or show recent or most used filters. Alternatively use CoreML to learn what kind of filters the user likes and suggest new and used ones appropriately.
        suggestedFilters = ["Cooking", "Tech", "Reading", "Health & Wellness"]
    }
    
    @IBAction func exitTapped(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func applyFilters(_ sender: UIButton) {
        delegate?.receive(filters: ["hi!"])
        navigationController?.popViewController(animated: true)
    }
}

extension FilterViewController: UICollectionViewDelegate, UICollectionViewDataSource, FilterCellDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == selectedTagsCollectionView {
            return selectedFilters.count
        } else if collectionView == suggestedTagsCollectionView {
            return suggestedFilters.count
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == selectedTagsCollectionView {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SelectedFilterCell", for: indexPath) as? TagCollectionViewCell else { return UICollectionViewCell() }
            cell.tagName = selectedFilters[indexPath.row]
            cell.isActive = true
            cell.delegate = self
            return cell
        } else if collectionView == suggestedTagsCollectionView {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SuggestedFilterCell", for: indexPath) as? TagCollectionViewCell else { return UICollectionViewCell() }
            cell.tagName = suggestedFilters[indexPath.row]
            cell.isActive = false
            cell.delegate = self
            return cell
        }
        return UICollectionViewCell()
    }
    
    func buttonTapped(cell: TagCollectionViewCell) {
        if cell.isActive {
            guard let indexPath = selectedTagsCollectionView.indexPath(for: cell) else { return }
            for i in 0..<selectedFilters.count {
                if selectedFilters[i] == cell.tagName {
                    selectedFilters.remove(at: i); break
                }
            }
            selectedTagsCollectionView.deleteItems(at: [indexPath])
        } else {
            guard let indexPath = suggestedTagsCollectionView.indexPath(for: cell) else { return }
            for i in 0..<suggestedFilters.count {
                if suggestedFilters[i] == cell.tagName {
                    suggestedFilters.remove(at: i); break
                }
            }
            selectedFilters.append(cell.tagName ?? "NO NAME")
            selectedTagsCollectionView.deleteItems(at: [indexPath])
        }
    }
}

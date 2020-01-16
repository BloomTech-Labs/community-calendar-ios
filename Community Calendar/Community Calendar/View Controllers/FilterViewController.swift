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

    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateViews()
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
        tagsSearchBar.layer.borderWidth = 2
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
    
    
    @IBAction func exitTapped(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func applyFilters(_ sender: UIButton) {
        delegate?.receive(filters: ["hi!"])
        navigationController?.popViewController(animated: true)
    }
}

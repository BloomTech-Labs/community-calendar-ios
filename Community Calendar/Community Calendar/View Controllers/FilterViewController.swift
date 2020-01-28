//
//  FilterViewController.swift
//  Community Calendar
//
//  Created by Jordan Christensen on 1/15/20.
//  Copyright © 2020 Mazjap Co. All rights reserved.
//

import UIKit

protocol FilterDelegate {
    func receive(filters: Filter)
}

class FilterViewController: UIViewController {
    // MARK: - Varibles
    var delegate: FilterDelegate?
    var selectedFilters = [Tag]()
    var suggestedFilters = [Tag]()
    var isEditingTag: Bool = false
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        .lightContent
    }
    
    // MARK: - IBOutlets
    @IBOutlet weak var exitButton: UIButton!
    @IBOutlet weak var tagsSearchBar: UISearchBar!
    @IBOutlet weak var applyButton: UIButton!
    @IBOutlet weak var selectedTagsCollectionView: UICollectionView!
    @IBOutlet weak var suggestedTagsCollectionView: UICollectionView!

    // MARK: - Lifecycle Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateViews()
        
        selectedTagsCollectionView.delegate = self
        selectedTagsCollectionView.dataSource = self
        
        suggestedTagsCollectionView.delegate = self
        suggestedTagsCollectionView.dataSource = self
        
        let layout = LeftAlignedCollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 16
        layout.minimumLineSpacing = 16
        suggestedTagsCollectionView.collectionViewLayout = layout
        
        tagsSearchBar.delegate = self
        tagsSearchBar.returnKeyType = .done
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        addSuggestedFilters()
    }
    
    // MARK: - Functions
    private func updateViews() {
        setUpSearchBar()
        
        applyButton.layer.cornerRadius = 6
    }
    
    private func reloadCollectionViewsData() {
        selectedTagsCollectionView.reloadData()
        suggestedTagsCollectionView.reloadData()
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
        suggestedFilters = [Tag(title: "Cooking"), Tag(title: "Tech"), Tag(title: "Reading"), Tag(title: "Entertainment"), Tag(title: "Music"), Tag(title: "Family")]
    }
    
    // MARK: - IBActions
    @IBAction func exitTapped(_ sender: UIButton) {
        exitButton.setImage(UIImage(named: "x-light"), for: .normal)
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func clearTags(_ sender: UIButton) {
        selectedFilters = []
        addSuggestedFilters()
        // TODO - remove location zip and data filters
        reloadCollectionViewsData()
    }
    
    @IBAction func applyFilters(_ sender: UIButton) {
        delegate?.receive(filters: Filter(index: nil, tags: selectedFilters, location: nil, ticketRange: nil, dateRange: nil))
        navigationController?.popViewController(animated: true)
    }
}

// MARK: - Extensions
extension FilterViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, FilterCellDelegate {
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
            cell.filterTag = selectedFilters[indexPath.row]
            cell.isActive = true
            cell.delegate = self
            return cell
        } else if collectionView == suggestedTagsCollectionView {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SuggestedFilterCell", for: indexPath) as? TagCollectionViewCell else { return UICollectionViewCell() }
            cell.filterTag = suggestedFilters[indexPath.row]
            cell.isActive = false
            cell.delegate = self
            return cell
        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let null = CGSize()
        guard let font = UIFont(name: "Poppins-Regular", size: 14) else { return null }
        let fontAttributes = [NSAttributedString.Key.font: font]
        if collectionView == selectedTagsCollectionView {
            return CGSize(width: (selectedFilters[indexPath.row].title as NSString).size(withAttributes: fontAttributes).width + 42, height: 22)
        } else if collectionView == suggestedTagsCollectionView {
            return CGSize(width: (suggestedFilters[indexPath.row].title as NSString).size(withAttributes: fontAttributes).width + 42, height: 22)
        } else {
            return null
        }
    }
    
    func buttonTapped(cell: TagCollectionViewCell) {
        guard let tag = cell.filterTag else { return }
        if cell.isActive {
            guard let indexPath = selectedTagsCollectionView.indexPath(for: cell) else { return }
            for i in 0..<selectedFilters.count {
                if selectedFilters[i] == tag {
                    selectedFilters.remove(at: i); break
                }
            }
            selectedTagsCollectionView.deleteItems(at: [indexPath])
            if isEditingTag && cell == selectedTagsCollectionView.visibleCells.first {
                view.endEditing(true)
            }
        } else {
            guard let indexPath = suggestedTagsCollectionView.indexPath(for: cell) else { return }
            for i in 0..<suggestedFilters.count {
                if suggestedFilters[i] == tag {
                    suggestedFilters.remove(at: i); break
                }
            }
            suggestedTagsCollectionView.deleteItems(at: [indexPath])
            selectedFilters.append(tag)
            selectedTagsCollectionView.insertItems(at: [IndexPath(row: selectedFilters.count - 1, section: 0)])
        }
    }
}

extension FilterViewController: UISearchBarDelegate {
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        selectedFilters.insert(Tag(title: ""), at: 0)
        selectedTagsCollectionView.insertItems(at: [IndexPath(row: 0, section: 0)])
        isEditingTag = true
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.endEditing(true)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.endEditing(true)
        selectedFilters.remove(at: selectedFilters.count - 1)
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        searchBar.text = ""
        isEditingTag = false
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        selectedFilters[0].title = searchText
        selectedTagsCollectionView.reloadData()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
}

// MARK: - Flow Layout
class LeftAlignedCollectionViewFlowLayout: UICollectionViewFlowLayout {

    override public func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        let layoutAttributesObjects = super.layoutAttributesForElements(in: rect)
        
        layoutAttributesObjects?.forEach({ layoutAttributes in
            if layoutAttributes.representedElementCategory == .cell {
                let indexPath = layoutAttributes.indexPath
                if let newFrame = layoutAttributesForItem(at: indexPath)?.frame {
                    layoutAttributes.frame = newFrame
                }
            }
        })
        return layoutAttributesObjects
    }
}

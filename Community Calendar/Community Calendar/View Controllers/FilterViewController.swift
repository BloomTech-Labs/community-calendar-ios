//
//  FilterViewController.swift
//  Community Calendar
//
//  Created by Jordan Christensen on 1/15/20.
//  Copyright © 2020 Lambda School All rights reserved.
//
//  Dev Notes:
//

import UIKit
import CoreLocation

protocol FilterDelegate {
    func receive(filters: Filter)
}

class FilterViewController: UIViewController {
    // MARK: - Varibles
    var delegate: FilterDelegate?
    var isEditingTag: Bool = false
    
    var districts: [String]?
    
    var firstDatePickerView = UIDatePicker()
    var secondDatePickerView = UIDatePicker()
    var districtPickerView = UIPickerView()
    var dateDoneButton = UIButton()
    var districtDoneButton = UIButton()
    var selectedFilters = [Tag]()
    var suggestedFilters = [Tag]()
    
    var controller: Controller?
    var events: [Event]? {
        didSet {
            setDistrictList()
        }
    }
    var filter = Filter() {
        didSet {
            updateViews()
        }
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        .lightContent
    }
    
    // MARK: - IBOutlets
    @IBOutlet weak var exitButton: UIButton!
    @IBOutlet weak var tagsSearchBar: UISearchBar!
    @IBOutlet weak var applyButton: UIButton!
    @IBOutlet weak var selectedTagsCollectionView: UICollectionView!
    @IBOutlet weak var suggestedTagsCollectionView: UICollectionView!
    
    @IBOutlet weak var districtTextField: UITextField!
    @IBOutlet weak var zipCodeTextField: UITextField!
    @IBOutlet weak var dateTextField: UITextField!

    // MARK: - Lifecycle Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUp()
        
        tagsSearchBar.delegate = self
        tagsSearchBar.returnKeyType = .done
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        addSuggestedFilters()
        updateViews()
    }
    
    // MARK: - Functions
    private func updateViews() {
        guard isViewLoaded else { return }
        setUpSearchBar()
        applyButton.layer.cornerRadius = 6
    }
    
    private func setUp() {
        setUpTextField(districtTextField)
        setUpTextField(zipCodeTextField)
        dateTextField.placeholder = "\(filterDateFormatter.string(from: Date()))"
        setUpTextField(dateTextField)
        
        setUpWithFilters()
        
        setDistrictList()
        setUpPickerViews()
        
        selectedTagsCollectionView.delegate = self
        selectedTagsCollectionView.dataSource = self
        
        suggestedTagsCollectionView.delegate = self
        suggestedTagsCollectionView.dataSource = self
        
        let layout = LeftAlignedCollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 16
        layout.minimumLineSpacing = 16
        suggestedTagsCollectionView.collectionViewLayout = layout
    }
    
    private func setUpWithFilters() {
        if let dateRange = filter.dateRange {
            dateTextField.text = "\(filterDateFormatter.string(from: dateRange.min)) - \(filterDateFormatter.string(from: dateRange.max))"
            firstDatePickerView.date = dateRange.min
            secondDatePickerView.date = dateRange.max
        }
        if let location = filter.location, let row = location.row {
            districtTextField.text = location.name
            districtPickerView.selectRow(row, inComponent: 0, animated: false)
        }
        
        selectedFilters = filter.tags ?? []
        for suggestedTag in suggestedFilters {
            for selectedTag in selectedFilters {
                if suggestedTag.title == selectedTag.title {
                    removeObject(suggestedTag, from: &suggestedFilters)
                }
            }
        }
        suggestedTagsCollectionView.reloadData()
    }
    
    private func setUpTextField(_ textField: UITextField) {
        guard let font = UIFont(name: PoppinsFont.regular.rawValue, size: 14), let placeholderText = textField.placeholder else { return }
        textField.attributedText = NSAttributedString(string: "", attributes: [NSAttributedString.Key.font : font])
        textField.attributedPlaceholder = NSAttributedString(string: placeholderText, attributes: [NSAttributedString.Key.font : font])
        textField.font = font
        
        textField.delegate = self
        textField.delegate = self
        
        if textField == zipCodeTextField {
            textField.addSubview(UIView(frame: CGRect(x: 0, y: 20, width: textField.frame.width, height: 1)))
            textField.subviews.last?.backgroundColor = UIColor(red: 0.769, green: 0.769, blue: 0.769, alpha: 1)
        } else {
            textField.inputView = UIView()
            textField.inputAccessoryView = UIView()
            textField.tintColor = .clear
        }
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
        if let font = UIFont(name: PoppinsFont.medium.rawValue, size: 14.0) {
            tagsSearchBar.searchTextField.attributedPlaceholder = NSAttributedString(string: "Search for tags", attributes: [
                NSAttributedString.Key.font: font,
                NSAttributedString.Key.foregroundColor: UIColor.lightGray
            ])
            tagsSearchBar.searchTextField.font = font
        } else {
            tagsSearchBar.searchTextField.placeholder = "Search for tags"
        }
    }
    
    private func setUpPickerViews() {
        districtPickerView.delegate = self
        districtPickerView.dataSource = self
        
        firstDatePickerView.datePickerMode = .date
        secondDatePickerView.datePickerMode = .date
        
        view.addSubview(firstDatePickerView)
        view.addSubview(secondDatePickerView)
        view.addSubview(dateDoneButton)
        let frame = CGRect(x: dateTextField.frame.minX - 100, y: dateTextField.frame.maxY + 5, width: dateTextField.frame.width + 100, height: 100)
        firstDatePickerView.frame = frame
        secondDatePickerView.frame = frame
        dateDoneButton.frame = CGRect(x: dateTextField.frame.minX, y: dateTextField.frame.maxY + 100, width: 50, height: 30)
        dateDoneButton.text("Done")
        dateDoneButton.addTarget(self, action: #selector(dateDoneButtonTapped(_:)), for: .touchUpInside)
        firstDatePickerView.isHidden = true
        secondDatePickerView.isHidden = true
        dateDoneButton.isHidden = true
        
        view.addSubview(districtPickerView)
        view.addSubview(districtDoneButton)
        districtPickerView.reloadAllComponents()
        districtPickerView.frame = CGRect(x: districtTextField.frame.minX - 100, y: districtTextField.frame.maxY + 5, width: districtTextField.frame.width + 100, height: 100)
        districtDoneButton.frame = CGRect(x: districtTextField.frame.minX, y: districtTextField.frame.maxY + 100, width: 50, height: 30)
        districtDoneButton.text("Done")
        districtDoneButton.addTarget(self, action: #selector(districtDoneButtonTapped(_:)), for: .touchUpInside)
        districtPickerView.isHidden = true
        districtDoneButton.isHidden = true
        
        
        dateDoneButton.setTitleColor(.black, for: .normal)
        districtDoneButton.setTitleColor(.black, for: .normal)
        
        districtPickerView.backgroundColor = .white
        firstDatePickerView.backgroundColor = .white
        secondDatePickerView.backgroundColor = .white
    }
    
    private func setDistrictList() {
        if let events = events {
            var districtList = [String]()
            for event in events {
                if let location = event.locations.first?.city {
                    districtList.append(location)
                }
            }
            let districtsSet = Set(districtList.map { $0 } )
            districts = Array(districtsSet) as [String]
            districtPickerView.reloadAllComponents()
        }
    }
    
    private func addSuggestedFilters() {
        // TODO: Record most used filters and display the top 10. Alternatively use CoreML to learn what kind of filters the user likes and suggest new and used ones appropriately.
        if let controller = controller {
            controller.fetchTags { result in
                switch result {
                case .success(let tags):
                    self.suggestedFilters = tags
                    self.setUpWithFilters()
                case .failure(let error):
                    NSLog("\(#file):L\(#line): Configuration failed inside \(#function) with error \(error)")
                }
            }
        } else {
            suggestedFilters = [Tag(title: "cooking"), Tag(title: "art"), Tag(title: "reading"), Tag(title: "entertainment"), Tag(title: "music"), Tag(title:"family")]
        }
    }
    
    // MARK: - IBActions
    @IBAction func exitTapped(_ sender: UIButton) {
        exitButton.setImage(UIImage(named: "x-light"), for: .normal)
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func clearTags(_ sender: UIButton) {
        selectedFilters = []
        filter.tags = nil
        addSuggestedFilters()
        districtTextField.text = ""
        filter.location = nil
        zipCodeTextField.text = ""
        filter.zipCode = nil
        dateTextField.text = ""
        filter.dateRange = nil
        
        reloadCollectionViewsData()
    }
    
    
    
    @IBAction func applyFilters(_ sender: UIButton) {
        if let zip = zipCodeTextField.text, let zipCode = Int(zip),
            !(zipCodeTextField.text?.isEmpty ?? false) {
            filter.zipCode = zipCode
        }
        delegate?.receive(filters: filter)
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
            cell.tagBackgroundView.backgroundColor = UIColor(red: 0.129, green: 0.141, blue: 0.173, alpha: 1)
            cell.tagButton.transform = CGAffineTransform(rotationAngle: 0)
            return cell
        } else if collectionView == suggestedTagsCollectionView {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SuggestedFilterCell", for: indexPath) as? TagCollectionViewCell else { return UICollectionViewCell() }
            cell.filterTag = suggestedFilters[indexPath.row]
            cell.isActive = false
            cell.delegate = self
            cell.tagButton.transform = CGAffineTransform(rotationAngle: -14.95)
            cell.tagBackgroundView.backgroundColor = UIColor(red: 0.896, green: 0.896, blue: 0.896, alpha: 1)
            return cell
        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let null = CGSize()
        guard let font = UIFont(name: PoppinsFont.regular.rawValue, size: 14) else { return null }
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
            for tagFilter in selectedFilters {
                if tagFilter == tag {
                    removeObject(tagFilter, from: &selectedFilters)
                    filter.tags = selectedFilters
                }
            }
            tagsSearchBar.endEditing(true)
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
            filter.tags = selectedFilters
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
        if searchBar.text == "" && selectedFilters.count > 0 {
            selectedFilters.remove(at: 0)
        } else {
            filter.tags = selectedFilters
        }
        searchBar.text = ""
        isEditingTag = false
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText != "" {
            selectedFilters[0].title = searchText
            selectedTagsCollectionView.reloadData()
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
}

extension FilterViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == districtTextField {
            districtPickerView.isHidden = false
            districtDoneButton.isHidden = false
            firstDatePickerView.isHidden = true
            secondDatePickerView.isHidden = true
            dateDoneButton.isHidden = true
        } else if textField == dateTextField {
            firstDatePickerView.isHidden = false
            districtPickerView.isHidden = true
            districtDoneButton.isHidden = true
            dateDoneButton.text("Next")
            dateDoneButton.isHidden = false
        }
    }
    
    @objc
    func dateDoneButtonTapped(_ sender: UIButton) {
        if firstDatePickerView.isHidden {
            secondDatePickerView.isHidden = true
            dateDoneButton.isHidden = true
            
            filter.dateRange = DateRangeFilter(dateRange: (filter.dateRange!.min, secondDatePickerView.date))
            if filter.dateRange!.min.isGreaterThan(date: secondDatePickerView.date)! {
                filter.dateRange = DateRangeFilter(dateRange: (secondDatePickerView.date, filter.dateRange!.min))
            }
            dateTextField.text = "\(filterDateFormatter.string(from: filter.dateRange!.min)) - \(filterDateFormatter.string(from: filter.dateRange!.max))"
            dateTextField.endEditing(true)
        } else if secondDatePickerView.isHidden {
            filter.dateRange = DateRangeFilter(dateRange: (firstDatePickerView.date, firstDatePickerView.date))
            firstDatePickerView.isHidden = true
            secondDatePickerView.isHidden = false
            dateDoneButton.text("Done")
        } else {
            dateDoneButton.isHidden = true
        }
    }
    
    @objc
    func districtDoneButtonTapped(_ sender: UIButton) {
        districtTextField.text = districts?[districtPickerView.selectedRow(inComponent: 0)]
        districtTextField.endEditing(true)
        districtPickerView.isHidden = true
        districtDoneButton.isHidden = true
        
        if let district = districtTextField.text {
            let geoCoder = CLGeocoder()
            geoCoder.geocodeAddressString(district) { (placemarks, error) in
                guard
                    let placemarks = placemarks,
                    let location = placemarks.first?.location
                else {
                    NSLog("Could not pull location from district name")
                    return
                }
                self.filter.location = LocationFilter(longitude: location.coordinate.longitude, latitude: location.coordinate.latitude, radius: 30, name: self.districtTextField.text!, row: self.districtPickerView.selectedRow(inComponent: 0))
            }
        }
    }
}

extension FilterViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView == districtPickerView {
            return districts?.count ?? 0
        }
        return 0
    }
    
    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        if pickerView == districtPickerView {
            guard let districts = districts, let font = UIFont(name: PoppinsFont.regular.rawValue, size: 12) else { return NSAttributedString(string: "?") }
            return NSAttributedString(string: districts[row], attributes: [NSAttributedString.Key.font: font])
        }
        return NSAttributedString(string: "?")
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

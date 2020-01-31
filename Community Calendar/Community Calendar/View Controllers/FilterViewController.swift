//
//  FilterViewController.swift
//  Community Calendar
//
//  Created by Jordan Christensen on 1/15/20.
//  Copyright © 2020 Mazjap Co. All rights reserved.
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
    
    var eventController: EventController?
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
        
        zipCodeTextField.isHidden = true
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
        setUpTextField(zipCodeTextField, false)
        dateTextField.placeholder = "\(filterDateFormatter.string(from: Date()))"
        setUpTextField(dateTextField)
        
        setUpWithFilters()
        
        setDistrictList()
        setUpPickerViews()
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
                    remove(object: suggestedTag, from: &suggestedFilters)
                }
            }
        }
        suggestedTagsCollectionView.reloadData()
    }
    
    private func setUpTextField(_ textField: UITextField, _ withoutSelect: Bool = true) {
        guard let font = UIFont(name: "Poppins-Regular", size: 14), let placeholderText = textField.placeholder else { return }
        textField.attributedText = NSAttributedString(string: "", attributes: [NSAttributedString.Key.font : font])
        textField.attributedPlaceholder = NSAttributedString(string: placeholderText, attributes: [NSAttributedString.Key.font : font])
        textField.font = font
        
        textField.addSubview(UIView(frame: CGRect(x: 0, y: 20, width: textField.frame.width, height: 1)))
        textField.subviews.last?.backgroundColor = UIColor(red: 0.769, green: 0.769, blue: 0.769, alpha: 1)
        
        textField.delegate = self
        textField.delegate = self
        
        if withoutSelect {
            textField.inputView = UIView()
            textField.inputAccessoryView = UIView()
            textField.tintColor = .white
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
    
    private func setUpPickerViews() {
        districtPickerView.delegate = self
        districtPickerView.dataSource = self
        
        firstDatePickerView.datePickerMode = .date
        secondDatePickerView.datePickerMode = .date
        
        view.addSubview(firstDatePickerView)
        view.addSubview(secondDatePickerView)
        view.addSubview(dateDoneButton)
        firstDatePickerView.frame = CGRect(x: dateTextField.frame.minX - 100, y: dateTextField.frame.maxY, width: dateTextField.frame.width + 100, height: 100)
        secondDatePickerView.frame = CGRect(x: dateTextField.frame.minX - 100, y: dateTextField.frame.maxY, width: dateTextField.frame.width + 100, height: 100)
        dateDoneButton.frame = CGRect(x: dateTextField.frame.minX, y: dateTextField.frame.maxY + 100, width: 50, height: 30)
        dateDoneButton.setTitle("Done", for: .normal)
        dateDoneButton.addTarget(self, action: #selector(dateDoneButtonTapped(_:)), for: .touchUpInside)
        firstDatePickerView.isHidden = true
        secondDatePickerView.isHidden = true
        dateDoneButton.isHidden = true
        
        view.addSubview(districtPickerView)
        view.addSubview(districtDoneButton)
        districtPickerView.reloadAllComponents()
        districtPickerView.frame = CGRect(x: districtTextField.frame.minX - 100, y: districtTextField.frame.maxY, width: districtTextField.frame.width + 100, height: 100)
        districtDoneButton.frame = CGRect(x: dateTextField.frame.minX, y: dateTextField.frame.maxY + 100, width: 50, height: 30)
        districtDoneButton.setTitle("Done", for: .normal)
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
        if let eventController = eventController {
            eventController.fetchTags { result in
                switch result {
                case .success(let tags):
                    self.suggestedFilters = tags
                    self.setUpWithFilters()
                case .failure(let error):
                    NSLog("\(#file):L\(#line): Configuration failed inside \(#function) with error \(error)")
                }
            }
        } else {
            suggestedFilters = [Tag(title: "Cooking"), Tag(title: "Tech"), Tag(title: "Reading"), Tag(title: "Entertainment"), Tag(title: "Music"), Tag(title: "Family")]
        }
    }
    
    @discardableResult
    private func remove<T: Equatable>(object: T, from array: inout [T]) -> Any? {
        for index in 0...array.count - 1 {
            if object == array[index] {
                let temp = array[index]
                array.remove(at: index)
                return temp
            }
        }
        print("Failed to find object of type \(String(describing: object.self)) in array of type \(String(describing: array.self)). Are these objects of the same type?")
        return nil
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
        // TODO: remove zipCode from filter
        dateTextField.text = ""
        filter.dateRange = nil
        
        reloadCollectionViewsData()
    }
    
    
    
    @IBAction func applyFilters(_ sender: UIButton) {
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
            for tagFilter in selectedFilters {
                if tagFilter == tag {
                    remove(object: tagFilter, from: &selectedFilters)
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
        } else if textField == dateTextField {
            firstDatePickerView.isHidden = false
            dateDoneButton.setTitle("Next", for: .normal)
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
        } else if secondDatePickerView.isHidden {
            filter.dateRange = DateRangeFilter(dateRange: (firstDatePickerView.date, firstDatePickerView.date))
            firstDatePickerView.isHidden = true
            secondDatePickerView.isHidden = false
            dateDoneButton.setTitle("Done", for: .normal)
        } else {
            dateDoneButton.isHidden = true
        }
    }
    
    @objc
    func districtDoneButtonTapped(_ sender: UIButton) {
        districtTextField.text = districts?[districtPickerView.selectedRow(inComponent: 0)]
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
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView == districtPickerView {
            guard let districts = districts else { return "?" }
            return districts[row]
        }
        return "?"
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

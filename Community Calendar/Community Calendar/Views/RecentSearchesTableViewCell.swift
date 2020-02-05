//
//  RecentSearchesTableViewCell.swift
//  Community Calendar
//
//  Created by Jordan Christensen on 1/30/20.
//  Copyright © 2020 Mazjap Co. All rights reserved.
//

import UIKit

class RecentSearchesTableViewCell: UITableViewCell {
    var filter: Filter? {
        didSet {
            updateViews()
        }
    }
    
    @IBOutlet weak var imageButton: UIButton!
    @IBOutlet weak var byFilterLabel: UILabel!
    @IBOutlet weak var filterUsedLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        updateViews()
    }

    func updateViews() {
        guard let filter = filter, let filterUsedLabel = filterUsedLabel else { return }
        imageButton.backgroundColor = UIColor(red: 0.84, green: 0.84, blue: 0.84, alpha: 1.0)
        imageButton.layer.cornerRadius = 5
        imageButton.layer.borderWidth = 1
        imageButton.layer.borderColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.1).cgColor
        
        filterUsedLabel.text = ""
        if let index = filter.index {
            byFilterLabel.text = "By term"
            filterUsedLabel.text = "\"\(index)\""
        } else if let dateRange = filter.dateRange {
            byFilterLabel.text = "By dates"
            filterUsedLabel.text = "\(filterDateFormatter.string(from: dateRange.min)) - \(filterDateFormatter.string(from: dateRange.max))"
        } else if let tags = filter.tags {
            byFilterLabel.text = "By tag"
            if tags.count != 1 {
                byFilterLabel.text = "\(byFilterLabel.text ?? "")s"
            }
            if tags.count >= 3 {
                filterUsedLabel.text = "\(filterUsedLabel.text ?? "") \"\(tags[0].title)\", \"\(tags[1].title)\", \"\(tags[2].title)\""
            } else {
                for tagIndex in 0..<tags.count {
                    if tagIndex == tags.count - 1 {
                        filterUsedLabel.text = "\(filterUsedLabel.text ?? "") \"\(tags[tagIndex].title)\""
                    } else {
                        filterUsedLabel.text = "\(filterUsedLabel.text ?? "") \"\(tags[tagIndex].title)\","
                    }
                }
            }
        } else if let location = filter.location {
            byFilterLabel.text = "By district"
            filterUsedLabel.text = "\(location.name)"
        } else if let zipCode = filter.zipCode {
            byFilterLabel.text = "By zipcode"
            filterUsedLabel.text = "\(zipCode)"
        }
    }
}

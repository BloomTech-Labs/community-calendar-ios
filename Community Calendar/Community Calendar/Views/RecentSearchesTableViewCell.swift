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
        if filter.index != nil {
            byFilterLabel.text = "By term"
            filterUsedLabel.text = "\"\(filter.index!)\""
        } else if filter.dateRange != nil {
            byFilterLabel.text = "By dates"
            filterUsedLabel.text = "\(filterDateFormatter.string(from: filter.dateRange!.min)) - \(filterDateFormatter.string(from: filter.dateRange!.max))"
        } else if filter.tags != nil {
            byFilterLabel.text = "By tag"
            if filter.tags!.count != 1 {
                byFilterLabel.text = "\(byFilterLabel.text ?? "")s"
            }
            if filter.tags!.count >= 3 {
                filterUsedLabel.text = "\"\(filter.tags![0].title)\", \"\(filter.tags![1].title)\", \"\(filter.tags![2].title)\""
            } else {
                for tagIndex in 0..<filter.tags!.count {
                    if tagIndex == filter.tags!.count - 1 {
                        filterUsedLabel.text = "\(filterUsedLabel.text ?? "") \"\(filter.tags![tagIndex].title)\""
                    } else {
                        filterUsedLabel.text = "\(filterUsedLabel.text ?? "") \"\(filter.tags![tagIndex].title)\","
                    }
                }
            }
        } else if filter.location != nil {
            byFilterLabel.text = "By district"
            filterUsedLabel.text = "\(filter.location!.name)"
        }
    }

}

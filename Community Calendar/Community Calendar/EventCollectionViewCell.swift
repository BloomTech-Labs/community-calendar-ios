//
//  EventCollectionViewCell.swift
//  Community Calendar
//
//  Created by Jordan Christensen on 12/16/19.
//  Copyright © 2019 Mazjap Co. All rights reserved.
//

import UIKit

let dateFormatter: DateFormatter = {
    let df = DateFormatter()
    df.dateFormat = "h:mm a"
    return df
}()

class EventCollectionViewCell: UICollectionViewCell {
    var event: Event? {
        didSet {
            updateViews()
        }
    }
    
    @IBOutlet weak var eventImageView: UIImageView!
    @IBOutlet weak var districtNameLabel: UILabel!
    @IBOutlet weak var eventTitleLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    
    
    func updateViews() {
        guard let event = event else { return }
        eventImageView.image = UIImage(named: event.image)
        eventImageView.layer.cornerRadius = 3
        eventTitleLabel.text = event.title
        districtNameLabel.text = event.description
        timeLabel.text = "\(dateFormatter.string(from: event.startDate)) - \(dateFormatter.string(from: event.endDate))"
    }
}

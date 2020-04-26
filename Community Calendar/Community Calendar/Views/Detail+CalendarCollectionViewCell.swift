//
//  Detail+CalendarCollectionViewCell.swift
//  Community Calendar
//
//  Created by Michael on 4/24/20.
//  Copyright © 2020 Mazjap Co. All rights reserved.
//

import UIKit

class Detail_CalendarCollectionViewCell: UICollectionViewCell {
    
    var event: EasyEvent? {
        didSet {
            updateDetailView()
        }
    }
    
    var viewType: DetailCalendar? {
        didSet {
            updateViews()
        }
    }
    
    var featuredIndexPath: IndexPath? {
        didSet {
            updateDetailView()
        }
    }
    
    @IBOutlet weak var detailCalendarView: UIView!
    @IBOutlet weak var eventImageView: UIImageView!
    @IBOutlet weak var eventNameLabel: UILabel!
    @IBOutlet weak var eventDateLabel: UILabel!
    @IBOutlet weak var eventVenueLabel: UILabel!
    
    
    
    
    
    
    func updateViews() {
        detailCalendarView.backgroundColor = .white
        detailCalendarView.layer.cornerRadius = 12
        detailCalendarView.dropShadow()
        if viewType == .detail {
            
        } else if viewType == .calendar {
            
        }
    }
    
    func updateDetailView() {
        guard let event = event else { return }
        eventImageView.image = event.eventImage
        eventNameLabel.text = event.eventName
        eventDateLabel.text = event.stringEventDate
        eventVenueLabel.text = event.venueName
    }
}

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
    
    // MARK: View(s) Properties
    //View 1
    let detailView = UIView()
    //View 2
    let calendarView = CalenderView()
    
    // View 1 Properties
    let eventImageView = UIImageView()
    let eventNameLabel = UILabel()
    let eventDateLabel = UILabel()
    let eventVenueLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
        constraintsDetailView()
        constraintCalendarView()
        // Call it here
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
    }
    
    
    
    
    func updateViews() {
        if viewType == .detail {
            calendarView.isHidden = true
            
        } else if viewType == .calendar {
            eventImageView.isHidden = true
            eventNameLabel.isHidden = true
            eventDateLabel.isHidden = true
            eventVenueLabel.isHidden = true
        }
    }
    
    func updateDetailView() {
        guard let event = event else { return }
        eventImageView.image = event.eventImage
        eventNameLabel.text = event.eventName
        eventDateLabel.text = event.stringEventDate
        eventVenueLabel.text = event.venueName
    }
    
    //MARK: - Clendar View
    func constraintCalendarView() {
        
        detailView.addSubview(calendarView)
        calendarView.anchor(top: detailView.topAnchor, leading: detailView.leadingAnchor, trailing: detailView.trailingAnchor, bottom: detailView.bottomAnchor, centerX: nil, centerY: nil)
        
    }
    
    func constraintsDetailView() {
        
        // MARK: - Content View
        
        contentView.anchor(top: self.topAnchor, leading: self.leadingAnchor, trailing: self.trailingAnchor, bottom: self.bottomAnchor, centerX: nil, centerY: nil, padding: .zero, size: .init(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.width - 100))
        contentView.addSubview(detailView)
        contentView.backgroundColor = .white
        
        // MARK: - Detail View
        
        detailView.anchor(top: contentView.topAnchor, leading: contentView.leadingAnchor, trailing: contentView.trailingAnchor, bottom: contentView.bottomAnchor, centerX: nil, centerY: nil, padding: .init(top: 8, left: 20, bottom: -8, right: -20), size: .zero)
        detailView.dropShadow()
        detailView.backgroundColor = .white
        detailView.layer.cornerRadius = 12
        detailView.addSubview(eventImageView)
        detailView.addSubview(eventNameLabel)
        detailView.addSubview(eventDateLabel)
        detailView.addSubview(eventVenueLabel)
        
        // MARK: - Event Image View
        
        eventImageView.anchor(top: detailView.topAnchor, leading: detailView.leadingAnchor, trailing: nil, bottom: nil, centerX: nil, centerY: nil, padding: .init(top: 8, left: 8, bottom: 0, right: 0), size: .init(width: UIScreen.main.bounds.width / 3, height: UIScreen.main.bounds.width / 3))
        eventImageView.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.width / 3).isActive = true
        eventImageView.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width / 3).isActive = true
        eventImageView.layer.masksToBounds = true
        eventImageView.layer.cornerRadius = 12
        eventImageView.contentMode = .scaleAspectFill
        
        // MARK: - Event Name Label
        
        eventNameLabel.anchor(top: detailView.topAnchor, leading: eventImageView.trailingAnchor, trailing: detailView.trailingAnchor, bottom: nil, centerX: nil, centerY: nil, padding: .init(top: 8, left: 8, bottom: 0, right: -8), size: .zero)
        eventNameLabel.textAlignment = .center
        eventNameLabel.numberOfLines = 3
        eventNameLabel.adjustsFontSizeToFitWidth = true
        eventNameLabel.allowsDefaultTighteningForTruncation = true
        eventNameLabel.font = UIFont(name: "Poppins-SemiBold", size: 18)
        
        // MARK: - Event Date Label
        
        eventDateLabel.anchor(top: eventNameLabel.bottomAnchor, leading: eventImageView.trailingAnchor, trailing: detailView.trailingAnchor, bottom: nil, centerX: nil, centerY: nil, padding: .init(top: 8, left: 8, bottom: 0, right: -8), size: .zero)
        eventDateLabel.textAlignment = .center
        eventDateLabel.numberOfLines = 1
        eventDateLabel.adjustsFontSizeToFitWidth = true
        eventDateLabel.allowsDefaultTighteningForTruncation = true
        eventDateLabel.font = UIFont(name: "Poppins-Light", size: 15)
        
        // MARK: - Event Venue Label
        
        eventVenueLabel.anchor(top: eventDateLabel.bottomAnchor, leading: eventImageView.trailingAnchor, trailing: detailView.trailingAnchor, bottom: nil, centerX: nil, centerY: nil, padding: .init(top: 8, left: 8, bottom: 0, right: -8), size: .zero)
        
        eventVenueLabel.textAlignment = .center
        eventVenueLabel.numberOfLines = 1
        eventVenueLabel.adjustsFontSizeToFitWidth = true
        eventVenueLabel.allowsDefaultTighteningForTruncation = true
        eventVenueLabel.font = UIFont(name: "Poppins-Light", size: 15)
    }
}

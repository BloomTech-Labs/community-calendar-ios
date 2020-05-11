//
//  Detail+CalendarCollectionViewCell.swift
//  Community Calendar
//
//  Created by Michael on 4/24/20.
//  Copyright © 2020 Mazjap Co. All rights reserved.
//

import UIKit


class Detail_CalendarCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Properties
    var event: FetchEventsQuery.Data.Event? {
        didSet {
            updateDetailView()
        }
    }
    
    var viewType: DetailCalendar? {
        didSet {
            updateViews()
        }
    }
    
    lazy var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        return formatter
    }()
    
    let eventImageView = UIImageView()
    let eventNameLabel = UILabel()
    let eventDateLabel = UILabel()
    let eventLocationLabel = UILabel()
    let eventDescriptionTextView = UITextView()
    
    // MARK: - View 1
    let detailView = UIView()
    // MARK: - View 2
    let calendarView = CalenderView()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
        constraintsDetailView()
        constraintCalendarView()
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
            eventLocationLabel.isHidden = true
            eventDescriptionTextView.isHidden = true
        }
    }
    
    func updateDetailView() {
        guard
            let event = event,
            let urlString = event.eventImages?.first?.url,
            let url = URL(string: urlString),
            let data = try? Data(contentsOf: url),
            let city = event.locations?.first?.city,
            let state = event.locations?.first?.state,
            let serverDate = backendDateFormatter.date(from: event.start)
            else { return }
        
        DispatchQueue.main.async {
            self.eventImageView.image = UIImage(data: data)
            self.eventNameLabel.text = event.title
            self.eventLocationLabel.text = "\(city), \(state)"
            let date = self.dateFormatter.string(from: serverDate)
            self.eventDateLabel.text = date
            self.eventDescriptionTextView.text = event.description
        }
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
        detailView.addSubview(eventLocationLabel)
        detailView.addSubview(eventDescriptionTextView)
        
        // MARK: - Event Image View
        
        eventImageView.anchor(top: detailView.topAnchor, leading: detailView.leadingAnchor, trailing: nil, bottom: nil, centerX: nil, centerY: nil, padding: .init(top: 8, left: 8, bottom: 0, right: 0), size: .init(width: UIScreen.main.bounds.width / 3, height: UIScreen.main.bounds.width / 3))
        eventImageView.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.width / 3).isActive = true
        eventImageView.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width / 3).isActive = true
        eventImageView.layer.masksToBounds = true
        eventImageView.layer.cornerRadius = 12
        eventImageView.contentMode = .scaleToFill
        
        // MARK: - Event Name Label
        
        eventNameLabel.anchor(top: detailView.topAnchor, leading: eventImageView.trailingAnchor, trailing: detailView.trailingAnchor, bottom: nil, centerX: nil, centerY: nil, padding: .init(top: 8, left: 8, bottom: 0, right: -8), size: .zero)
        eventNameLabel.textAlignment = .center
        eventNameLabel.numberOfLines = 3
        eventNameLabel.adjustsFontSizeToFitWidth = true
        eventNameLabel.allowsDefaultTighteningForTruncation = true
        eventNameLabel.font = UIFont(name: "Poppins-SemiBold", size: 18)
        eventNameLabel.textColor = .black
        
        // MARK: - Event Date Label
        
        eventDateLabel.anchor(top: eventNameLabel.bottomAnchor, leading: eventImageView.trailingAnchor, trailing: detailView.trailingAnchor, bottom: nil, centerX: nil, centerY: nil, padding: .init(top: 8, left: 8, bottom: 0, right: -8), size: .zero)
        eventDateLabel.textAlignment = .center
        eventDateLabel.numberOfLines = 1
        eventDateLabel.adjustsFontSizeToFitWidth = true
        eventDateLabel.allowsDefaultTighteningForTruncation = true
        eventDateLabel.font = UIFont(name: "Poppins-Light", size: 15)
        eventDateLabel.textColor = .black
        
        // MARK: - Event Venue Label
        
        eventLocationLabel.anchor(top: eventDateLabel.bottomAnchor, leading: eventImageView.trailingAnchor, trailing: detailView.trailingAnchor, bottom: eventDescriptionTextView.topAnchor, centerX: nil, centerY: nil, padding: .init(top: 8, left: 8, bottom: -20, right: -8), size: .zero)
        
        eventLocationLabel.textAlignment = .center
        eventLocationLabel.numberOfLines = 1
        eventLocationLabel.adjustsFontSizeToFitWidth = true
        eventLocationLabel.allowsDefaultTighteningForTruncation = true
        eventLocationLabel.font = UIFont(name: "Poppins-Light", size: 15)
        eventLocationLabel.textColor = .black
        
        // MARK: - Event Description Text View
        
        eventDescriptionTextView.anchor(top: eventImageView.bottomAnchor, leading: detailView.leadingAnchor, trailing: detailView.trailingAnchor, bottom: detailView.bottomAnchor, centerX: nil, centerY: nil, padding: .init(top: 20, left: 8, bottom: -8, right: -8), size: .zero)
        eventDescriptionTextView.font = UIFont(name: "Poppins-Light", size: 15)
        eventDescriptionTextView.textColor = .black
        eventDescriptionTextView.backgroundColor = .white
        eventDescriptionTextView.isEditable = false
    }
}

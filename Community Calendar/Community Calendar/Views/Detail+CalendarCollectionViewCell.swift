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
    var event: FetchUserIdQuery.Data.User.CreatedEvent? {
        didSet {
            updateDetailView()
        }
    }
    
    var viewType: ViewType? {
        didSet {
            updateViews()
        }
    }
    
    var user: FetchUserIdQuery.Data.User? {
        didSet {
            self.calendarView.user = user
        }
    }
    
//    let eventImageView = UIImageView()
//    let eventNameLabel = UILabel()
//    let eventDateLabel = UILabel()
//    let eventLocationLabel = UILabel()
//    let eventDescriptionTextView = UITextView()
//    let imageBackgroundView = UIView()
    
    // MARK: - View 1
    let detailView = UIView()
    // MARK: - View 2
    let calendarView = CalenderView()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
        constraintsDetailView()
       
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
    }
  
    func updateViews() {
        if viewType == .calendar {
            calendarView.isHidden = false
            
        } else if viewType == .detail {
            
            calendarView.isHidden = true
//            eventImageView.isHidden = true
//            eventNameLabel.isHidden = true
//            eventDateLabel.isHidden = true
//            eventLocationLabel.isHidden = true
//            eventDescriptionTextView.isHidden = true
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
//            self.eventImageView.image = UIImage(data: data)
//            self.eventNameLabel.text = event.title
//            self.eventLocationLabel.text = "\(city), \(state)"
//            let date = dateFormatter.string(from: serverDate)
//            self.eventDateLabel.text = date
//            self.eventDescriptionTextView.text = event.description
        }
    }
    

    
    func constraintsDetailView() {
        
        // MARK: - Content View
        contentView.addSubview(detailView)
        contentView.backgroundColor = .white
        
        // MARK: - Detail View
        detailView.anchor(top: nil, leading: nil, trailing: nil, bottom: nil, centerX: contentView.centerXAnchor, centerY: contentView.centerYAnchor, padding: .zero, size: .zero)
        
        NSLayoutConstraint.activate([
            detailView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 0),
            detailView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            detailView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 0),
            detailView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            detailView.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width - 40)
        ])
        
        detailView.dropShadow()
        detailView.backgroundColor = .white
        detailView.layer.cornerRadius = 12
        
        //MARK: - Clendar View
            
            detailView.addSubview(calendarView)
            calendarView.anchor(top: detailView.topAnchor, leading: detailView.leadingAnchor, trailing: detailView.trailingAnchor, bottom: detailView.bottomAnchor, centerX: nil, centerY: nil)
            
     
//        detailView.addSubview(imageBackgroundView)
//        detailView.addSubview(eventNameLabel)
//        detailView.addSubview(eventDateLabel)
//        detailView.addSubview(eventLocationLabel)
//        detailView.addSubview(eventDescriptionTextView)
        
        // MARK: - Image Background View
//        imageBackgroundView.anchor(top: detailView.topAnchor, leading: detailView.leadingAnchor, trailing: nil, bottom: nil, centerX: nil, centerY: nil, padding: .init(top: 8, left: 8, bottom: 0, right: 0), size: .init(width: UIScreen.main.bounds.width / 3, height: UIScreen.main.bounds.width / 3))
//        imageBackgroundView.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.width / 3).isActive = true
//        imageBackgroundView.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width / 3).isActive = true
//        imageBackgroundView.layer.masksToBounds = true
//        imageBackgroundView.layer.cornerRadius = 12
//        imageBackgroundView.addSubview(eventImageView)
//        imageBackgroundView.dropShadow()
        
        // MARK: - Event Image View
        
//        eventImageView.anchor(top: imageBackgroundView.topAnchor, leading: imageBackgroundView.leadingAnchor, trailing: imageBackgroundView.trailingAnchor, bottom: imageBackgroundView.bottomAnchor, centerX: nil, centerY: nil, padding: .init(top: 0, left: 0, bottom: 0, right: 0), size: .init(width: UIScreen.main.bounds.width / 3, height: UIScreen.main.bounds.width / 3))
//        eventImageView.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.width / 3).isActive = true
//        eventImageView.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width / 3).isActive = true
//        eventImageView.layer.masksToBounds = true
//        eventImageView.layer.cornerRadius = 12
//        eventImageView.contentMode = .scaleToFill
        
        // MARK: - Event Name Label
        
//        eventNameLabel.anchor(top: eventImageView.topAnchor, leading: eventImageView.trailingAnchor, trailing: detailView.trailingAnchor, bottom: nil, centerX: nil, centerY: nil, padding: .init(top: 0, left: 8, bottom: 0, right: -8), size: .zero)
//        eventNameLabel.textAlignment = .center
//        eventNameLabel.numberOfLines = 0
////        eventNameLabel.adjustsFontSizeToFitWidth = true
//        eventNameLabel.allowsDefaultTighteningForTruncation = true
//        eventNameLabel.font = UIFont(name: "Poppins-SemiBold", size: 18)
//        eventNameLabel.textColor = .black
//        eventNameLabel.layer.shadowRadius = 2
//        eventNameLabel.layer.shadowOpacity = 0.2
//        eventNameLabel.layer.shouldRasterize = true
        
        // MARK: - Event Date Label
//
//        eventDateLabel.anchor(top: eventNameLabel.bottomAnchor, leading: eventImageView.trailingAnchor, trailing: detailView.trailingAnchor, bottom: nil, centerX: nil, centerY: nil, padding: .init(top: 8, left: 8, bottom: 0, right: -8), size: .zero)
//        eventDateLabel.textAlignment = .center
//        eventDateLabel.numberOfLines = 1
//        eventDateLabel.adjustsFontSizeToFitWidth = true
//        eventDateLabel.allowsDefaultTighteningForTruncation = true
//        eventDateLabel.font = UIFont(name: "Poppins-Light", size: 15)
//        eventDateLabel.textColor = .black
//        eventDateLabel.layer.shadowRadius = 2
//        eventDateLabel.layer.shadowOpacity = 0.2
//        eventDateLabel.layer.shouldRasterize = true
        
        // MARK: - Event Venue Label
//
//        eventLocationLabel.anchor(top: eventDateLabel.bottomAnchor, leading: eventImageView.trailingAnchor, trailing: detailView.trailingAnchor, bottom: nil, centerX: nil, centerY: nil, padding: .init(top: 8, left: 8, bottom: -20, right: -8), size: .zero)
//
//        eventLocationLabel.textAlignment = .center
//        eventLocationLabel.numberOfLines = 1
//        eventLocationLabel.adjustsFontSizeToFitWidth = true
//        eventLocationLabel.allowsDefaultTighteningForTruncation = true
//        eventLocationLabel.font = UIFont(name: "Poppins-Light", size: 15)
//        eventLocationLabel.textColor = .black
//        eventLocationLabel.layer.shadowRadius = 2
//        eventLocationLabel.layer.shadowOpacity = 0.2
//        eventLocationLabel.layer.shouldRasterize = true
        
        // MARK: - Event Description Text View
        
//        eventDescriptionTextView.anchor(top: eventImageView.bottomAnchor, leading: detailView.leadingAnchor, trailing: detailView.trailingAnchor, bottom: detailView.bottomAnchor, centerX: nil, centerY: nil, padding: .init(top: 8, left: 8, bottom: -8, right: -8), size: .zero)
//        eventDescriptionTextView.font = UIFont(name: "Poppins-Light", size: 12)
//        eventDescriptionTextView.textColor = .black
//        eventDescriptionTextView.backgroundColor = .white
//        eventDescriptionTextView.isEditable = false
    }
}

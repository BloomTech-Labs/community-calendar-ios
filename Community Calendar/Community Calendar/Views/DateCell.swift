//
//  Detail+CalendarCollectionViewCell.swift
//  Community Calendar
//
//  Created by Michael on 4/24/20.
//  Copyright © 2020 Mazjap Co. All rights reserved.
//

import UIKit
import JTAppleCalendar


class DateCell: JTACDayCell {
    
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
//            self.calendarView.user = self.user
        }
    }
    
    @IBOutlet weak var selectedView: UIView!
    @IBOutlet weak var dateLabel: UILabel!
    //    let eventImageView = UIImageView()
//    let eventNameLabel = UILabel()
//    let eventDateLabel = UILabel()
//    let eventLocationLabel = UILabel()
//    let eventDescriptionTextView = UITextView()
//    let imageBackgroundView = UIView()
    
    // MARK: - View 1
    let detailView = UIView()
    // MARK: - View 2

//    let calendarView = CalenderView()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
//        constraintsDetailView()
//        constraintCalendarView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
    }
  
    func updateViews() {
        if viewType == .calendar {
//            calendarView.isHidden = false
            
        } else if viewType == .detail {
//            calendarView.isHidden = true
        }
    }
    
    func updateDetailView() {
//        guard
//            let event = event,
//            let urlString = event.eventImages?.first?.url,
//            let url = URL(string: urlString),
//            let data = try? Data(contentsOf: url),
//            let city = event.locations?.first?.city,
//            let state = event.locations?.first?.state,
//            let serverDate = backendDateFormatter.date(from: event.start)
//            else { return }
        
        DispatchQueue.main.async {
//            self.eventImageView.image = UIImage(data: data)
//            self.eventNameLabel.text = event.title
//            self.eventLocationLabel.text = "\(city), \(state)"
//            let date = dateFormatter.string(from: serverDate)
//            self.eventDateLabel.text = date
//            self.eventDescriptionTextView.text = event.description
        }
    }
    
    //MARK: - Clendar View
//    func constraintCalendarView() {
//
//        detailView.addSubview(calendarView)
//        calendarView.anchor(top: detailView.topAnchor, leading: detailView.leadingAnchor, trailing: detailView.trailingAnchor, bottom: detailView.bottomAnchor, centerX: nil, centerY: nil)
//
//    }
    
    func constraintsDetailView() {
        
        // MARK: - Content View
//        contentView.addSubview(calendarView)
        contentView.backgroundColor = .white
        
        // MARK: - Detail View
//        calendarView.anchor(top: nil, leading: nil, trailing: nil, bottom: nil, centerX: contentView.centerXAnchor, centerY: contentView.centerYAnchor, padding: .zero, size: .zero)
//        
//        NSLayoutConstraint.activate([
//            calendarView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 0),
//            calendarView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
//            calendarView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 0),
//            calendarView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
//            calendarView.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width - 40)
//        ])
        
//        calendarView.blackShadow()
//        calendarView.backgroundColor = .white
//        calendarView.layer.cornerRadius = 12
//        
//        calendarView.addSubview(calendarView)
//        calendarView.anchor(top: calendarView.topAnchor, leading: calendarView.leadingAnchor, trailing: calendarView.trailingAnchor, bottom: calendarView.bottomAnchor, centerX: nil, centerY: nil)

    }
}

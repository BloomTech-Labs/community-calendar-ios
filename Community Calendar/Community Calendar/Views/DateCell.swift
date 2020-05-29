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
//    var event: FetchUserIdQuery.Data.User.CreatedEvent? {
//        didSet {
////            updateDetailView()
//        }
//    }
    
    var viewType: ViewType? {
        didSet {
//            updateViews()
        }
    }
    
//    var user: FetchUserIdQuery.Data.User? {
//        didSet {
////            self.calendarView.user = self.user
//        }
//    }
    
    @IBOutlet weak var attendingDot: UIView!
    @IBOutlet weak var createdDot: UIView!
    @IBOutlet weak var selectedView: UIView!
    @IBOutlet weak var savedDot: UIView!
    @IBOutlet weak var dateLabel: UILabel!
    
//    let eventImageView = UIImageView()
//    let eventNameLabel = UILabel()
//    let eventDateLabel = UILabel()
//    let eventLocationLabel = UILabel()
//    let eventDescriptionTextView = UITextView()
//    let imageBackgroundView = UIView()
    
    // MARK: - View 1
    let detailView = UIView()

    override func awakeFromNib() {
        super.awakeFromNib()
        
        calendarCellConstraints()
        configureDateCellViews()
    }
    
    
    func calendarCellConstraints() {
        self.backgroundColor = .clear   
        dateLabel.anchor(top: contentView.topAnchor, leading: nil, trailing: nil, bottom: nil, centerX: contentView.centerXAnchor, centerY: nil, padding: .zero, size: .zero)
        
        savedDot.anchor(top: dateLabel.bottomAnchor, leading: nil, trailing: nil, bottom: nil, centerX: contentView.centerXAnchor, centerY: nil, padding: .init(top: 2, left: 0, bottom: 0, right: 0), size: .zero)
        
        attendingDot.anchor(top: dateLabel.bottomAnchor, leading: nil, trailing: savedDot.leadingAnchor, bottom: nil, centerX: nil, centerY: nil, padding: .init(top: 2, left: 2, bottom: 0, right: -2), size: .zero)
        
        createdDot.anchor(top: dateLabel.bottomAnchor, leading: savedDot.trailingAnchor, trailing: nil, bottom: nil, centerX: nil, centerY: nil, padding: .init(top: 2, left: 2, bottom: 0, right: -2), size: .zero)
        
        selectedView.anchor(top: contentView.topAnchor, leading: contentView.leadingAnchor, trailing: contentView.trailingAnchor, bottom: contentView.bottomAnchor, centerX: nil, centerY: nil)
        
        NSLayoutConstraint.activate([
            savedDot.widthAnchor.constraint(equalToConstant: contentView.bounds.height / 4.5),
            savedDot.heightAnchor.constraint(equalToConstant: contentView.bounds.height / 4.5),
            attendingDot.widthAnchor.constraint(equalToConstant: contentView.bounds.height / 4.5),
            attendingDot.heightAnchor.constraint(equalToConstant: contentView.bounds.height / 4.5),
            createdDot.widthAnchor.constraint(equalToConstant: contentView.bounds.height / 4.5),
            createdDot.heightAnchor.constraint(equalToConstant: contentView.bounds.height / 4.5)
        ])
    }
    
    func configureDateCellViews() {
        let height = contentView.bounds.height / 4.5
        
        attendingDot.layer.cornerRadius = height / 2
        savedDot.layer.cornerRadius = height / 2
        createdDot.layer.cornerRadius = height / 2
    }
}

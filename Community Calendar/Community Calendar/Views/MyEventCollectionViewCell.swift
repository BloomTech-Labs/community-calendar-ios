//
//  MyEventCollectionViewCell.swift
//  Community Calendar
//
//  Created by Michael on 4/16/20.
//  Copyright © 2020 Mazjap Co. All rights reserved.
//

import UIKit
import MapKit

class MyEventCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Properties
    var event: FetchUserIdQuery.Data.User.CreatedEvent? {
        didSet {
            updateViews()
        }
    }
    
    
    // MARK: - IBOutlets
    @IBOutlet weak var eventNameLabel: UILabel!
    @IBOutlet weak var eventDateLabel: UILabel!
    @IBOutlet weak var eventLocationLabel: UILabel!
    @IBOutlet weak var eventImageView: UIImageView!
    @IBOutlet weak var imageCoverView: UIView!
    @IBOutlet weak var imageBackgroundView: UIView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupSubviews()
    }
    
    func updateViews() {
        guard
            let event = event,
            let urlString = event.eventImages?.first?.url,
            let url = URL(string: urlString),
            let data = try? Data(contentsOf: url),
            let city = event.locations?.first?.city,
            let state = event.locations?.first?.state,
            let date = backendDateFormatter.date(from: event.start)
            else { return }
        
        
        DispatchQueue.main.async {
            self.eventImageView.image = UIImage(data: data)
            self.eventNameLabel.text = event.title
            self.eventLocationLabel.text = "\(city), \(state)"
            self.eventDateLabel.text = dateFormatter.string(from: date)
        }
    }
    
    func getEventDate(date: Date) -> Date {
        let calendar = Calendar.current
        let dateComponents = calendar.dateComponents([.year, .month, .day], from: date)
        guard let timeComponents = calendar.date(from: dateComponents) else { return date }
        return timeComponents
    }
    
    func getEventTime(date: Date) -> Date {
        let calendar = Calendar.current
        let dateComponents = calendar.dateComponents([.hour, .minute, .second], from: date)
        guard let timeComponents = calendar.date(from: dateComponents) else { return date }
        return timeComponents
    }
    
    func setupSubviews() {
        
        imageBackgroundView.anchor(top: self.topAnchor, leading: self.leadingAnchor, trailing: nil, bottom: self.bottomAnchor, centerX: nil, centerY: nil, padding: .init(top: 8, left: 8, bottom: -8, right: 0), size: .zero)
        imageBackgroundView.layer.cornerRadius = 8
        imageBackgroundView.layer.masksToBounds = true
        imageBackgroundView.dropShadow()
        
        eventImageView.anchor(top: imageBackgroundView.topAnchor, leading: imageBackgroundView.leadingAnchor, trailing: imageBackgroundView.trailingAnchor, bottom: imageBackgroundView.bottomAnchor, centerX: nil, centerY: nil, padding: .zero, size: .zero)
        eventImageView.layer.masksToBounds = true
        eventImageView.layer.cornerRadius = 8
        eventImageView.contentMode = .scaleToFill
        NSLayoutConstraint.activate([
            imageBackgroundView.heightAnchor.constraint(equalToConstant: self.bounds.height - 16),
            imageBackgroundView.widthAnchor.constraint(equalToConstant: self.bounds.width / 4.5),
            eventImageView.heightAnchor.constraint(equalToConstant: self.bounds.height - 16),
            eventImageView.widthAnchor.constraint(equalToConstant: self.bounds.width / 4.5)
        ])
        
        
        eventNameLabel.anchor(top: self.topAnchor, leading: imageBackgroundView.trailingAnchor, trailing: self.trailingAnchor, bottom: nil, centerX: nil, centerY: nil, padding: .init(top: 8, left: 8, bottom: 0, right: -8), size: .zero)
        eventNameLabel.layer.shadowOpacity = 0.2
        eventNameLabel.layer.masksToBounds = false
        eventNameLabel.layer.shadowRadius = 2
        eventNameLabel.layer.shouldRasterize = true
        
        eventDateLabel.anchor(top: eventNameLabel.bottomAnchor, leading: imageBackgroundView.trailingAnchor, trailing: self.trailingAnchor, bottom: nil, centerX: nil, centerY: nil, padding: .init(top: 8, left: 8, bottom: 0, right: 0), size: .zero)
        eventDateLabel.layer.shadowOpacity = 0.2
        eventDateLabel.layer.masksToBounds = false
        eventDateLabel.layer.shadowRadius = 2
        eventDateLabel.layer.shouldRasterize = true
        
        eventLocationLabel.anchor(top: eventDateLabel.bottomAnchor, leading: imageBackgroundView.trailingAnchor, trailing: self.trailingAnchor, bottom: nil, centerX: nil, centerY: nil, padding: .init(top: 8, left: 8, bottom: 0, right: 0), size: .zero)
        eventLocationLabel.layer.shadowOpacity = 0.2
        eventLocationLabel.layer.masksToBounds = false
        eventLocationLabel.layer.shadowRadius = 2
        eventLocationLabel.layer.shouldRasterize = true
    }
    
//    func setupSubViews() {
//        contentView.anchor(top: self.topAnchor, leading: self.leadingAnchor, trailing: self.trailingAnchor, bottom: self.bottomAnchor, centerX: nil, centerY: nil, padding: .zero, size: .zero)
//        contentView.addSubview(imageBackgroundView)
//        contentView.addSubview(eventNameLabel)
//        contentView.backgroundColor = .white
//
//
//
//    imageBackgroundView.anchor(top: self.topAnchor, leading: self.leadingAnchor, trailing: nil, bottom: self.bottomAnchor, centerX: nil, centerY: nil, padding: .init(top: 8, left: 8, bottom: -8, right: 0), size: .zero)
//
//        imageBackgroundView.heightAnchor.constraint(equalToConstant: contentView.bounds.height - 16).isActive = true
//        imageBackgroundView.widthAnchor.constraint(equalToConstant: contentView.bounds.width / 4).isActive = true
//        imageBackgroundView.backgroundColor = .orange
//        imageBackgroundView.layer.cornerRadius = 8
//        imageBackgroundView.dropShadow()
//        imageBackgroundView.addSubview(eventImageView)
//
//        eventImageView.anchor(top: imageBackgroundView.topAnchor, leading: imageBackgroundView.leadingAnchor, trailing: imageBackgroundView.trailingAnchor, bottom: imageBackgroundView.bottomAnchor, centerX: nil, centerY: nil, padding: .zero, size: .zero)
//        eventImageView.layer.cornerRadius = 8
//        eventImageView.backgroundColor = .orange
//
//        eventNameLabel.anchor(top: contentView.topAnchor, leading: imageBackgroundView.trailingAnchor, trailing: contentView.trailingAnchor, bottom: nil, centerX: nil, centerY: nil, padding: .init(top: 8, left: 8, bottom: 0, right: 0), size: .zero)
//        eventNameLabel.widthAnchor.constraint(equalToConstant: (contentView.bounds.width / 4) * 3).isActive = true
//        eventNameLabel.textColor = .black
//        eventNameLabel.font = UIFont(name: "Poppins-SemiBold", size: 18)
//    }
}

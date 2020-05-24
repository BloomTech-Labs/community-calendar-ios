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
    var event: Event? {
        didSet {
            updateViews()
        }
    }
    
    // MARK: - IBOutlets
    @IBOutlet weak var eventNameLabel: UILabel!
    @IBOutlet weak var eventDateLabel: UILabel!
    @IBOutlet weak var eventLocationLabel: UILabel!
    @IBOutlet weak var eventImageView: UIImageView!
    @IBOutlet weak var imageBackgroundView: UIView!
    @IBOutlet weak var eventInfoStackView: UIStackView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setupSubviews()
        configureViews()
    }
    
    func updateViews() {
        guard
            let event = event,
            let urlString = event.image,
            let url = URL(string: urlString),
            let data = try? Data(contentsOf: url),
            let city = event.location?.city,
            let state = event.location?.state,
            let date = backendDateFormatter.date(from: event.start)
            else { return }
        
        DispatchQueue.main.async {
            self.eventImageView.image = UIImage(data: data)
            self.eventNameLabel.text = event.title
            self.eventLocationLabel.text = "\(city), \(state)"
            self.eventDateLabel.text = dateFormatter.string(from: date)
        }
    }
    
//    func getEventDate(date: Date) -> Date {
//        let calendar = Calendar.current
//        let dateComponents = calendar.dateComponents([.year, .month, .day], from: date)
//        guard let timeComponents = calendar.date(from: dateComponents) else { return date }
//        return timeComponents
//    }
    
//    func getEventTime(date: Date) -> Date {
//        let calendar = Calendar.current
//        let dateComponents = calendar.dateComponents([.hour, .minute, .second], from: date)
//        guard let timeComponents = calendar.date(from: dateComponents) else { return date }
//        return timeComponents
//    }
    
    func setupSubviews() {
        let height = contentView.bounds.height
        let insetHeight = height - 16
        
        imageBackgroundView.anchor(top: contentView.topAnchor, leading: contentView.leadingAnchor, trailing: nil, bottom: contentView.bottomAnchor, centerX: nil, centerY: contentView.centerYAnchor, padding: .init(top: 8, left: 8, bottom: -8, right: 0), size: .init(width: insetHeight, height: insetHeight))
        
        eventImageView.anchor(top: imageBackgroundView.topAnchor, leading: imageBackgroundView.leadingAnchor, trailing: imageBackgroundView.trailingAnchor, bottom: imageBackgroundView.bottomAnchor, centerX: nil, centerY: nil, padding: .zero, size: .zero)

        eventInfoStackView.anchor(top: nil, leading: imageBackgroundView.trailingAnchor, trailing: contentView.trailingAnchor, bottom: nil, centerX: nil, centerY: contentView.centerYAnchor, padding: .init(top: 0, left: 8, bottom: 0, right: 0), size: .zero)
        
        NSLayoutConstraint.activate([
            eventInfoStackView.topAnchor.constraint(greaterThanOrEqualTo: contentView.topAnchor, constant: 8),
            eventInfoStackView.bottomAnchor.constraint(greaterThanOrEqualTo: contentView.bottomAnchor, constant: -8)
        ])
        
//        eventNameLabel.anchor(top: self.topAnchor, leading: imageBackgroundView.trailingAnchor, trailing: self.trailingAnchor, bottom: nil, centerX: nil, centerY: nil, padding: .init(top: 8, left: 8, bottom: 0, right: -8), size: .zero)
//
//        eventDateLabel.anchor(top: eventNameLabel.bottomAnchor, leading: imageBackgroundView.trailingAnchor, trailing: self.trailingAnchor, bottom: nil, centerX: nil, centerY: nil, padding: .init(top: 8, left: 8, bottom: 0, right: 0), size: .zero)
//
//        eventLocationLabel.anchor(top: eventDateLabel.bottomAnchor, leading: imageBackgroundView.trailingAnchor, trailing: self.trailingAnchor, bottom: nil, centerX: nil, centerY: nil, padding: .init(top: 8, left: 8, bottom: 0, right: 0), size: .zero)
    }
    
    func configureViews() {
        imageBackgroundView.layer.cornerRadius = imageBackgroundView.bounds.height * 0.08
        eventImageView.layer.cornerRadius = imageBackgroundView.bounds.height * 0.08
        imageBackgroundView.layer.masksToBounds = true
        eventImageView.layer.masksToBounds = true
        eventImageView.contentMode = .scaleToFill
        imageBackgroundView.blackShadow()
        eventNameLabel.textShadow()
        eventDateLabel.textShadow()
        eventLocationLabel.textShadow()
    }
}

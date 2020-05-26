//
//  FeaturedCollectionViewCell.swift
//  Community Calendar
//
//  Created by Jordan Christensen on 12/16/19.
//  Copyright © 2019 Lambda School All rights reserved.
//

import UIKit

class FeaturedCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Properties
    var event: Event? {
        didSet {
            updateViews()
        }
    }
    
    
    var isFadeLayerSet = false
    var fadeLayer: CAGradientLayer!
    
    @IBOutlet weak var eventImageView: UIImageView!
    @IBOutlet private weak var fadeView: UIView!
    @IBOutlet private weak var eventTitleLabel: UILabel!
    @IBOutlet private weak var dateLabel: UILabel!
    @IBOutlet private weak var timeLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        updateViews()
        setupSubviews()
    }
    
    func updateViews() {
        guard
            let event = event,
            let startDate = backendDateFormatter.date(from: event.start),
            let endDate = backendDateFormatter.date(from: event.end)
            else { return }
        
        let startTime = cellDateFormatter.string(from: startDate)
        let endTime = cellDateFormatter.string(from: endDate)
        
        DispatchQueue.main.async {
            self.eventTitleLabel.text = event.title
            self.dateLabel.text = featuredEventDateFormatter.string(from: startDate)
            self.timeLabel.text = "\(startTime) - \(endTime)"
        }
    }
    
    func setupSubviews() {
        contentView.layer.cornerRadius = 8
        eventImageView.layer.cornerRadius = 8
        if !(isFadeLayerSet) { setFade() }
        eventImageView.layer.masksToBounds = true
        eventImageView.layer.shadowOpacity = 1.0
        eventImageView.layer.shadowRadius = 10
        eventImageView.layer.shouldRasterize = true
    }
    
    func getEventDate(date: Date) -> Date {
        var components = DateComponents()
        let calendar = Calendar.current
        let dateComponents = calendar.dateComponents([.year, .month, .day], from: date)
        components.year = dateComponents.year
        components.month = dateComponents.month
        components.day = dateComponents.day
        guard let updatedDate = calendar.date(from: components) else { return date }
        return updatedDate
    }
    
    func getEventTime(date: Date) -> Date {
        var components = DateComponents()
        let calendar = Calendar.current
        let dateComponents = calendar.dateComponents([.hour, .minute, .second], from: date)
        components.hour = dateComponents.hour
        components.minute = dateComponents.minute
        components.second = dateComponents.second
        guard let updatedDate = calendar.date(from: components) else { return date }
        return updatedDate
    }
    
//    private func setImage() {
//        if let imageURL = event?.images.first, !imageURL.isEmpty {
//            if controller?.cache.fetch(key: imageURL) == nil {
//                eventImageView.image = nil
//            }
//            controller?.fetchImage(for: imageURL)
//        } else {
//            if let indexPath = indexPath {
//                eventImageView.image = UIImage(named: "placeholder\(indexPath.row % 6)")
//                // Gives event an image when it doesn't have one. See Assests.xcassets
//            } else {
//                eventImageView.image = UIImage(named: "lambda")
//            }
//        }
//    }
    
//    @objc
//    func receiveImage(_ notification: Notification) {
//        guard let imageNot = notification.object as? ImageNotification else {
//            assertionFailure("Object type could not be inferred: \(notification.object as Any)")
//            return
//        }
//        if let eventImageUrl = event?.images.first, imageNot.url == eventImageUrl {
//            DispatchQueue.main.async {
//                self.eventImageView.image = imageNot.image
//            }
//        }
//    }
//
//    private func setDate() {
//        guard let startDate = event?.startDate else {
//            NSLog("\(#file):L\(#line): startDate: \(String(describing: event?.startDate)) is nil! Check \(#function)")
//            return
//        }
//        dateLabel.text = featuredEventDateFormatter.string(from: startDate)
//
//        if let endDate = event?.endDate {
//            timeLabel.text = "\(cellDateFormatter.string(from: startDate).lowercased()) - \(cellDateFormatter.string(from: endDate).lowercased())"
//        } else {
//            timeLabel.text = cellDateFormatter.string(from: startDate).lowercased()
//        }
//    }
    
    private func setFade() {
        fadeLayer = CAGradientLayer()
        fadeLayer.frame = fadeView.bounds
        fadeLayer.colors = [
            UIColor(red: 0, green: 0, blue: 0, alpha: 0).cgColor,
            UIColor(red: 0, green: 0, blue: 0, alpha: 0.9).cgColor
        ]
        fadeLayer.cornerRadius = 6
        fadeView.layer.insertSublayer(fadeLayer, at: 0)
        fadeView.layer.insertSublayer(fadeLayer, at: 0)
        fadeView.layer.insertSublayer(fadeLayer, at: 0)
        isFadeLayerSet = true
    }
    
//    func observeImage() {
//        NotificationCenter.default.addObserver(self, selector: #selector(receiveImage), name: .imageWasLoaded, object: nil)
//    }
}

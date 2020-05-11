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
    var event: FetchEventsQuery.Data.Event? {
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
    
    lazy var backendDateFormatter: DateFormatter = {
        let df = DateFormatter()
        df.timeZone = TimeZone(abbreviation: "MST")
        df.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
        return df
    }()
    
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
    }
    
    func updateViews() {
        guard
            let event = event,
            let urlString = event.eventImages?.first?.url,
            let url = URL(string: urlString),
            let data = try? Data(contentsOf: url),
            let date = backendDateFormatter.date(from: event.start)
            else { return }
        
        let onlyDate = self.getEventDate(date: date)
        let time = self.getEventTime(date: date)
        
        DispatchQueue.main.async {
            self.eventTitleLabel.text = event.title
            self.eventImageView.image = UIImage(data: data)
            self.dateLabel.text = self.dateFormatter.string(from: onlyDate)
            self.timeLabel.text = self.dateFormatter.string(from: time)
        }
        eventImageView.layer.cornerRadius = 6
        if !(isFadeLayerSet) { setFade() }
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

//
//  EventCollectionViewCell.swift
//  Community Calendar
//
//  Created by Jordan Christensen on 12/16/19.
//  Copyright © 2019 Lambda School All rights reserved.
//

import UIKit

class EventCollectionViewCell: UICollectionViewCell {
    
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
    
    // MARK: - IBOutlets
    @IBOutlet weak var eventImageView: UIImageView!
    @IBOutlet weak var districtNameLabel: UILabel!
    @IBOutlet weak var eventTitleLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        updateViews()
    }
    
    func getEventTime(date: Date) -> Date {
//        var extractedComponents = DateComponents()
        let calendar = Calendar.current
        let dateComponents = calendar.dateComponents([.hour, .minute, .second], from: date)
//        let timeComponents = calendar.dateComponents([.second, .minute, .hour], from: time)
        
//        extractedComponents.second = timeComponents.second
//        extractedComponents.minute = timeComponents.minute
//        extractedComponents.hour = timeComponents.hour
//        extractedComponents.day = dateComponents.day
//        extractedComponents.month = dateComponents.month
//        extractedComponents.year = dateComponents.year
        
        guard let timeComponents = calendar.date(from: dateComponents) else { return date }
        return timeComponents
    }
    
    func updateViews() {
        guard
            let event = event,
            let urlString = event.eventImages?.first?.url,
            let url = URL(string: urlString),
            let data = try? Data(contentsOf: url),
            let city = event.locations?.first?.city,
            let state = event.locations?.first?.state,
            let date = dateFormatter.date(from: event.start)
            else { return }
        
        let time = getEventTime(date: date)
        
        DispatchQueue.main.async {
            self.eventTitleLabel.text = event.title
            self.eventImageView.image = UIImage(data: data)
            self.districtNameLabel.text = "\(city), \(state)"
            self.timeLabel.text = self.dateFormatter.string(from: time)
        }
        eventImageView.layer.cornerRadius = 3
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
//
//        }
//    }
    
//    private func setDate() {
//        guard let startDate = event?.startDate else {
//            NSLog("\(#file):L\(#line): startDate: \(String(describing: event?.startDate)) is nil! Check \(#function)")
//            return
//        }
//        timeLabel.text = featuredEventDateFormatter.string(from: startDate)
//
//        if let endDate = event?.endDate {
//            timeLabel.text = "\(cellDateFormatter.string(from: startDate).lowercased()) - \(cellDateFormatter.string(from: endDate).lowercased())"
//        } else {
//            timeLabel.text = cellDateFormatter.string(from: startDate).lowercased()
//        }
//    }
    
//    func observeImage() {
//        NotificationCenter.default.addObserver(self, selector: #selector(receiveImage), name: .imageWasLoaded, object: nil)
//        // Notification pattern used because there are 3 different cells trying to access the same image, so when one of them finishes getting the image, the other 2 are notified with the same image.
//    }
}

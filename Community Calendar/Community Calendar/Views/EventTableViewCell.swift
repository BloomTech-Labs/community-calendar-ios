//
//  EventTableViewCell.swift
//  Community Calendar
//
//  Created by Jordan Christensen on 12/16/19.
//  Copyright © 2019 Lambda School All rights reserved.
//

import UIKit

class EventTableViewCell: UITableViewCell {

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
    @IBOutlet weak var districtNameLabel: UILabel!
    @IBOutlet weak var eventTitleLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var eventImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        updateViews()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func updateViews() {
        guard
            let event = event,
            let urlString = event.eventImages?.first?.url,
            let url = URL(string: urlString),
            let data = try? Data(contentsOf: url),
            let date = dateFormatter.date(from: event.start),
            let city = event.locations?.first?.city,
            let state = event.locations?.first?.state
            else { return }
        
        let time = getEventTime(date: date)
        DispatchQueue.main.async {
            self.eventImageView.image = UIImage(data: data)
            self.eventTitleLabel.text = event.title
            self.timeLabel.text = self.dateFormatter.string(from: time)
            self.districtNameLabel.text = "\(city), \(state)"
        }
//        guard let event = event, let _ = controller else { return }
//        eventImageView.layer.cornerRadius = 3
//        eventTitleLabel.text = event.title
//        setImage()
//        districtNameLabel.text = event.locations?.first?.city.uppercased()
//        setDate()
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

//    @IBAction func viewTapped(_ sender: Any) {
//
//    }
    
//    func observeImage() {
//        NotificationCenter.default.addObserver(self, selector: #selector(receiveImage), name: .imageWasLoaded, object: nil)
//    }
}

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
    @IBOutlet weak var eventNameLabel: UILabel!
    @IBOutlet weak var eventDateLabel: UILabel!
    @IBOutlet weak var eventLocationLabel: UILabel!
    @IBOutlet weak var eventImageView: UIImageView!
    @IBOutlet weak var imageCoverView: UIView!
    
    
//    override func apply(_ layoutAttributes: UICollectionViewLayoutAttributes) {
//        super.apply(layoutAttributes)
//       
//        let standardHeight = FeaturedCellLayoutConstants.Cell.standardHeight
//        let featuredHeight = FeaturedCellLayoutConstants.Cell.featuredHeight
//       
//        let delta = 1 - (
//            (featuredHeight - frame.height) / (featuredHeight - standardHeight)
//        )
//       
//        let minAlpha: CGFloat = 0.3
//        let maxAlpha: CGFloat = 0.75
//        imageCoverView.alpha = maxAlpha - (delta * (maxAlpha - minAlpha))
//        
//        let scale = max(delta, 0.5)
//        eventNameLabel.transform = CGAffineTransform(scaleX: scale, y: scale)
//        eventDateLabel.transform = CGAffineTransform(scaleX: scale, y: scale)
//        eventLocationLabel.transform = CGAffineTransform(scaleX: scale, y: scale)
//        
//        eventNameLabel.alpha = delta
//        eventDateLabel.alpha = delta
//        eventLocationLabel.alpha = delta
//        
//    }
    
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
        
        self.eventImageView.image = UIImage(data: data)
        self.eventNameLabel.text = event.title
        self.eventLocationLabel.text = "\(city), \(state)"
        self.eventDateLabel.text = self.dateFormatter.string(from: date)
        
//        DispatchQueue.main.async {
            
//        }
        eventImageView.layer.cornerRadius = 7
    }
}

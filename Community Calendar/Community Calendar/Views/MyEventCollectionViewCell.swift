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
    
    var event: EasyEvent? {
        didSet {
            updateViews()
        }
    }

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
            let city = event.city,
            let state = event.state,
            let venue = event.venueName
            else { return }
        
        eventNameLabel.text = event.eventName
        eventDateLabel.text = event.stringEventDate
        eventLocationLabel.text = "\(venue) - \(city), \(state)"
        eventImageView.image = event.eventImage
        eventImageView.layer.cornerRadius = 7
//        self.layer.cornerRadius = 7
//        self.layer.borderWidth = 1.5
//        self.layer.borderColor = UIColor.black.cgColor
    }
}

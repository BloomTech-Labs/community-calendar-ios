//
//  MyEventCollectionViewCell.swift
//  Community Calendar
//
//  Created by Michael on 4/16/20.
//  Copyright © 2020 Mazjap Co. All rights reserved.
//

import UIKit

class MyEventCollectionViewCell: UICollectionViewCell {
    
    var event: TestEventObject? {
        didSet {
            updateViews()
        }
    }
    @IBOutlet weak var eventNameLabel: UILabel!
    @IBOutlet weak var eventDateLabel: UILabel!
    @IBOutlet weak var eventLocationLabel: UILabel!
    @IBOutlet weak var eventImageView: UIImageView!
    @IBOutlet weak var imageCoverView: UIView!
    
    
    override func apply(_ layoutAttributes: UICollectionViewLayoutAttributes) {
        super.apply(layoutAttributes)
       
        let standardHeight = FeaturedCellLayoutConstants.Cell.standardHeight
        let featuredHeight = FeaturedCellLayoutConstants.Cell.featuredHeight
       
        let delta = 1 - (
            (featuredHeight - frame.height) / (featuredHeight - standardHeight)
        )
       
        let minAlpha: CGFloat = 0.3
        let maxAlpha: CGFloat = 0.75
        imageCoverView.alpha = maxAlpha - (delta * (maxAlpha - minAlpha))
        
        let scale = max(delta, 0.5)
        eventNameLabel.transform = CGAffineTransform(scaleX: scale, y: scale)
        
        eventDateLabel.alpha = delta
        eventLocationLabel.alpha = delta
        
    }
    
    func updateViews() {
        guard let event = event else { return }
        
        eventNameLabel.text = event.eventName
        eventDateLabel.text = event.eventDate
        eventLocationLabel.text = event.eventLocation
        eventImageView.image = event.eventImage
        self.layer.cornerRadius = 12
        self.layer.borderWidth = 5
        self.layer.borderColor = UIColor.black.cgColor
    }
}

//
//  FeaturedCollectionViewCell.swift
//  Community Calendar
//
//  Created by Jordan Christensen on 12/16/19.
//  Copyright © 2019 Mazjap Co. All rights reserved.
//

import UIKit

class FeaturedCollectionViewCell: UICollectionViewCell {
    var event: Event? {
        didSet { updateViews() }
    }
    
    var isFadeLayerSet = false
    
    var fadeLayer: CAGradientLayer!
    
    @IBOutlet weak var eventImageView: UIImageView!
    @IBOutlet weak var fadeView: UIView!
    @IBOutlet weak var eventTitleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    
    func updateViews() {
        guard let event = event else { return }
//        eventImageView.image = UIImage(named: event.image)
        eventImageView.layer.cornerRadius = 6
        eventTitleLabel.text = event.title

        fadeLayer = CAGradientLayer()
        fadeLayer.frame = fadeView.bounds
        fadeLayer.colors = [
            UIColor(red: 0, green: 0, blue: 0, alpha: 0).cgColor,
            UIColor(red: 0, green: 0, blue: 0, alpha: 0.9).cgColor
        ]
        fadeLayer.cornerRadius = 6
        if !(isFadeLayerSet) {
            fadeView.layer.insertSublayer(fadeLayer, at: 0)
            fadeView.layer.insertSublayer(fadeLayer, at: 0)
            fadeView.layer.insertSublayer(fadeLayer, at: 0)
            isFadeLayerSet = true
        }
        
        guard let startDate = event.startDate, let endDate = event.endDate else { return }
        dateLabel.text = featuredEventDateFormatter.string(from: startDate)
        timeLabel.text = "\(cellDateFormatter.string(from: startDate).lowercased()) - \(cellDateFormatter.string(from: endDate).lowercased())"
    }
}

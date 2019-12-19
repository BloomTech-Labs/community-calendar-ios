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
    
    var fadeLayer: CAGradientLayer!
    
    @IBOutlet weak var eventImageView: UIImageView!
    @IBOutlet weak var fadeView: UIView!
    @IBOutlet weak var eventTitleLabel: UILabel!
    
    func updateViews() {
        guard let event = event else { return }
        eventImageView.image = UIImage(named: event.image)
        eventImageView.layer.cornerRadius = 6
        eventTitleLabel.text = event.title

        fadeLayer = CAGradientLayer()
        fadeLayer.frame = fadeView.bounds
        fadeLayer.colors = [
            UIColor(red: 0, green: 0, blue: 0, alpha: 0).cgColor,
            UIColor(red: 0, green: 0, blue: 0, alpha: 0.9).cgColor
        ]
        fadeLayer.cornerRadius = 6
        fadeView.layer.insertSublayer(fadeLayer, at: 0)
    }
}

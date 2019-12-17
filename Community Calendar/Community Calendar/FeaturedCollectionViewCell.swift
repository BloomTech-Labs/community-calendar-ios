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
    
    @IBOutlet weak var eventImageView: UIImageView!
    @IBOutlet weak var fadeView: UIView!
    @IBOutlet weak var eventTitleLabel: UILabel!
    
    func updateViews() {
        guard let event = event else { return }
        eventImageView.image = UIImage(named: event.image)
        eventImageView.layer.cornerRadius = 6
        eventTitleLabel.text = event.title
        
        fadeView.backgroundColor = .clear


        let layer0 = CAGradientLayer()

        layer0.colors = [
          UIColor(red: 0, green: 0, blue: 0, alpha: 0).cgColor,
          UIColor(red: 0, green: 0, blue: 0, alpha: 1).cgColor
        ]

        layer0.locations = [0, 0.29]
        layer0.startPoint = CGPoint(x: 0.25, y: 0.5)
        layer0.endPoint = CGPoint(x: 0.75, y: 0.5)
        layer0.transform = CATransform3DMakeAffineTransform(CGAffineTransform(a: 0, b: 1, c: -1, d: 0, tx: 1, ty: 0))

        layer0.bounds = fadeView.bounds.insetBy(dx: -0.5 * fadeView.bounds.size.width, dy: -0.5 * fadeView.bounds.size.height)

        layer0.position = fadeView.center

        fadeView.layer.addSublayer(layer0)
    }
}

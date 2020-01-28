//
//  TagCollectionViewCell.swift
//  Community Calendar
//
//  Created by Jordan Christensen on 1/17/20.
//  Copyright © 2020 Mazjap Co. All rights reserved.
//

import UIKit

protocol FilterCellDelegate {
    func buttonTapped(cell: TagCollectionViewCell)
}

class TagCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var tagNameLabel: UILabel!
    @IBOutlet weak var tagButton: UIButton!
    @IBOutlet weak var tagBackgroundView: UIView!
    var isActive = false
    var filterTag: Tag? {
        didSet {
            updateViews()
        }
    }
    
    var delegate: FilterCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        updateViews()
    }
    
    func updateViews() {
        guard let tagButton = tagButton, let tag = filterTag else { return }
        
        if !isActive {
            tagButton.transform = CGAffineTransform(rotationAngle: -14.95)
            tagBackgroundView.backgroundColor = UIColor(red: 0.896, green: 0.896, blue: 0.896, alpha: 1)
        } else {
            tagButton.transform = CGAffineTransform(rotationAngle: 0)
            tagBackgroundView.backgroundColor = UIColor(red: 0.129, green: 0.141, blue: 0.173, alpha: 1)
        }
        tagBackgroundView.layer.cornerRadius = 11
        tagNameLabel.text = tag.title
    }
    
    
    @IBAction func buttonTapped(_ sender: UIButton) {
        delegate?.buttonTapped(cell: self)
    }
}

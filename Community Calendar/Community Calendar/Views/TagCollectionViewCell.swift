//
//  TagCollectionViewCell.swift
//  Community Calendar
//
//  Created by Jordan Christensen on 1/17/20.
//  Copyright © 2020 Lambda School All rights reserved.
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
        guard let tagNameLabel = tagNameLabel, let tag = filterTag else { return }
        tagBackgroundView.layer.cornerRadius = 11
        tagNameLabel.text = tag.title
    }
    
    
    @IBAction func buttonTapped(_ sender: UIButton) {
        delegate?.buttonTapped(cell: self)
    }
}

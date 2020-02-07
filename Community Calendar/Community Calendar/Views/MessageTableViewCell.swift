//
//  MessageTableViewCell.swift
//  Community Calendar
//
//  Created by Jordan Christensen on 2/3/20.
//  Copyright © 2020 Lambda School All rights reserved.
//

import UIKit

class MessageTableViewCell: UITableViewCell {
//    var message: Message? { // Update message object. I created just for testing
//        didSet {
//            updateViews()
//        }
//    }
    
    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var messageLabel: UILabel!
    
    override func layoutSubviews() {
        userImageView.layer.cornerRadius = userImageView.frame.height/2
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        updateViews()
    }
    
    func updateViews() {
        
    }
}

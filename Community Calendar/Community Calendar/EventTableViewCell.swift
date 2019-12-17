//
//  EventTableViewCell.swift
//  Community Calendar
//
//  Created by Jordan Christensen on 12/16/19.
//  Copyright © 2019 Mazjap Co. All rights reserved.
//

import UIKit

class EventTableViewCell: UITableViewCell {
    
    var event: Event? {
        didSet {
            updateViews()
        }
    }
    
    @IBOutlet weak var districtNameLabel: UILabel!
    @IBOutlet weak var eventTitleLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var eventImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    func updateViews() {
        guard let event = event else { return }
        eventImageView.image = UIImage(named: event.image)
        eventTitleLabel.text = event.title
        districtNameLabel.text = event.description
        timeLabel.text = ""
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }

    @IBAction func viewTapped(_ sender: Any) {
        
    }
}

//
//  DateHeader.swift
//  Community Calendar
//
//  Created by Michael on 5/17/20.
//  Copyright © 2020 Mazjap Co. All rights reserved.
//

import UIKit
import JTAppleCalendar

class DateHeader: JTACMonthReusableView {
    
    @IBOutlet weak var monthTitle: UILabel!
    @IBOutlet weak var sundayLabel: UILabel!
    @IBOutlet weak var mondayLabel: UILabel!
    @IBOutlet weak var tuesdayLabel: UILabel!
    @IBOutlet weak var wednesdayLabel: UILabel!
    @IBOutlet weak var thursdayLabel: UILabel!
    @IBOutlet weak var fridayLabel: UILabel!
    @IBOutlet weak var saturdayLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        constraintsCalendarHeader()
    }
    
    func constraintsCalendarHeader() {
        let collectionViewWidth = UIScreen.main.bounds.width - 40
        let width = collectionViewWidth / 7
        
        wednesdayLabel.anchor(top: nil, leading: nil, trailing: nil, bottom: self.bottomAnchor, centerX: self.centerXAnchor, centerY: nil, padding: .zero, size: .zero)
        
        tuesdayLabel.anchor(top: nil, leading: nil, trailing: wednesdayLabel.leadingAnchor, bottom: self.bottomAnchor, centerX: nil, centerY: nil, padding: .zero, size: .zero)
        
        mondayLabel.anchor(top: nil, leading: nil, trailing: tuesdayLabel.leadingAnchor, bottom: self.bottomAnchor, centerX: nil, centerY: nil, padding: .zero, size: .zero)
        
        sundayLabel.anchor(top: nil, leading: self.leadingAnchor, trailing: mondayLabel.leadingAnchor, bottom: self.bottomAnchor, centerX: nil, centerY: nil, padding: .zero, size: .zero)
        
        thursdayLabel.anchor(top: nil, leading: wednesdayLabel.trailingAnchor, trailing: nil, bottom: self.bottomAnchor, centerX: nil, centerY: nil, padding: .zero, size: .zero)
        
        fridayLabel.anchor(top: nil, leading: thursdayLabel.trailingAnchor, trailing: nil, bottom: self.bottomAnchor, centerX: nil, centerY: nil, padding: .zero, size: .zero)
        
        saturdayLabel.anchor(top: nil, leading: fridayLabel.trailingAnchor, trailing: self.trailingAnchor, bottom: self.bottomAnchor, centerX: nil, centerY: nil, padding: .zero, size: .zero)
        
        monthTitle.anchor(top: nil, leading: nil, trailing: nil, bottom: wednesdayLabel.topAnchor, centerX: self.centerXAnchor, centerY: nil, padding: .zero, size: .zero)
        
        NSLayoutConstraint.activate([
            sundayLabel.widthAnchor.constraint(equalToConstant: width),
            mondayLabel.widthAnchor.constraint(equalToConstant: width),
            tuesdayLabel.widthAnchor.constraint(equalToConstant: width),
            wednesdayLabel.widthAnchor.constraint(equalToConstant: width),
            thursdayLabel.widthAnchor.constraint(equalToConstant: width),
            fridayLabel.widthAnchor.constraint(equalToConstant: width),
            saturdayLabel.widthAnchor.constraint(equalToConstant: width)
        ])
    }
}

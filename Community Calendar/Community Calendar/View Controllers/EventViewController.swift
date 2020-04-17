//
//  EventViewController.swift
//  Community Calendar
//
//  Created by Jordan Christensen on 2/5/20.
//  Copyright © 2020 Lambda School All rights reserved.
//

import UIKit
import JTAppleCalendar

class EventViewController: UIViewController, ControllerDelegate {
    var controller: Controller?
    
    @IBOutlet weak var myEventsCollectionView: UICollectionView!
    @IBOutlet weak var calendarCollectionView: JTACMonthView!
    
    var myEvents: [TestEventObject] = []

    
    override func viewDidLoad() {
        super.viewDidLoad()
        addEvents()
        myEventsCollectionView.dataSource = self
        myEventsCollectionView.delegate = self
        calendarCollectionView.scrollingMode = .stopAtEachSection
        calendarCollectionView.scrollDirection = .horizontal
        calendarCollectionView.showsHorizontalScrollIndicator = false
        calendarCollectionView.layer.borderWidth = 2.0
        calendarCollectionView.layer.borderColor = UIColor.black.cgColor
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

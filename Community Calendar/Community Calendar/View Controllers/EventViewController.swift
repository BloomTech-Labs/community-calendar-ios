//
//  EventViewController.swift
//  Community Calendar
//
//  Created by Jordan Christensen on 2/5/20.
//  Copyright © 2020 Lambda School All rights reserved.
//

import UIKit
import FSCalendar

class EventViewController: UIViewController, ControllerDelegate {
   
    //MARK: - IBOutlets
    @IBOutlet weak var myEventsCollectionView: UICollectionView!
   
  
    
    
    //MARK: - Properties
    let tmController = TMEventController()
    var myEvents: [TestEventObject] = []
    var calendar = FSCalendar()
    var eventController: EventController?
    var controller: Controller?
    var events: [Event]?
    
    var repeatCount = 1
    
    var fetchEventsTimer: Timer?
    
    private var unfilteredEvents: [Event]? {        // Varible events' data source
        didSet {
            //todayTapped(UIButton())
        }
    }

    //MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addEvents()
        myEventsCollectionView.dataSource = self
        myEventsCollectionView.delegate = self
        setUpCalendar()
        fetchEvents()
        
        tmController.getEvents { _, _ in
            self.myEventsCollectionView.reloadData()
        }
    }
    

 

 //MARK: - GraphQL Fetch
        private func fetchEvents() {
            controller?.getEvents { result in
                switch result {
                case .success(let eventList):
                    if self.fetchEventsTimer != nil {
                        self.fetchEventsTimer!.invalidate()
                        self.fetchEventsTimer = nil
                        NSLog("Fetched events successfully after \(self.repeatCount) attempt\(self.repeatCount == 1 ? "" : "s")")
                        self.repeatCount = 1
                    }

                    if self.unfilteredEvents != eventList {

                        self.unfilteredEvents = self.fixDates(eventList)
                        self.viewDidLoad()
                     // createMockData()
                    }
                case .failure(let error):
                    NSLog("\(#file):L\(#line): Configuration failed inside \(#function) with error: \(error)")
                }
            }
        }
    
    private func fixDates(_ eventsList: [Event]) -> [Event] {
        var events = eventsList
        for (index, event) in events.enumerated() {
            if let startDate = event.startDate {
                events[index].startDate = backendDateFormatter.date(from: backendDateFormatter.string(from: startDate))
            }
            if let endDate = event.endDate {
                events[index].endDate = backendDateFormatter.date(from: backendDateFormatter.string(from: endDate))
            }
        }
        return events
    }

    
    
    private func setUpTimer() {
           fetchEventsTimer = Timer.scheduledTimer(withTimeInterval: 5.0, repeats: true) { timer in
               if self.repeatCount >= 4 {
                   timer.invalidate()
                   self.fetchEventsTimer = nil
                   self.repeatCount = 1
                   if self.unfilteredEvents == nil || self.unfilteredEvents?.isEmpty ?? true {
                       NSLog("Unable to fetch events, all attemps failed. Is device connected to internet?")
                       let alert = UIAlertController(title: "Unable to get events", message: "Please make sure your device is connect to wifi or cellular data.", preferredStyle: .alert)
                       DispatchQueue.main.async { self.present(alert, animated: true) }
                       Timer.scheduledTimer(withTimeInterval: 2.5, repeats: false) { _ in
                           alert.dismiss(animated: true, completion: nil)
                       }
                   } else {
                       NSLog("Timer is nil, but selector was called. Possible concurrency issue")
                   }
               } else {
                   print("Timer #\(self.repeatCount) ended")
                   self.repeatCount += 1
               }
           }
       }
    
    
 
    
    //MARK: - Calendar Setup
    func setUpCalendar(){
        
       let calendar = FSCalendar(frame: CGRect(x: 20, y: 20, width: 320, height: 720))
        calendar.dataSource = self
        calendar.delegate = self
        calendar.register(FSCalendarCell.self, forCellReuseIdentifier: "CELL")
        calendar.backgroundColor = .white
        calendar.layer.cornerRadius = 5
        calendar.layer.shadowRadius = 20
        calendar.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(calendar)
        self.calendar = calendar
        //calendar.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        calendar.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        calendar.topAnchor.constraint(equalToSystemSpacingBelow: view.topAnchor, multiplier: 6).isActive = true
        calendar.heightAnchor.constraint(equalToConstant: 417).isActive = true
        calendar.widthAnchor.constraint(equalToConstant: view.frame.width).isActive = true
    }
    
    
    

}

//MARK: - Calendar Delegation
extension EventViewController: FSCalendarDelegate, FSCalendarDataSource {

    
    func calendar(_ calendar: FSCalendar, cellFor date: Date, at position: FSCalendarMonthPosition) -> FSCalendarCell {
        let cell = calendar.dequeueReusableCell(withIdentifier: "CELL", for: date, at: position)
        
        return cell
    }
    
    func calendar(_ calendar: FSCalendar, numberOfEventsFor date: Date) -> Int {
        
        tmController.events.count
    }
    
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        //popView.isHidden.toggle() // Old Pop View Display.
        
    }
    
    func calendar(_ calendar: FSCalendar, didDeselect date: Date, at monthPosition: FSCalendarMonthPosition) {
        
        
    }
    
    func calendar(_ calendar: FSCalendar, shouldSelect date: Date, at monthPosition: FSCalendarMonthPosition) -> Bool {
        return monthPosition == FSCalendarMonthPosition.current
    }
    
    
    
    
        
    
}


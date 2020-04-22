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
    @IBOutlet weak var calendarView: UIView!
    
    
  
    
    
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
    func setUpCalendar() {
        calendarView.addSubview(calendar)
//        calendarView.layer.cornerRadius = 12
//        calendarView.layer.borderWidth = 2.0
//        calendarView.layer.borderColor = UIColor.black.cgColor
//        calendarView.layer.shadowRadius = 15
        calendar.anchor(top: calendarView.topAnchor, leading: calendarView.leadingAnchor, trailing: calendarView.trailingAnchor, bottom: calendarView.bottomAnchor, padding: .init(top: 0, left: 0, bottom: 0, right: 0), size: .zero)
    
        calendar.dataSource = self
        calendar.delegate = self
        calendar.register(FSCalendarCell.self, forCellReuseIdentifier: "CELL")
        calendar.addBorder(toSide: .Bottom, withColor: UIColor.black.cgColor, andThickness: 1.0)
        
//        calendar.backgroundColor = .white
//        calendar.layer.cornerRadius = 12
//        calendar.layer.shadowRadius = 20

//        calendar.translatesAutoresizingMaskIntoConstraints = false
//        view.addSubview(calendar)
    
    
    
    
    
//        calendar.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
//        calendar.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
//        calendar.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
//        calendar.bottomAnchor.constraint(equalTo: myEventsCollectionView.topAnchor, constant: -8).isActive = true
//        calendar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 8).isActive = true
    
    
    
    
//        calendar.topAnchor.constraint(equalToSystemSpacingBelow: view.topAnchor, multiplier: 6).isActive = true
//        calendar.heightAnchor.constraint(equalToConstant: 417).isActive = true
//        calendar.widthAnchor.constraint(equalToConstant: view.frame.width).isActive = true
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

extension UIView {
    enum ViewSide {
        case Left, Right, Top, Bottom
    }
    func addBorder(toSide side: ViewSide, withColor color: CGColor, andThickness thickness: CGFloat) {
        let border = CALayer()
        border.backgroundColor = color
        switch side {
        case .Left: border.frame = CGRect(x: frame.minX, y: frame.minY, width: thickness, height: frame.height); break
        case .Right: border.frame = CGRect(x: frame.maxX, y: frame.minY, width: thickness, height: frame.height); break
        case .Top: border.frame = CGRect(x: frame.minX, y: frame.minY, width: frame.width, height: thickness); break
        case .Bottom: border.frame = CGRect(x: frame.minX, y: frame.maxY, width: frame.width, height: thickness); break
        }
        layer.addSublayer(border)
    }
}

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
   
    @IBOutlet weak var myEventsCollectionView: UICollectionView!
   
    @IBOutlet var blueHeaderView: UIView!
    
    //MARK: - Properties
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
        setUp()
       // setPop() // Remove
        fetchEvents()
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

 //MARK: -
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
    //                    createMockData()
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
    
    
    //MARK: - Set Up Pop Up View for Date Selection
    
    
    var popView = UIView()
    let eventNameLabel = UILabel()
    let eventTimeLabel = UILabel()
    let eventDateLabel = UILabel()
    
    
  
    func setPop(){
        view.addSubview(popView)
        popView.translatesAutoresizingMaskIntoConstraints = false
        popView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        popView.widthAnchor.constraint(equalToConstant: view.bounds.width - 40).isActive = true

        popView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
       // popView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        popView.heightAnchor.constraint(equalToConstant: view.bounds.height / 2).isActive = true
        popView.backgroundColor = .red
        popView.isHidden = true
        self.popView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.hideItemDetailView)))

        popView.layer.cornerRadius = 25

        //Event Label for Pop Up View
        popView.addSubview(eventNameLabel)
        eventNameLabel.text = "Birthday"
        eventNameLabel.font = eventNameLabel.font.withSize(40)
        eventNameLabel.textColor = .white
        eventNameLabel.translatesAutoresizingMaskIntoConstraints = false
        eventNameLabel.topAnchor.constraint(equalTo: popView.topAnchor, constant: 10).isActive = true
        eventNameLabel.leadingAnchor.constraint(equalTo: popView.leadingAnchor, constant: 30).isActive = true
        eventNameLabel.trailingAnchor.constraint(equalTo: popView.trailingAnchor, constant: -30).isActive = true
        eventNameLabel.textAlignment = .center
        
        
        //Event Time Label
        popView.addSubview(eventTimeLabel)
        eventTimeLabel.text = "April 20th 2020"
        eventTimeLabel.font = eventTimeLabel.font.withSize(25)
        eventTimeLabel.textColor = .white
        eventTimeLabel.translatesAutoresizingMaskIntoConstraints = false
        
        eventTimeLabel.topAnchor.constraint(equalTo: eventNameLabel.topAnchor, constant: 50).isActive = true
        eventTimeLabel.leadingAnchor.constraint(equalTo: eventNameLabel.leadingAnchor, constant: 30).isActive = true
        eventTimeLabel.trailingAnchor.constraint(equalTo: eventNameLabel.trailingAnchor, constant: -30).isActive = true
        eventTimeLabel.textAlignment = .center
        
        
        

    }
    
    
    
  
    @objc func hideItemDetailView(){
        
        popView.isHidden.toggle()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        view.endEditing(true)
       // searchTextField.resignFirstResponder()
    }
    
    
    
    //MARK: - Calendar Setup
    func setUp(){
        
       let calendar = FSCalendar(frame: CGRect(x: 20, y: 20, width: 320, height: 330))
        calendar.dataSource = self
        calendar.delegate = self
        calendar.register(FSCalendarCell.self, forCellReuseIdentifier: "CELL")
        calendar.backgroundColor = .white
        calendar.layer.cornerRadius = 20
        calendar.layer.shadowRadius = 20
        calendar.layer.borderWidth = 2
        calendar.layer.borderColor = UIColor.black.cgColor
        calendar.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(calendar)
        self.calendar = calendar
        //calendar.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        calendar.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        calendar.topAnchor.constraint(equalToSystemSpacingBelow: view.topAnchor, multiplier: 9.5).isActive = true
        calendar.heightAnchor.constraint(equalToConstant: 385).isActive = true
        calendar.widthAnchor.constraint(equalToConstant: view.frame.width).isActive = true
        
        blueHeaderView.layer.cornerRadius = 25
        
    }
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    @IBAction func xTapped(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    

}
extension EventViewController: FSCalendarDelegate, FSCalendarDataSource {
//    func calendar(_ calendar: FSCalendar, titleFor date: Date) -> String? {
//        return "America"
//    }
//
//    func calendar(_ calendar: FSCalendar, subtitleFor date: Date) -> String? {
//        return "Rules"
//    }
    
    func calendar(_ calendar: FSCalendar, cellFor date: Date, at position: FSCalendarMonthPosition) -> FSCalendarCell {
        let cell = calendar.dequeueReusableCell(withIdentifier: "CELL", for: date, at: position)
        
        return cell
    }
    
    func calendar(_ calendar: FSCalendar, numberOfEventsFor date: Date) -> Int {
        
        //FIXME: Currently Nil
        events?.count ?? 0
    }
    
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        popView.isHidden.toggle()
        
       
    }
    
    
        
    
}


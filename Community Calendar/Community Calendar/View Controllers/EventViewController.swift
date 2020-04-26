//
//  EventViewController.swift
//  Community Calendar
//
//  Created by Jordan Christensen on 2/5/20.
//  Copyright © 2020 Lambda School All rights reserved.
//

import UIKit


enum MyTheme {
      case light
      case dark
  }

class EventViewController: UIViewController, ControllerDelegate {
   
    //MARK: - IBOutlets
    @IBOutlet weak var myEventsCollectionView: UICollectionView!
    @IBOutlet weak var calendarView: UIView!
    @IBOutlet weak var detailAndCalendarCollectionView: UICollectionView!
    
    
  
    
    
    //MARK: - Properties
    let tmController = TMEventController()
    var myEvents: [TestEventObject] = []
    var eventController: EventController?
    var controller: Controller?
    var events: [Event]?
    var detailEvent: EasyEvent?
    var scrollTimer: Timer?
    var featuredIndexPath: IndexPath? {
        didSet {
            
        }
    }
    
    
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
      
        fetchEvents()
        setupSubViews()
        
        
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

    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
    }
    
    @objc func updateIndexPath(_: Selector) {
        let featuredIndexPath = self.myEventsCollectionView.indexPathsForVisibleItems.first
        self.featuredIndexPath = featuredIndexPath
        print("This is the inside featuredIndexPath: \(String(describing: featuredIndexPath))")
        print("This is the outside featuredIndexPath: \(String(describing: self.featuredIndexPath))")
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let featuredIndexPath = self.myEventsCollectionView.indexPathsForVisibleItems.first
        self.featuredIndexPath = featuredIndexPath
        print("This is the inside featuredIndexPath: \(String(describing: featuredIndexPath))")
        print("This is the outside featuredIndexPath: \(String(describing: self.featuredIndexPath))")
        scrollView.decelerationRate = .fast
        scrollView.bouncesZoom = true
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
    
    func setupSubViews() {
        myEventsCollectionView.dataSource = self
        myEventsCollectionView.delegate = self
        detailAndCalendarCollectionView.dataSource = self
        detailAndCalendarCollectionView.delegate = self
        myEventsCollectionView.anchor(top: view.centerYAnchor, leading: view.leadingAnchor, trailing: view.trailingAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, centerX: nil, centerY: nil, padding: .init(top: -80, left: 0, bottom: 0, right: 0), size: .zero)
        detailAndCalendarCollectionView.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: view.leadingAnchor, trailing: view.trailingAnchor, bottom: myEventsCollectionView.topAnchor, centerX: nil, centerY: nil, padding: .init(top: 0, left: 0, bottom: 0, right: 0), size: .zero)
        if let flowLayout = detailAndCalendarCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            flowLayout.scrollDirection = .horizontal
            flowLayout.minimumLineSpacing = 0
            detailAndCalendarCollectionView.isPagingEnabled = true
            myEventsCollectionView.isPagingEnabled = true
        }
    }
 
    //MARK:- Custom Calendar

    
    var theme = MyTheme.light
    
    func calendarViewDidLoad() {
       // super.viewDidLoad()
        self.title = "My Calender"
        self.navigationController?.navigationBar.isTranslucent = false
        self.view.backgroundColor = Style.bgColor
        
        view.addSubview(calenderView)
        calenderView.topAnchor.constraint(equalTo: view.topAnchor, constant: 10).isActive = true
        calenderView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -12).isActive = true
        calenderView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 12).isActive = true
        calenderView.heightAnchor.constraint(equalToConstant: 365).isActive = true
        
        let rightBarBtn = UIBarButtonItem(title: "Light", style: .plain, target: self, action: #selector(rightBarBtnAction))
        self.navigationItem.rightBarButtonItem = rightBarBtn
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        calenderView.myCollectionView.collectionViewLayout.invalidateLayout()
    }
    
    // Light/ Dark Button Action
    @objc func rightBarBtnAction(sender: UIBarButtonItem) {
        if theme == .dark {
            sender.title = "Dark"
            theme = .light
            Style.themeLight()
        } else {
            sender.title = "Light"
            theme = .dark
            Style.themeDark()
        }
        self.view.backgroundColor = Style.bgColor
        calenderView.changeTheme()
    }
    
    let calenderView: CalenderView = {
        let v=CalenderView(theme: MyTheme.light)
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
}


    
    
    





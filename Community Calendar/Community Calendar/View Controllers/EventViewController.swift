//
//  EventViewController.swift
//  Community Calendar
//
//  Created by Jordan Christensen on 2/5/20.
//  Copyright © 2020 Lambda School All rights reserved.
//

import UIKit
import OktaOidc

enum MyTheme {
      case light
      case dark
  }

class EventViewController: UIViewController, ControllerDelegate {
 
    //MARK: - Properties
    var user: FetchUserIdQuery.Data.User? {
        didSet {
            print("Event View Controller User: \(String(describing: user))")
        }
    }
    
    var oktaUserInfo: [String]? {
        didSet {
            print("Event View Controller Okta ID: \(String(describing: oktaUserInfo?.first)), Okta Email: \(String(describing: oktaUserInfo?.last))")
        }
    }
    
    var authController: AuthController? {
        didSet {
            print("Event View Controller Auth Controller: \(String(describing: authController))")
        }
    }
    var apolloController: ApolloController? {
        didSet {
            print("Event View Controller Apollo Controller: \(String(describing: apolloController))")
        }
    }
    
    var apollo: ApolloController? = Apollo.shared
    
    var events: [FetchUserIdQuery.Data.User.CreatedEvent]? {
        didSet {
            self.myEventsCollectionView.reloadData()
            self.detailAndCalendarCollectionView.reloadData()
        }
    }
    var detailEvent: GetUsersCreatedEventsQuery.Data.User.CreatedEvent? {
        didSet {
            self.detailAndCalendarCollectionView.reloadData()
        }
    }
    
    var featuredIndexPath: IndexPath? {
        didSet {
            if let indexPath = featuredIndexPath {
                self.detailEvent = Apollo.shared.createdEvents[indexPath.item]
            } 
        }
    }
    
    //MARK: - IBOutlets
    
    @IBOutlet weak var myEventsCollectionView: UICollectionView!
    @IBOutlet weak var calendarView: UIView!
    @IBOutlet weak var detailAndCalendarCollectionView: UICollectionView!
   
    //MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupSubViews()
        getUsersEvents { result in
            
        }
    
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
    }
    
 //MARK: - GraphQL Fetch
    
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
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        guard let featuredIndexPath = self.myEventsCollectionView.indexPathsForVisibleItems.first else { return }
        if scrollView == myEventsCollectionView {
            self.featuredIndexPath = featuredIndexPath
            print("This is the inside featuredIndexPath: \(String(describing: featuredIndexPath))")
            print("This is the outside featuredIndexPath: \(String(describing: self.featuredIndexPath))")
            scrollView.decelerationRate = .fast
            scrollView.bouncesZoom = true
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
        }
        
        detailAndCalendarCollectionView.register(Detail_CalendarCollectionViewCell.self, forCellWithReuseIdentifier: "DetailCalendarCell")
    }
 
    //MARK:- Custom Calendar
    var theme = MyTheme.light
    
    func calendarViewDidLoad() {
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


    
    
    





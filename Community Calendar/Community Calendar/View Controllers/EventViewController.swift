//
//  EventViewController.swift
//  Community Calendar
//
//  Created by Jordan Christensen on 2/5/20.
//  Copyright © 2020 Lambda School All rights reserved.
//

import UIKit
import OktaOidc
import JTAppleCalendar

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
 
    var userEvents: UserEvents? {
        didSet {
            self.myEventsCollectionView.reloadData()
            self.calendarView.reloadData()
        }
    }
    var currentUser: FetchUserIdQuery.Data.User?
    var createdEvents: [FetchUserIdQuery.Data.User.CreatedEvent]? {
        didSet {
            self.populateDataSource()
        }
    }
    var attendingEvents: [FetchUserIdQuery.Data.User.Rsvp]? {
        didSet {
            self.populateDataSource()
        }
    }
    var savedEvents: [FetchUserIdQuery.Data.User.Saved]?
    var calendarDataSource: [String : String] = [:]
    var detailEvent: FetchUserIdQuery.Data.User.CreatedEvent? {
        didSet {
            self.calendarView.reloadData()
        }
    }
    
    var featuredIndexPath: IndexPath? {
        didSet {
            if let indexPath = featuredIndexPath {
                self.detailEvent = Apollo.shared.createdEvents[indexPath.item]
            } 
        }
    }
    
//    #colorLiteral(red: 1, green: 0.3987820148, blue: 0.4111615121, alpha: 1)
    
    //MARK: - IBOutlets
    
    @IBOutlet weak var calendarView: JTACMonthView!
    @IBOutlet weak var myEventsCollectionView: UICollectionView!
    @IBOutlet weak var attendingButton: UIButton!
    @IBOutlet weak var savedButton: UIButton!
    @IBOutlet weak var createdButton: UIButton!
    @IBOutlet weak var filterView: UIView!
    @IBOutlet weak var filterButtonStackView: UIStackView!
    @IBOutlet weak var menuButton: UIButton!
    
    
    //MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupSubViews()
        
        getUsersEvents { _ in
            self.createdButtonTapped(UIButton())
            
            
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if user == nil {
            if let accessToken = authController?.accessToken {
                authController?.getUser(completion: { result in
                    if let user = try? result.get() {
                        let oktaID = user.first
                    }
                })
            }
        }
    }
    
    
    // MARK: - IBActions
    
    @IBAction func attendingButtonTapped(_ sender: Any) {
        attendingButton.setAttributedTitle(createAttrText(with: "Attending", color: .selectedButton, fontName: PoppinsFont.semiBold.rawValue), for: .normal)
        savedButton.setAttributedTitle(createAttrText(with: "Saved", color: .unselectedDayButton, fontName: PoppinsFont.light.rawValue), for: .normal)
        createdButton.setAttributedTitle(createAttrText(with: "Created", color: .unselectedDayButton, fontName: PoppinsFont.light.rawValue), for: .normal)
        userEvents = .attending
//        detailAndCalendarCollectionView.reloadData()
//        myEventsCollectionView.reloadData()
                        
        
    }
    
    @IBAction func savedButtonTapped(_ sender: Any) {
        attendingButton.setAttributedTitle(createAttrText(with: "Attending", color: .unselectedDayButton, fontName: PoppinsFont.light.rawValue), for: .normal)
        savedButton.setAttributedTitle(createAttrText(with: "Saved", color: .selectedButton, fontName: PoppinsFont.semiBold.rawValue), for: .normal)
        createdButton.setAttributedTitle(createAttrText(with: "Created", color: .unselectedDayButton, fontName: PoppinsFont.light.rawValue), for: .normal)
        userEvents = .saved
        
    }
    
    @IBAction func createdButtonTapped(_ sender: Any) {
        attendingButton.setAttributedTitle(createAttrText(with: "Attending", color: .unselectedDayButton, fontName: PoppinsFont.light.rawValue), for: .normal)
        savedButton.setAttributedTitle(createAttrText(with: "Saved", color: .unselectedDayButton, fontName: PoppinsFont.light.rawValue), for: .normal)
        createdButton.setAttributedTitle(createAttrText(with: "Created", color: .selectedButton, fontName: PoppinsFont.semiBold.rawValue), for: .normal)
        userEvents = .created

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

        createdButtonTapped(UIButton())
//        let dynamicMargin = detailAndCalendarCollectionView.bounds.height / 5
        filterView.translatesAutoresizingMaskIntoConstraints = false
        calendarView.translatesAutoresizingMaskIntoConstraints = false
        
        calendarView.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height / 2.3).isActive = true
        calendarView.scrollDirection = .horizontal
        calendarView.scrollingMode = .stopAtEachCalendarFrame
        calendarView.showsHorizontalScrollIndicator = false
        
//        NSLayoutConstraint.activate([
//            filterView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
//            filterView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -dynamicMargin),
//            filterView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
//            filterView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
//            filterButtonStackView.centerXAnchor.constraint(equalTo: filterView.centerXAnchor),
//            filterButtonStackView.centerYAnchor.constraint(equalTo: filterView.centerYAnchor),
//            filterButtonStackView.topAnchor.constraint(equalTo: filterView.topAnchor, constant: 0),
//            filterButtonStackView.bottomAnchor.constraint(equalTo: filterView.bottomAnchor, constant: 0)
//        ])
//
//        detailAndCalendarCollectionView.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: view.leadingAnchor, trailing: view.trailingAnchor, bottom: filterView.topAnchor, centerX: nil, centerY: nil, padding: .init(top: 0, left: 0, bottom: 0, right: 0), size: .zero)
//
//        myEventsCollectionView.anchor(top: filterView.bottomAnchor, leading: view.leadingAnchor, trailing: view.trailingAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, centerX: nil, centerY: nil, padding: .init(top: 0, left: 0, bottom: 0, right: 0), size: .zero)
        
        
//        if let flowLayout = calendarView.collectionViewLayout as? UICollectionViewFlowLayout {
//            flowLayout.scrollDirection = .horizontal
//            flowLayout.minimumLineSpacing = 0
//            calendarView.isPagingEnabled = true
//        }
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
        let v=CalenderView()
        
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    func createAttrText(with title: String, color: UIColor, fontName: String) -> NSAttributedString {
        guard let font = UIFont(name: fontName, size: 14) else { return NSAttributedString() }
        let attrString = NSAttributedString(string: title,
                                            attributes: [NSAttributedString.Key.foregroundColor: color, NSAttributedString.Key.font: font])
        return attrString
    }
}


    
    
    





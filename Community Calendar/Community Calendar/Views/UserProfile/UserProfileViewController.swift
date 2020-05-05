//
//  UserProfileViewController.swift
//  Community Calendar
//
//  Created by Aaron Cleveland on 4/22/20.
//  Copyright © 2020 Lambda School Co. All rights reserved.
//

import UIKit
import OktaOidc

class UserProfileViewController: UIViewController, ControllerDelegate {

    var controller: Controller?
    var authController = AuthController()

    //=======================
    // MARK: - TopView
    let topView: UIView = {
        let topView = UIView()
        topView.translatesAutoresizingMaskIntoConstraints = false
        topView.backgroundColor = UIColor(named: "Shark")
        return topView
    }()

    let settingsButton: UIButton = {
        let settingsButton = UIButton()
        settingsButton.translatesAutoresizingMaskIntoConstraints = false
        settingsButton.setImage(UIImage(systemName: "gear"), for: .normal)
        settingsButton.tintColor = .white
        settingsButton.isUserInteractionEnabled = true
        settingsButton.addTarget(self, action: #selector(settingsPressed), for: .touchUpInside)
        return settingsButton
    }()

    let buttonLogout: UIButton = {
        let buttonLogout = UIButton(type: .system)
        buttonLogout.translatesAutoresizingMaskIntoConstraints = false
        buttonLogout.setTitle("Logout", for: .normal)
        buttonLogout.setTitleColor(.white, for: .normal)
        buttonLogout.isUserInteractionEnabled = true
        buttonLogout.addTarget(self, action: #selector(logoutButtonPressed(_:)), for: .touchUpInside)
        return buttonLogout
    }()

    let topInfoVStack: UIStackView = {
        let topInfoVStack = UIStackView()
        topInfoVStack.translatesAutoresizingMaskIntoConstraints = false
        topInfoVStack.axis = .vertical
        topInfoVStack.distribution = .fill
        topInfoVStack.alignment = .center
        topInfoVStack.spacing = 8
        return topInfoVStack
    }()

    let profileImage: UIButton = {
        let profileImage = UIButton()
        profileImage.translatesAutoresizingMaskIntoConstraints = false
        profileImage.backgroundColor = .gray
        profileImage.layer.cornerRadius = 50
        return profileImage
    }()

    let userName: UILabel = {
        let userName = UILabel()
        userName.translatesAutoresizingMaskIntoConstraints = false
        userName.font = .systemFont(ofSize: 16, weight: .medium)
        userName.text = "Aaron Cleveland"
        userName.textColor = .white
        return userName
    }()

    let userTitle: UILabel = {
        let userTitle = UILabel()
        userTitle.translatesAutoresizingMaskIntoConstraints = false
        userTitle.font = .systemFont(ofSize: 16, weight: .light)
        userTitle.text = "Event Organizer"
        userTitle.textColor = .lightGray
        return userTitle
    }()

    let topInfoHStack: UIStackView = {
        let topInfoHStack = UIStackView()
        topInfoHStack.translatesAutoresizingMaskIntoConstraints = false
        topInfoHStack.axis = .horizontal
        topInfoHStack.distribution = .fillEqually
        topInfoHStack.alignment = .fill
        return topInfoHStack
    }()

    let userEventsVStack: UIStackView = {
        let userEventsVStack = UIStackView()
        userEventsVStack.translatesAutoresizingMaskIntoConstraints = false
        userEventsVStack.axis = .vertical
        userEventsVStack.distribution = .fill
        userEventsVStack.alignment = .center
        return userEventsVStack
    }()

    let userEvents: UILabel = {
        let userEvents = UILabel()
        userEvents.translatesAutoresizingMaskIntoConstraints = false
        userEvents.font = .systemFont(ofSize: 16, weight: .ultraLight)
        userEvents.text = "Events Created"
        userEvents.textColor = .lightGray
        return userEvents
    }()

    let userEventsCount: UILabel = {
        let userEventsCount = UILabel()
        userEventsCount.translatesAutoresizingMaskIntoConstraints = false
        userEventsCount.font = .systemFont(ofSize: 16, weight: .light)
        userEventsCount.text = "69"
        userEventsCount.textColor = .white
        return userEventsCount
    }()

    let userFollowersVStack: UIStackView = {
        let userFollowersVStack = UIStackView()
        userFollowersVStack.translatesAutoresizingMaskIntoConstraints = false
        userFollowersVStack.axis = .vertical
        userFollowersVStack.distribution = .fill
        userFollowersVStack.alignment = .center
        return userFollowersVStack
    }()

    let userFollowers: UILabel = {
        let userFollowers = UILabel()
        userFollowers.translatesAutoresizingMaskIntoConstraints = false
        userFollowers.font = .systemFont(ofSize: 16, weight: .ultraLight)
        userFollowers.text = "Followers"
        userFollowers.textColor = .lightGray
        return userFollowers
    }()

    let userFollowersCount: UILabel = {
        let userFollowersCount = UILabel()
        userFollowersCount.translatesAutoresizingMaskIntoConstraints = false
        userFollowersCount.font = .systemFont(ofSize: 16, weight: .light)
        userFollowersCount.text = "1337"
        userFollowersCount.textColor = .white
        return userFollowersCount
    }()

    //=======================
    // MARK: - BottomView
    let bottomView: UIView = {
        let bottomView = UIView()
        bottomView.translatesAutoresizingMaskIntoConstraints = false
        bottomView.backgroundColor = .white
        return bottomView
    }()

    let tableFilterHStack: UIStackView = {
        let tableFilterHStack = UIStackView()
        tableFilterHStack.translatesAutoresizingMaskIntoConstraints = false
        tableFilterHStack.axis = .horizontal
        tableFilterHStack.alignment = .fill
        tableFilterHStack.distribution = .fillEqually
        return tableFilterHStack
    }()

    let notificationLabel: UILabel = {
        let notificationLabel = UILabel()
        notificationLabel.translatesAutoresizingMaskIntoConstraints = false
        notificationLabel.textColor = .gray
        notificationLabel.font = .systemFont(ofSize: 16, weight: .light)
        notificationLabel.text = "Activity"
        return notificationLabel
    }()

    let savedEventsLabel: UILabel = {
        let notificationLabel = UILabel()
        notificationLabel.translatesAutoresizingMaskIntoConstraints = false
        notificationLabel.textColor = .gray
        notificationLabel.font = .systemFont(ofSize: 16, weight: .light)
        notificationLabel.text = "Notifications"
        return notificationLabel
    }()

    let createdEventsLabel: UILabel = {
        let notificationLabel = UILabel()
        notificationLabel.translatesAutoresizingMaskIntoConstraints = false
        notificationLabel.textColor = .gray
        notificationLabel.font = .systemFont(ofSize: 16, weight: .light)
        notificationLabel.text = "Past Events"
        return notificationLabel
    }()

    let tableView: UITableView = {
        let tableview = UITableView()
        tableview.translatesAutoresizingMaskIntoConstraints = false
        return tableview
    }()

    let topHStack: UIStackView = {
        let topHStack = UIStackView()
        topHStack.translatesAutoresizingMaskIntoConstraints = false
        topHStack.axis = .horizontal
        topHStack.distribution = .fillEqually
        topHStack.alignment = .fill
        topHStack.spacing = 12
        return topHStack
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupSubviews()
        setupConstraints()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        loginUser()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        print(buttonLogout.bounds)
    }

    func loginUser() {
        authController.setupOktaOidc()
        authController.signIn(viewController: self) {
            if let accessToken = self.authController.stateManager?.accessToken {
                print("Access Token: \(accessToken)")
                self.authController.getUser()
            }
        }
    }

    @objc func logoutButtonPressed(_ sender: UIButton) {
        print("LOGOUT PRESSED")
        let alert = UIAlertController(title: "Success", message: "You have successfully logged out", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (_) in
            DispatchQueue.main.async {
                self.tabBarController?.selectedIndex = 0
            }
        }))
    }

    @objc func settingsPressed() {
        print("SETTINGS PRESSED")
        self.performSegue(withIdentifier: "SettingSegue", sender: self)
    }

    //=======================
    // MARK: - Helper Functions
    private func updateViews() {

    }
}

extension UIColor {
    convenience init(red: Int, green: Int, blue: Int) {
        let newRed = CGFloat(red)/255
        let newGreen = CGFloat(green)/255
        let newBlue = CGFloat(blue)/255

        self.init(red: newRed, green: newGreen, blue: newBlue, alpha: 1.0)
    }
}

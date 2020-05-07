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
    let eventController = EventController()
    
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

    let logOutAndInButton: UIButton = {
        let logOutAndInButton = UIButton(type: .system)
        logOutAndInButton.translatesAutoresizingMaskIntoConstraints = false
        logOutAndInButton.setTitle("Logout", for: .normal)
        logOutAndInButton.setTitleColor(.white, for: .normal)
        logOutAndInButton.isUserInteractionEnabled = true
        logOutAndInButton.addTarget(self, action: #selector(logoutButtonPressed(_:)), for: .touchUpInside)
        return logOutAndInButton
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

    let profileImage: UIImageView = {
        let profileImage = UIImageView()
        profileImage.translatesAutoresizingMaskIntoConstraints = false
        profileImage.backgroundColor = .gray
        profileImage.layer.cornerRadius = 50
        profileImage.layer.masksToBounds = true
        profileImage.contentMode = .scaleAspectFill
        return profileImage
    }()

    let userName: UILabel = {
        let userName = UILabel()
        userName.translatesAutoresizingMaskIntoConstraints = false
        userName.font = .systemFont(ofSize: 16, weight: .medium)
        userName.text = "No User Signed In"
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
        userEvents.isHidden = true
        return userEvents
    }()

    let userEventsCount: UILabel = {
        let userEventsCount = UILabel()
        userEventsCount.translatesAutoresizingMaskIntoConstraints = false
        userEventsCount.font = .systemFont(ofSize: 16, weight: .light)
        userEventsCount.text = "69"
        userEventsCount.textColor = .white
        userEventsCount.isHidden = true
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
        userFollowers.isHidden = true
        return userFollowers
    }()

    let userFollowersCount: UILabel = {
        let userFollowersCount = UILabel()
        userFollowersCount.translatesAutoresizingMaskIntoConstraints = false
        userFollowersCount.font = .systemFont(ofSize: 16, weight: .light)
        userFollowersCount.text = "1337"
        userFollowersCount.textColor = .white
        userFollowersCount.isHidden = true
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
        print(logOutAndInButton.bounds)
    }

    func loginUser() {
        authController.setupOktaOidc()
        authController.signIn(viewController: self) {
            if let accessToken = self.authController.stateManager?.accessToken {
                print("Access Token: \(accessToken)")
                self.authController.getUser { result in
                    guard let oktaID = try? result.get() else {
                        print("No Okta ID")
                        return
                    }
                    self.eventController.apollo = self.eventController.configureApolloClient(accessToken: accessToken)
                    self.eventController.fetchUserID(oktaID: oktaID) { result in
                        if let user = try? result.get() {
                            print("First Name: \(String(describing: user.firstName)), Last Name: \(String(describing: user.lastName)), profileImage: \(String(describing: user.profileImage))")
                            self.updateViews(user: user)
                        }
                    }
                }
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
    private func updateViews(user: FetchUserIdQuery.Data.User) {
        guard
            let urlString = user.profileImage,
            let url = URL(string: urlString),
            let data = try? Data(contentsOf: url),
            let firstName = user.firstName,
            let lastName = user.lastName
            else { return }
//        let base64Data = try? Data(base64Encoded: data)
//        eventController.perform(AddProfilePicMutation(image: base64Data, id: user.id)) { result in
//
//        }
        DispatchQueue.main.async {
            self.profileImage.image = UIImage(data: data)
            self.userName.text = "\(firstName) \(lastName)"
        }
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

//
//  UserProfileViewController.swift
//  Community Calendar
//
//  Created by Aaron Cleveland on 4/22/20.
//  Copyright © 2020 Lambda School Co. All rights reserved.
//

import UIKit

class UserProfileViewController: UIViewController {

    //=======================
    // MARK: - TopView
    let topView: UIView = {
        let topView = UIView()
        topView.translatesAutoresizingMaskIntoConstraints = false
        topView.backgroundColor = UIColor(named: "Shark")
        return topView
    }()

    let loginSignupButton: UIButton = {
        let loginSignupButton = UIButton(type: .system)
        loginSignupButton.translatesAutoresizingMaskIntoConstraints = false
        loginSignupButton.setImage(UIImage(systemName: "gear"), for: .normal)
        return loginSignupButton
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

    override func viewDidLoad() {
        super.viewDidLoad()
        setupSubviews()
        setupConstraints()
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

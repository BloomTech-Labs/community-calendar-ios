//
//  UserProfile+Extension.swift
//  Community Calendar
//
//  Created by Aaron Cleveland on 4/22/20.
//  Copyright © 2020 Lambda School All rights reserved.
//

import Foundation
import UIKit

extension UserProfileViewController {
    func setupSubviews() {
        topInfoVStack.addArrangedSubview(profileImage)
        topInfoVStack.addArrangedSubview(userName)
        topInfoVStack.addArrangedSubview(userTitle)

        topInfoHStack.addArrangedSubview(userEventsVStack)
        userEventsVStack.addArrangedSubview(userEvents)
        userEventsVStack.addArrangedSubview(userEventsCount)

        topInfoHStack.addArrangedSubview(userFollowersVStack)
        userFollowersVStack.addArrangedSubview(userFollowers)
        userFollowersVStack.addArrangedSubview(userFollowersCount)

        tableFilterHStack.addArrangedSubview(notificationLabel)
        tableFilterHStack.addArrangedSubview(savedEventsLabel)
        tableFilterHStack.addArrangedSubview(createdEventsLabel)

        bottomView.addSubview(tableView)
        bottomView.addSubview(tableFilterHStack)
        topView.addSubview(settingButton)
        topView.addSubview(topInfoHStack)
        topView.addSubview(topInfoVStack)
        view.addSubview(bottomView)
        view.addSubview(topView)
    }

    func setupConstraints() {
        NSLayoutConstraint.activate([
            topView.topAnchor.constraint(equalTo: view.topAnchor),
            topView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            topView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            topView.heightAnchor.constraint(equalToConstant: 275),

            settingButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 8),
            settingButton.leadingAnchor.constraint(equalTo: profileImage.trailingAnchor, constant: 80),
            settingButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),

            topInfoVStack.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 8),
            topInfoVStack.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 8),
            topInfoVStack.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -8),

            profileImage.heightAnchor.constraint(equalToConstant: 100),
            profileImage.widthAnchor.constraint(equalToConstant: 100),

            topInfoHStack.topAnchor.constraint(equalTo: topInfoVStack.bottomAnchor, constant: 8),
            topInfoHStack.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            topInfoHStack.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),

            bottomView.topAnchor.constraint(equalTo: topView.bottomAnchor),
            bottomView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            bottomView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            bottomView.bottomAnchor.constraint(equalTo: view.bottomAnchor),

            tableFilterHStack.topAnchor.constraint(equalTo: topView.bottomAnchor, constant: 20),
            tableFilterHStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            tableFilterHStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 20),
            tableFilterHStack.heightAnchor.constraint(equalToConstant: 25),

            tableView.topAnchor.constraint(equalTo: tableFilterHStack.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

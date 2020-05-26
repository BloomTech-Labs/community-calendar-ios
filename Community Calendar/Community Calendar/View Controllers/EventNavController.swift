//
//  HomeNavigationController.swift
//  Community Calendar
//
//  Created by Jordan Christensen on 2/5/20.
//  Copyright © 2020 Lambda School All rights reserved.
//

import UIKit
import OktaOidc

class EventNavController: UINavigationController, ControllerDelegate {
    
    var user: FetchUserIdQuery.Data.User? {
        didSet {
            passController()
        }
    }
    
    var oktaUserInfo: [String]? {
        didSet {
            passController()
        }
    }
    
    var authController: AuthController? {
        didSet {
            passController()
        }
    }
    
    var apolloController: ApolloController? {
        didSet {
            passController()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        passController()
    }
    
    func passController() {
        guard
            let apolloController = apolloController,
            let authController = authController,
            let user = user,
            let oktaUserInfo = oktaUserInfo
            else { return }
        for viewController in self.viewControllers {
            if var VC = viewController as? ControllerDelegate {
//                VC.apolloController = apolloController
//                VC.authController = authController
//                VC.user = user
//                VC.oktaUserInfo = oktaUserInfo
            }
        }
    }
}

//
//  EventTabBarController.swift
//  Community Calendar
//
//  Created by Jordan Christensen on 2/5/20.
//  Copyright © 2020 Lambda School All rights reserved.
//

import UIKit

protocol ControllerDelegate {
    var apolloController: ApolloController? { get set }
    var authController: AuthController? { get set }
    var user: FetchUserIdQuery.Data.User? { get set }
    var oktaUserInfo: [String]? { get set }
}

class EventTabBarController: UITabBarController {

    let apolloController = ApolloController()
    let authController = AuthController()
//    let controller = Controller()
    var user: FetchUserIdQuery.Data.User? {
        didSet {
            print("Current logged in user: \(String(describing: user))")
        }
    }
    var oktaUserInfo: [String]? {
        didSet {
            print("Okta ID: \(String(describing: oktaUserInfo?.first)), Okta email: \(String(describing: oktaUserInfo?.last))")
        }
    }
    @IBOutlet weak var eventTabBarController: UITabBar!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        authController.setupOktaOidc {
            
        }
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let nav = storyboard.instantiateViewController(identifier: "EventNavController") as! UINavigationController
        let homeVC = nav.topViewController as! HomeViewController
        homeVC.apolloController = self.apolloController
        homeVC.authController = self.authController
        homeVC.user = self.user
        homeVC.oktaUserInfo = self.oktaUserInfo
        
        self.checkAuthStatus {
            if let viewControllers = self.viewControllers {
                for viewController in viewControllers {
                    if var VC = viewController as? ControllerDelegate {
                        VC.apolloController = self.apolloController
                        VC.authController = self.authController
                        VC.user = self.user
                        VC.oktaUserInfo = self.oktaUserInfo
                    }
                }
            }
        }
        
        apolloController.fetchEvents { _ in
            
        }
    }
    
    func checkAuthStatus(completion: @escaping () -> Void) {
        guard let stateManager = authController.stateManager, let accessToken = authController.stateManager?.accessToken else {
            print("No state manager or access token. State Manager at load of Tab Bar Controller")
            completion()
            return
        }
        print("Already logged in: \(accessToken), State Manager: \(stateManager)")
        authController.validateAccessToken(accessToken: accessToken) { result in
            guard let isValid = try? result.get() else {
                print("Error validating access token at load of Tab bar Controller")
                completion()
                return
            }
            if isValid {
                self.authController.getUser { result in
                    guard let userInfo = try? result.get() else {
                        print("Error getting okta user info at load of Tab Bar Controller")
                        completion()
                        return
                    }
                    guard let oktaID = userInfo.first, let userEmail = userInfo.last else {
                        print("Returned out of okta ID or userEmail unwrapping at load of Tab Bar Controller")
                        completion()
                        return
                    }
                    self.oktaUserInfo?.append(oktaID)
                    self.oktaUserInfo?.append(userEmail)
                    self.apolloController.apollo = self.apolloController.configureApolloClient(accessToken: accessToken)
                    self.apolloController.fetchUserID(oktaID: oktaID) { result in
                        guard let user = try? result.get() else {
                            print("Unable to get currently logged in user at load of Tab Bar Controller")
                            completion()
                            return
                        }
                        self.user = user
                        self.authController.refreshAccessToken { _ in
                            completion()
                        }
                    }
                }
            }
        }
    }
}

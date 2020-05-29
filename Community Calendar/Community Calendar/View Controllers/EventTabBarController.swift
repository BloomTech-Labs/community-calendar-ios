//
//  EventTabBarController.swift
//  Community Calendar
//
//  Created by Jordan Christensen on 2/5/20.
//  Copyright © 2020 Lambda School All rights reserved.
//

import UIKit

protocol ControllerDelegate {
//    var apolloController: ApolloController? { get set }
//    var authController: AuthController? { get set }
//    var user: FetchUserIdQuery.Data.User? { get set }
//    var oktaUserInfo: [String]? { get set }
}

class EventTabBarController: UITabBarController {
    
    let apolloController = ApolloController()
    let authController = AuthController()
    
    @IBOutlet weak var eventTabBarController: UITabBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        authController.setupOktaOidc {
            self.checkCurrentuser()
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
//        authController.setupOktaOidc {
//            self.checkCurrentuser()
//        }
    }
    
//    self.checkAuthStatus {
//
//    }
    
    
    func checkCurrentuser() {
        if let oktaID = apolloController.defaults.string(forKey: UserDefaults.Keys.oktaID.rawValue), let accessToken = authController.stateManager?.accessToken {
            apolloController.apollo = apolloController.configureApolloClient(accessToken: accessToken)
            apolloController.fetchUserID(oktaID: oktaID) { result in
                if let user = try? result.get() {
                    let newUser = User(user: user)
                    print("Apollo Controller, Current User: \(String(describing: newUser)), User Events Count: \(String(describing: newUser.userEvents?.count))")
                }
            }
        }
    }
    
    func checkAuthStatus(completion: @escaping () -> Void) {
        guard let stateManager = authController.stateManager, let accessToken = authController.stateManager?.accessToken else {
            print("No state manager or access token. State Manager at load of Tab Bar Controller")
            completion()
            return
        }
        authController.accessToken = accessToken
        print("Already logged in: \(accessToken), State Manager: \(stateManager)")
//        authController.validateAccessToken(accessToken: accessToken) { result in
//            guard let isValid = try? result.get() else {
//                print("Error validating access token at load of Tab bar Controller")
//                completion()
//                return
//            }
//            if isValid {
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
//                    self.oktaUserInfo?.append(oktaID)
//                    self.oktaUserInfo?.append(userEmail)
                    self.apolloController.apollo = self.apolloController.configureApolloClient(accessToken: accessToken)
//                    self.apolloController.fetchUserID(oktaID: oktaID) { result in
//                        guard let user = try? result.get() else {
//                            print("Unable to get currently logged in user at load of Tab Bar Controller")
//
//                            completion()
//                            return
//                        }
////                        self.user = user
//
//                        self.authController.refreshAccessToken { _ in
//                            completion()
//                        }
//                    }
//                }
//            }
        }
    }
    
    func fetchAllEventData() {
        apolloController.fetchEvents { _ in

        }
        authController.stateManager?.getUser({ response, _  in
            if let response = response {
                let oktaID = response["sub"] as! String
                self.apolloController.fetchUserID(oktaID: oktaID) { result in
                    if let user = try? result.get(), let accessToken = self.authController.stateManager?.accessToken {
                        let userID = user.id
                        self.apolloController.getUserCreatedEvents(graphQLID: userID, accessToken: accessToken) { _ in

                        }
                    }
                }
            }
        })
    }
}

//        apolloController.fetchEvents { result in
//            if let events = try? result.get() {
//                print("Tab Bar Events Count: \(events.count)")
//            }
//        }
//        fetchAllEventData()
//        self.checkAuthStatus {
//            if let viewControllers = self.viewControllers {
//                for viewController in viewControllers {
//                    if var VC = viewController as? ControllerDelegate {
//                        VC.apolloController = self.apolloController
//                        VC.authController = self.authController
//                        VC.user = self.user
//                        VC.oktaUserInfo = self.oktaUserInfo

//                    }
//                }
//            }
//            if let accessToken = self.authController.stateManager?.accessToken {
//
//                self.apolloController.getUserCreatedEvents(graphQLID: user.id, accessToken: accessToken) { _ in
//
//                }
//            }

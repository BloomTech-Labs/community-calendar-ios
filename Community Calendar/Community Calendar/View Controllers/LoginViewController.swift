//
//  LoginViewController.swift
//  Community Calendar
//
//  Created by Hayden Hastings on 12/16/19.
//  Copyright © 2019 Mazjap Co. All rights reserved.
//

import UIKit
import Auth0
import SafariServices

class LoginViewController: UIViewController {
    // MARK: - Variables
    var homeController = HomeViewController()
    
    var onAuth: ((Result<Credentials>) -> ())!
    var credential: Credentials? {
        didSet {
            if self.credential == nil {
                self.tabBarController?.tabBarItem.title = "Login"
            } else {
                self.tabBarController?.tabBarItem.title = "Profile"
            }
        }
    }
    
    // MARK: - IBOutlets
    @IBOutlet weak var LoginButton: UIButton!
    @IBOutlet weak var logOutButton: UIButton!
    
    // MARK: - Lifecycle Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        
        logOutButton.isHidden = true
        LoginButton.isHidden = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        if credential == nil {
            loginOrSignUpButtonPressed(0)
        } else {
            print("Already signed in")
        }
    }
    
    // MARK: - Functions
    func logoutAlertController() {
        let alert = UIAlertController(title: "Success", message: "You have successfully logged out", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Ok", style: .default) { _ in
            DispatchQueue.main.async {
                self.tabBarController?.selectedIndex = 0
            }
        })
        
        DispatchQueue.main.async{
            self.presentedViewController?.dismiss(animated: false) {
                OperationQueue.main.addOperation {
                    self.present(alert, animated: true)
                }
            }
        }
    }
    
    // MARK: - IBAction
    @IBAction func loginOrSignUpButtonPressed(_ sender: Any) {
        Auth0
            .webAuth()
            .scope("openid profile")
            .audience("https://communitycalendar-staging.auth0.com/userinfo")
            .start {
                switch $0 {
                case .failure(let error):
                    // Handle the error
                    print("Error: \(error)")
                case .success(let credentials):
                    // Do something with credentials e.g.: save them.
                    // Auth0 will automatically dismiss the login page
                    DispatchQueue.main.async {
                        self.credential = credentials
                        self.tabBarItem.title = "Profile"
                        self.LoginButton.isHidden = true
                        self.logOutButton.isHidden = false
                    }
                    print("Credentials: \(credentials)")
                    DispatchQueue.main.async {
                        self.tabBarController?.selectedIndex = 0
                    }
                }
        }
    }
    
    @IBAction func logoutButtonPressed(_ sender: Any) {
        
        Auth0
            .webAuth()
            .clearSession(federated:false) {
                switch $0 {
                case true:
                    //                    self.LoginButton.isHidden = false
                    self.logOutButton.isHidden = true
                    self.credential = nil
                    self.tabBarItem.title = "Login"
                    self.logoutAlertController()
                case false:
                    print("User was not able to log out.")
                }
        }
    }
}

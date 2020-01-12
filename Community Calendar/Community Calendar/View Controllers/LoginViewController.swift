//
//  LoginViewController.swift
//  Community Calendar
//
//  Created by Hayden Hastings on 12/16/19.
//  Copyright © 2019 Mazjap Co. All rights reserved.
//

import UIKit
import Auth0

class LoginViewController: UIViewController {
    
    @IBOutlet weak var LoginButton: UIButton!
    @IBOutlet weak var logOutButton: UIButton!
    
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        logOutButton.isHidden = true
        
//        self.onAuth = { [weak self] in
//            switch $0 {
//            case .failure(let cause):
//                DispatchQueue.main.async {
//                    let alert = UIAlertController(title: "Auth Failed!", message: "\(cause)", preferredStyle: .alert)
//                    alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
//                    self?.present(alert, animated: true, completion: nil)
//                }
//            case .success(let credentials):
//                DispatchQueue.main.async {
//                    let token = credentials.accessToken ?? credentials.idToken
//                    let alert = UIAlertController(title: "Auth Success!", message: "Authorized and got a token \(String(describing: token))", preferredStyle: .alert)
//                    alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
//                    self?.present(alert, animated: true, completion: nil)
//                }
//            }
//            print($0)
//        }
        loginOrSignUpButtonPressed(0)
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
                }
        }
    }
    
    @IBAction func logoutButtonPressed(_ sender: Any) {
        
        Auth0
            .webAuth()
            .clearSession(federated:false) {
                switch $0 {
                case true:
                    self.LoginButton.isHidden = false
                    self.logOutButton.isHidden = true
                    self.credential = nil
                    self.tabBarItem.title = "Login"
                case false:
                    print("User was not able to log out.")
                }
        }
    }
}

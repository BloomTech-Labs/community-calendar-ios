//
//  LoginViewController.swift
//  Community Calendar
//
//  Created by Hayden Hastings on 12/16/19.
//  Copyright © 2019 Lambda School All rights reserved.
//
//  Dev Notes:
//  If you wanted to keep the user logged in even after closing the app,
//  there are some great docs on https://github.com/auth0/JWTDecode.swift.
//  (let jwt = try decode(jwt: token); jwt.expiresAt)
//  When opening the app, you can decode the token and see if it has already
//  expired, if not, refresh the token, if it has expired, log the user in again
//  Store the token in apple's keychain

import UIKit

class LoginViewController: UIViewController, ControllerDelegate {
    var controller: Controller?
    
//    // MARK: - Variables
//    var homeController = HomeViewController()
//    var controller: Controller?
//
//    var onAuth: ((Result<Credentials>) -> ())!
//    var credentials: Credentials? {
//        didSet {
//            controller?.userToken = self.credentials?.accessToken
//            getUserInfo()
//            DispatchQueue.main.async {
//                if self.credentials == nil {
//                    self.tabBarController?.tabBarItem.title = "Login"
//                } else {
//                    self.tabBarController?.tabBarItem.title = "Profile"
//                }
//            }
//        }
//    }
//    var profile: UserInfo? {
//        didSet {
//            updateViews()
//        }
//    }
    
    // MARK: - IBOutlets
    @IBOutlet weak var LoginButton: UIButton!
    @IBOutlet weak var logOutButton: UIButton!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    
    // MARK: - Lifecycle Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        
        logOutButton.isHidden = true
        LoginButton.isHidden = true
        
//        observeImage()
        imageView.layer.cornerRadius = imageView.frame.height / 2
    }
//
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(true)
//        if credentials == nil {
//            loginOrSignUpButtonPressed(0)
//            nameLabel.text = "Please log in"
//            imageView.isHidden = true
//        } else {
//            print("\(#function): User already signed in")
//            if let profile = profile {
//                nameLabel.text = "Name: \(profile.name ?? "Could not find name!")"
//                imageView.isHidden = false
//                if let picture = profile.picture {
//                    controller?.fetchImage(for: picture.absoluteString)
//                }
//            }
//        }
//    }
//
//    // MARK: - Functions
//    private func logoutAlertController() {
//        let alert = UIAlertController(title: "Success", message: "You have successfully logged out", preferredStyle: .alert)
//
//        alert.addAction(UIAlertAction(title: "Ok", style: .default) { _ in
//            DispatchQueue.main.async {
//                self.tabBarController?.selectedIndex = 0
//            }
//        })
//
//        DispatchQueue.main.async{
//            self.presentedViewController?.dismiss(animated: false) {
//                OperationQueue.main.addOperation {
//                    self.present(alert, animated: true)
//                }
//            }
//        }
//    }
//
//    private func getUserInfo() {
//        if credentials == nil {
//            NSLog("User has signed out")
//        } else {
//            guard let accessToken = credentials?.accessToken else {
//                NSLog("User is not logged in or access token has expired")
//                return
//            }
//            controller?.userToken = accessToken
//            Auth0.authentication().userInfo(withAccessToken: accessToken).start { result in
//                switch(result) {
//                case .success(let profile):
//                    self.profile = profile
//                    if let image = profile.picture?.absoluteString {
//                        self.controller?.fetchImage(for: image)
//                    }
//                case .failure(let error):
//                    print("Error: \(error)")
//                }
//            }
//        }
//    }
//
//    private func updateViews() {
//        if let profile = profile {
//            print("Email: \(profile.email ?? "No email"), name: \(profile.name ?? "No Name")")
//        }
//    }
    
    // MARK: - IBAction
//    @IBAction func loginOrSignUpButtonPressed(_ sender: Any) {
//        Auth0.webAuth().scope("openid profile").audience("https://community-calendar.auth0.com/api/v2/").start {
//            switch $0 {
//            case .failure(let error):
//                // Handle the error
//                print("Error: \(error)")
//            case .success(let credentials):
//                self.credentials = credentials
//                print("Credentials: \(credentials)")
//                DispatchQueue.main.async {
//                    self.tabBarItem.title = "Profile"
//                    self.tabBarController?.selectedIndex = 0
//                    self.LoginButton.isHidden = true
//                    self.logOutButton.isHidden = false
//                }
//            }
//        }
//    }
//    
//    @IBAction func logoutButtonPressed(_ sender: Any) {
//        
//        Auth0.webAuth().clearSession(federated:false) {
//            switch $0 {
//            case true:
//                self.logOutButton.isHidden = true
//                self.credentials = nil
//                self.tabBarItem.title = "Login"
//                self.logoutAlertController()
//            case false:
//                print("User was not able to log out.")
//            }
//        }
//    }
//    
//    @objc
//    func receiveImage(_ notification: Notification) {
//        guard let imageNot = notification.object as? ImageNotification else {
//            assertionFailure("Object type could not be inferred: \(notification.object as Any)")
//            return
//        }
//        if let imageURL = profile?.picture?.absoluteString, imageNot.url == imageURL {
//            DispatchQueue.main.async {
//                self.imageView.image = imageNot.image
//            }
//        }
//    }
//    
//    func observeImage() {
//        NotificationCenter.default.addObserver(self, selector: #selector(receiveImage), name: .imageWasLoaded, object: nil)
//    }

}

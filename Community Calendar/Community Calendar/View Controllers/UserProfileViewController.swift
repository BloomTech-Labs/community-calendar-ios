//
//  UserProfileViewController.swift
//  Community Calendar
//
//  Created by Aaron Cleveland on 4/22/20.
//  Copyright © 2020 Lambda School Co. All rights reserved.
//

import UIKit
import OktaOidc
import MapKit

class UserProfileViewController: UIViewController, ControllerDelegate {
 
    //MARK: - Properties
    var authController: AuthController? {
        didSet {
            authController?.setupOktaOidc {
                self.isUserLoggedIn()
            }
            print("User Profile View Controller Auth Controller: \(String(describing: authController))")
        }
    }
    
    var apolloController: ApolloController? {
        didSet {
            self.isUserLoggedIn()
            print("User Profile View Controller Apollo Controller: \(String(describing: apolloController))")
        }
    }
    
    let activityIndicator: UIActivityIndicatorView = {
        let activityView = UIActivityIndicatorView(style: .large)
        activityView.color = .white
        activityView.translatesAutoresizingMaskIntoConstraints = false
        activityView.backgroundColor = .clear
        return activityView
    }()
    
    let firstUnderlineView = UIView()
    let lastUnderlineView = UIView()
    let firstNameTextField = UITextField()
    let lastNameTextField = UITextField()
    let loginBackgroungView = UIView()
    let saveButton = UIButton()
    let cancelButton = UIButton()
    let saveBackgroundView = UIView()
    let settingsLauncher = SettingsLauncher()
    var currentUserName: String?
    var isEditingUser: Bool = false
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var cameraButton: UIButton!
    @IBOutlet weak var imageBackgroundView: UIView!
    @IBOutlet weak var imageBackgroundView2: UIView!
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var menuButton: UIButton!
    @IBOutlet weak var eventsCountStackView: UIStackView!
    @IBOutlet weak var eventsCreatedLabel: UILabel!
    @IBOutlet weak var numberOfEventsCreatedLabel: UILabel!
    @IBOutlet weak var eventsSavedLabel: UILabel!
    @IBOutlet weak var numberOfSavedLabel: UILabel!
    @IBOutlet weak var eventsAttendingLabel: UILabel!
    @IBOutlet weak var numberOfAttendingLabel: UILabel!
    
    // MARK: - Lifecycle Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSubView()
        configureViews()
        guard let tabBar = tabBarController as? EventTabBarController else { return }
        authController = tabBar.authController
        apolloController = tabBar.apolloController
        NotificationCenter.default.addObserver(self, selector: #selector(handleLogout), name: .handleLogout, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(editUserProfile), name: .editProfile, object: nil)
        isUserLoggedIn()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        guard let tabBar = tabBarController as? EventTabBarController else { return }
        
        if tabBar.authController.isUserLoggedIn {
            loginButton.isHidden = true
        } else {
            loginButton.isHidden = false
        }
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        cancelButton.addGradientToButton(color1: UIColor.coral, color2: UIColor.coralSubtleGradient)
        saveButton.addGradientToButton(color1: UIColor.coral, color2: UIColor.coralSubtleGradient)
        loginButton.addGradientToButton(color1: UIColor.coral, color2: UIColor.coralSubtleGradient)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        isUserLoggedIn()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    
    // MARK: - IBActions
    @IBAction func loginButtonTapped(_ sender: UIButton) {
        sender.loginSpring()
        loginUser()
    }
    
    @IBAction func menuButtonTapped(_ sender: Any) {
        if isEditingUser {
            self.isEditingUser = false
            editingUserProfile()
        } else {
            settingsLauncher.showSettings()
        }
    }
  
    @objc func cancelTapped() {
        isEditingUser = false
        editingUserProfile()
    }
    
    @objc func saveButtonTapped(_ sender: UIButton) {
        isEditingUser = false
        editingUserProfile()
        saveTapped()
    }
    
    @objc func handleLogout() {
        logoutUser()
    }
    
    @objc func editUserProfile() {
        isEditingUser = true
        editingUserProfile()
    }
    
    @IBAction func cameraButtonTapped(_ sender: Any) {
        presentImagePicker()
    }
}

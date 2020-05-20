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
    var user: FetchUserIdQuery.Data.User? {
        didSet {
            print("User Profile View Controller User: \(String(describing: user))")
        }
    }

    var oktaUserInfo: [String]? {
        didSet {
            print("User Profile View Controller Okta ID: \(String(describing: oktaUserInfo?.first)), Okta Email: \(String(describing: oktaUserInfo?.last))")
        }
    }
   
    var authController: AuthController? {
        didSet {
            print("User Profile View Controller Auth Controller: \(String(describing: authController))")
        }
    }
    var apolloController: ApolloController? {
        didSet {
            print("User Profile View Controller Apollo Controller: \(String(describing: apolloController))")
        }
    }
    let firstUnderlineView = UIView()
    let lastUnderlineView = UIView()
    let firstNameTextField = UITextField()
    let lastNameTextField = UITextField()
    let cancelButton = UIButton()
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
    @IBOutlet weak var saveButton: UIButton!
    
    // MARK: - Lifecycle Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSubView()
        NotificationCenter.default.addObserver(self, selector: #selector(handleLogout), name: .handleLogout, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(editUserProfile), name: .editProfile, object: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        authController?.getUser(completion: { result in
            if let user = try? result.get() {
                let email = user.last
                if email != nil {
                    self.emailLabel.text = email
                }
            }
        })
        
        fetchCreatedEvents {
            
        }
    }
    
    // MARK: - IBActions
    @IBAction func loginButtonTapped(_ sender: Any) {
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
    
    @objc func handleLogout() {
        logoutUser()
    }
    
    @objc func editUserProfile() {
        isEditingUser = true
        editingUserProfile()
    }
    
    @IBAction func saveTapped(_ sender: Any) {
        isEditingUser = false
        editingUserProfile()
        saveTapped()
    }
    
    @IBAction func cameraButtonTapped(_ sender: Any) {
        presentImagePicker()
    }
}

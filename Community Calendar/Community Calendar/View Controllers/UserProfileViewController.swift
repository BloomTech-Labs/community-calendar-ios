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
            print("User Profile View Controller Auth Controller: \(String(describing: authController))")
        }
    }
    var apolloController: ApolloController? {
        didSet {
            print("User Profile View Controller Apollo Controller: \(String(describing: apolloController))")
        }
    }
    var controller: Controller?
//    var authController = AuthController()
    var currentUserName: String?
    var isEditingUser: Bool = false
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var logoutButton: UIButton!
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var saveEditButton: UIButton!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var cameraButton: UIButton!
    @IBOutlet weak var eventsCreatedLabel: UILabel!
    @IBOutlet weak var numberOfEventsCreatedLabel: UILabel!
    @IBOutlet weak var userEventsCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSubView()
    }
    
    // MARK: - IBActions
    
    @IBAction func loginButtonTapped(_ sender: Any) {
        loginUser()
    }
    
    @IBAction func saveEditTapped(_ sender: Any) {
        self.isEditingUser.toggle()
        print(isEditingUser)
        if isEditingUser {
            editingUserProfile()
        } else {
            saveTapped()
        }
    }
    
    @IBAction func cameraButtonTapped(_ sender: Any) {
        presentImagePicker()
    }
}

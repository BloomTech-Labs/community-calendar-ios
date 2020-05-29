//
//  UserProfileVC.swift
//  Community Calendar
//
//  Created by Michael on 5/8/20.
//  Copyright © 2020 Mazjap Co. All rights reserved.
//

import UIKit
import Apollo

extension UserProfileViewController: UICollectionViewDelegateFlowLayout, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    
    
    func setupSubView() {
        
        //MARK: - Constraints
        cameraButton.translatesAutoresizingMaskIntoConstraints = false
        imageBackgroundView.translatesAutoresizingMaskIntoConstraints = false
        profileImageView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(firstNameTextField)
        view.addSubview(lastNameTextField)
        view.addSubview(firstUnderlineView)
        view.addSubview(lastUnderlineView)
        view.addSubview(loginBackgroungView)
        view.addSubview(cancelButton)
        view.addSubview(saveButton)
        topView.addSubview(activityIndicator)
                
        topView.anchor(top: view.topAnchor, leading: view.leadingAnchor, trailing: view.trailingAnchor, bottom: nil, centerX: nil, centerY: nil, padding: .zero, size: .zero)
        
        activityIndicator.anchor(top: nil, leading: nil, trailing: nil, bottom: nil, centerX: topView.centerXAnchor, centerY: topView.centerYAnchor, padding: .zero, size: .zero)
        
        imageBackgroundView.anchor(top: nil, leading: nil, trailing: nil, bottom: nil, centerX: topView.centerXAnchor, centerY: topView.centerYAnchor, padding: .zero, size: .init(width: UIScreen.main.bounds.width / 2.1, height: UIScreen.main.bounds.width / 2.1))
        
        imageBackgroundView2.anchor(top: imageBackgroundView.topAnchor, leading: imageBackgroundView.leadingAnchor, trailing: imageBackgroundView.trailingAnchor, bottom: imageBackgroundView.bottomAnchor, centerX: nil, centerY: nil, padding: .init(top: 10, left: 10, bottom: -10, right: -10), size: .zero)
        
        profileImageView.anchor(top: imageBackgroundView2.topAnchor, leading: imageBackgroundView2.leadingAnchor, trailing: imageBackgroundView2.trailingAnchor, bottom: imageBackgroundView2.bottomAnchor, centerX: nil, centerY: nil, padding: .init(top: 1, left: 1, bottom: -1, right: -1), size: .zero)
        
        nameLabel.anchor(top: imageBackgroundView.bottomAnchor, leading: nil, trailing: nil, bottom: nil, centerX: topView.centerXAnchor, centerY: nil, padding: .init(top: 12, left: 0, bottom: 0, right: 0), size: .zero)
        
        emailLabel.anchor(top: nameLabel.bottomAnchor, leading: nil, trailing: nil, bottom: nil, centerX: topView.centerXAnchor, centerY: nil, padding: .init(top: 2, left: 0, bottom: 0, right: 0), size: .zero)
        
        firstNameTextField.anchor(top: imageBackgroundView.bottomAnchor, leading: view.leadingAnchor, trailing: view.centerXAnchor, bottom: nil, centerX: nil, centerY: nil, padding: .init(top: 8, left: 20, bottom: 0, right: -20), size: .zero)
        
        lastNameTextField.anchor(top: imageBackgroundView.bottomAnchor, leading: view.centerXAnchor, trailing: view.trailingAnchor, bottom: nil, centerX: nil, centerY: nil, padding: .init(top: 8, left: 20, bottom: 0, right: -20), size: .zero)
        
        firstUnderlineView.anchor(top: firstNameTextField.bottomAnchor, leading: firstNameTextField.leadingAnchor, trailing: firstNameTextField.trailingAnchor, bottom: firstNameTextField.bottomAnchor, centerX: nil, centerY: nil, padding: .init(top: -1, left: -2, bottom: 1, right: 2), size: .zero)
        
        lastUnderlineView.anchor(top: lastNameTextField.bottomAnchor, leading: lastNameTextField.leadingAnchor, trailing: lastNameTextField.trailingAnchor, bottom: lastNameTextField.bottomAnchor, centerX: nil, centerY: nil, padding: .init(top: -1, left: -2, bottom: 1, right: 2), size: .zero)
        
        
        cancelButton.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: view.leadingAnchor, trailing: nil, bottom: nil, centerX: nil, centerY: nil, padding: .init(top: 20, left: 20, bottom: 0, right: 0), size: .init(width: UIScreen.main.bounds.width * 0.25, height: 35))
        
        saveButton.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: nil, trailing: view.trailingAnchor, bottom: nil, centerX: nil, centerY: nil, padding: .init(top: 20, left: 0, bottom: 0, right: -20), size: .init(width: UIScreen.main.bounds.width * 0.25, height: 35))
        
        menuButton.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: view.leadingAnchor, trailing: nil, bottom: nil, centerX: nil, centerY: nil, padding: .init(top: 20, left: 20, bottom: 0, right: 0), size: .init(width: 40, height: 40))
        
        eventsCountStackView.anchor(top: topView.bottomAnchor, leading: nil, trailing: nil, bottom: nil, centerX: view.centerXAnchor, centerY: nil, padding: .init(top: 20, left: 0, bottom: 0, right: 0), size: .zero)
        
        loginBackgroungView.anchor(top: topView.bottomAnchor, leading: nil, trailing: nil, bottom: nil, centerX: view.centerXAnchor, centerY: nil, padding: .init(top: 8, left: 0, bottom: 0, right: 0), size: .init(width: UIScreen.main.bounds.width * 0.25, height: 35))
        
        loginBackgroungView.addSubview(loginButton)
        
        loginButton.anchor(top: loginBackgroungView.topAnchor, leading: loginBackgroungView.leadingAnchor, trailing: loginBackgroungView.trailingAnchor, bottom: loginBackgroungView.bottomAnchor, centerX: nil, centerY: nil, padding: .zero, size: .zero)
        
        NSLayoutConstraint.activate([
            topView.heightAnchor.constraint(equalToConstant: view.bounds.height * 0.45),
            cameraButton.centerXAnchor.constraint(equalTo: profileImageView.centerXAnchor),
            cameraButton.centerYAnchor.constraint(equalTo: profileImageView.centerYAnchor),
            cameraButton.heightAnchor.constraint(equalTo: profileImageView.heightAnchor, multiplier: 0.3),
            cameraButton.widthAnchor.constraint(equalTo: profileImageView.widthAnchor, multiplier: 0.45),
//            loginButton.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width * 0.25)
        ])
    }

    func configureViews() {

        imageBackgroundView.layer.cornerRadius = UIScreen.main.bounds.width / 4.2
        imageBackgroundView2.layer.cornerRadius = UIScreen.main.bounds.width / 4.2 - 10
        imageBackgroundView2.backgroundColor = UIColor.coral
        profileImageView.layer.cornerRadius = UIScreen.main.bounds.width / 4.2 - 11
        profileImageView.layer.masksToBounds = true
        profileImageView.contentMode = .scaleAspectFill
        loginBackgroungView.layer.cornerRadius = 12
        loginButton.layer.cornerRadius = 12
        loginBackgroungView.backgroundColor = .clear
        
        cancelButton.isHidden = true
        cameraButton.isHidden = true
        cameraButton.alpha = 0.9
        saveButton.isHidden = true
        saveButton.layer.cornerRadius = 12
        cancelButton.layer.cornerRadius = 12
        cancelButton.backgroundColor = .clear
        cancelButton.layer.masksToBounds = true
        saveButton.layer.masksToBounds = true
        loginButton.layer.masksToBounds = true
        imageBackgroundView.layer.masksToBounds = true
        saveBackgroundView.layer.masksToBounds = true
        saveBackgroundView.isHidden = true
        topView.layer.masksToBounds = true
        cancelButton.setTitleColor(UIColor.white, for: .normal)
        cancelButton.titleLabel?.font = UIFont(name: PoppinsFont.regular.rawValue, size: 17)
        cancelButton.setTitle("Cancel", for: .normal)
        saveButton.setTitle("Save", for: .normal)
        saveButton.setTitleColor(UIColor.white, for: .normal)
        saveButton.titleLabel?.font = UIFont(name: PoppinsFont.regular.rawValue, size: 17)
        cancelButton.addTarget(self, action: #selector(cancelTapped), for: .touchUpInside)
        saveButton.addTarget(self, action: #selector(saveButtonTapped), for: .touchUpInside)
        firstNameTextField.textAlignment = .center
        lastNameTextField.textAlignment = .center
        lastNameTextField.textColor = .white
        firstNameTextField.textColor = .white
        firstNameTextField.layer.cornerRadius = 12
        lastNameTextField.layer.cornerRadius = 12
        firstUnderlineView.backgroundColor = UIColor.coral
        lastUnderlineView.backgroundColor = UIColor.coral
        lastNameTextField.borderStyle = .none
        firstNameTextField.borderStyle = .none
        lastNameTextField.backgroundColor = .clear
        firstNameTextField.backgroundColor = .clear
        firstUnderlineView.layer.cornerRadius = 0.5
        lastUnderlineView.layer.cornerRadius = 0.5
        firstUnderlineView.isHidden = true
        lastUnderlineView.isHidden = true
        firstNameTextField.isHidden = true
        lastNameTextField.isHidden = true
        imageBackgroundView.backgroundColor = .clear
        imageBackgroundView.shadowGradientProfileImage()
    }
    
    func loginUser() {
        guard let tabBar = tabBarController as? EventTabBarController else { return }
        
        tabBar.authController.signIn(viewController: self) { _ in
            if let accessToken = self.authController?.stateManager?.accessToken {
                print("Access Token: \(accessToken)")
                tabBar.authController.accessToken = accessToken
                self.loginButton.isHidden = true
                self.activityIndicator.startAnimating()
                self.authController?.getUser { result in
                    guard let userInfo = try? result.get() else {
                        print("No Okta Auth User Info")
                        DispatchQueue.main.async {
                            self.loginButton.isHidden = false
                        }
                        return
                    }
                    if let oktaID = userInfo.first, let username = userInfo.last {
                        self.emailLabel.text = username
                        tabBar.apolloController.apollo = tabBar.apolloController.configureApolloClient(accessToken: accessToken)
                        tabBar.apolloController.fetchUserID(oktaID: oktaID) { result in
                            if let user = try? result.get() {
                                tabBar.apolloController.defaults.set(oktaID, forKey: UserDefaults.Keys.oktaID.rawValue)
                                tabBar.apolloController.defaults.set(username, forKey: UserDefaults.Keys.oktaEmail.rawValue)
                                tabBar.apolloController.defaults.set(user.id, forKey: UserDefaults.Keys.graphQLID.rawValue)
                                print("At Sign In", tabBar.apolloController.defaults.string(forKey: UserDefaults.Keys.oktaID.rawValue) as Any)
                                print("At Sign In", tabBar.apolloController.defaults.string(forKey: UserDefaults.Keys.oktaEmail.rawValue) as Any)
                                print("At Sign In", tabBar.apolloController.defaults.string(forKey: UserDefaults.Keys.graphQLID.rawValue) as Any)
                                print("First Name: \(String(describing: user.firstName)), Last Name: \(String(describing: user.lastName)), profileImage: \(String(describing: user.profileImage))")
                                DispatchQueue.main.async {
                                    self.loginButton.isHidden = true
                                    self.activityIndicator.stopAnimating()
                                    self.updateViewsLogin(user: user)
                                }
                            }
                        }
                    }
                }
            }
        }
    }
    
    func logoutUser() {
        guard let tabBar = tabBarController as? EventTabBarController else { return }
        authController?.signOut(viewController: self, completion: {
            self.apolloController?.defaults.reset()
            self.authController?.accessToken = nil
            print(tabBar.authController.accessToken as Any)
            self.apolloController?.currentUserID = nil
            self.apolloController?.currentUser = nil
            print("After Log Out", tabBar.apolloController.defaults.string(forKey: UserDefaults.Keys.oktaID.rawValue) as Any)
            print("After Log Out", tabBar.apolloController.defaults.string(forKey: UserDefaults.Keys.oktaEmail.rawValue) as Any)
            print("After Log Out", tabBar.apolloController.defaults.string(forKey: UserDefaults.Keys.graphQLID.rawValue) as Any)
            DispatchQueue.main.async {
                self.presentUserInfoAlert(title: "Success!", message: "You have been successfully logged out.")
            }
            self.updateViewsLogout()
        })
    }
    
    func updateViewsLogout() {
        self.loginButton.isHidden = false
        self.profileImageView.isHidden = true
        self.emailLabel.isHidden = true
        self.eventsCreatedLabel.isHidden = true
        self.cameraButton.isHidden = true
        self.numberOfEventsCreatedLabel.isHidden = true
        self.imageBackgroundView.isHidden = true
        self.eventsCountStackView.isHidden = true
        self.menuButton.isHidden = true
        self.nameLabel.isHidden = true
        self.saveButton.isHidden = true
        self.cancelButton.isHidden = true
        self.saveButton.isHidden = true
        self.firstUnderlineView.isHidden = true
        self.lastUnderlineView.isHidden = true
        self.firstNameTextField.isHidden = true
        self.lastNameTextField.isHidden = true
    }
    
    func updateViewsLogin(user: FetchUserIdQuery.Data.User) {
        guard
            let urlString = user.profileImage,
            let url = URL(string: urlString),
            let data = try? Data(contentsOf: url),
            let firstName = user.firstName,
            let lastName = user.lastName
            else { return }
        self.currentUserName = "\(firstName) \(lastName)"

        DispatchQueue.main.async {
            if let tabBar = self.tabBarController as? EventTabBarController, let email = tabBar.apolloController.defaults.string(forKey: UserDefaults.Keys.oktaEmail.rawValue) {
                self.emailLabel.text = email
            }
            self.profileImageView.image = UIImage(data: data)
            self.settingsLauncher.profileImage = self.profileImageView.image
            self.settingsLauncher.firstName = firstName
            self.settingsLauncher.lastName = lastName
            self.imageBackgroundView.isHidden = false

            self.nameLabel.text = self.currentUserName
            self.emailLabel.isHidden = false
            self.profileImageView.isHidden = false
            self.loginButton.isHidden = true
            self.eventsCreatedLabel.isHidden = false
            self.numberOfEventsCreatedLabel.isHidden = false
            self.eventsCountStackView.isHidden = false
            self.menuButton.isHidden = false
            self.nameLabel.isHidden = false

            if let createdEvents = user.createdEvents {
                let createdCount = createdEvents.count
                self.numberOfEventsCreatedLabel.text = "\(createdCount)"
            }
            if let savedEvents = user.saved {
                let savedCount = savedEvents.count
                self.numberOfSavedLabel.text = "\(savedCount)"
            }
            if let attendingEvents = user.rsvps {
                let attendingCount = attendingEvents.count
                self.numberOfAttendingLabel.text = "\(attendingCount)"
            }
        }
    }
    
    func isUserLoggedIn() {
        guard let apolloController = apolloController else { return }
        if let user = apolloController.currentUser, let email = apolloController.defaults.string(forKey: UserDefaults.Keys.oktaEmail.rawValue) {
            profileImageView.image = user.userImage
            emailLabel.text = email
            if let firstName = user.firstName, let lastName = user.lastName {
                nameLabel.text = "\(firstName) \(lastName)"
            }
            if let attending = user.attendingCount {
                numberOfAttendingLabel.text = "\(attending)"
            }
            if let saved = user.savedCount {
                numberOfSavedLabel.text = "\(saved)"
            }
            if let created = user.createdCount {
                numberOfEventsCreatedLabel.text = "\(created)"
            }
        }else {
            updateViewsLogout()
        }
    }
    
    func editingUserProfile() {
        guard let apolloController = apolloController else { return }
        if isEditingUser {
            firstNameTextField.text = apolloController.currentUser?.firstName
            lastNameTextField.text = apolloController.currentUser?.lastName
            cameraButton.isHidden = false
            saveButton.isHidden = false
            cancelButton.isHidden = false
            firstUnderlineView.isHidden = false
            lastUnderlineView.isHidden = false
            firstNameTextField.isHidden = false
            lastNameTextField.isHidden = false
            saveBackgroundView.isHidden = false
            menuButton.isHidden = true
            nameLabel.isHidden = true
        } else {
            firstUnderlineView.isHidden = true
            lastUnderlineView.isHidden = true
            firstNameTextField.isHidden = true
            lastNameTextField.isHidden = true
            cameraButton.isHidden = true
            saveBackgroundView.isHidden = true
            saveButton.isHidden = true
            cancelButton.isHidden = true
            menuButton.isHidden = false
            nameLabel.isHidden = false
            guard
                let firstName = firstNameTextField.text,
                let lastName = lastNameTextField.text,
                !firstName.isEmpty,
                !lastName.isEmpty
                else { return }
            nameLabel.text = "\(firstName) \(lastName)"
            
        }
    }
    
    func saveTapped() {
        guard
            let firstName = firstNameTextField.text,
            let lastName = lastNameTextField.text,
            let apolloController = apolloController
            else { return }
        nameLabel.text = "\(firstName) \(lastName)"
        self.currentUserName = nameLabel.text
        
        if profileImageView.image != apolloController.currentUser?.userImage {
            if let imageData = profileImageView.image?.pngData(), let graphQLID = apolloController.currentUser?.id, let accessToken = authController?.stateManager?.accessToken {
                apolloController.hostImage(imageData: imageData, completion: { result in
                    guard let urlString = try? result.get() else { return }
                    print(urlString)
                    self.apolloController?.updateUserInfo(urlString: urlString, firstName: firstName, lastName: lastName, graphQLID: graphQLID, accessToken: accessToken, completion: { result in
                        guard let response = try? result.get() else { return }
                        let updatedImageURL = response.profileImage
                        let newFirstName = response.firstName
                        let newLastName = response.lastName
                        if let urlString = updatedImageURL, let url = URL(string: urlString), let data = try? Data(contentsOf: url) {
                            let newProfileImage = UIImage(data: data)
                            apolloController.currentUser?.userImage = newProfileImage
                        }
                        print("New Profile Image String: \(String(describing: updatedImageURL)), New First Name: \(String(describing: newFirstName)), New Last Name: \(String(describing: newLastName))")
                    })
                })
            }
        }
    }
    
    func presentImagePicker() {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.allowsEditing = true
        imagePicker.sourceType = .photoLibrary
        present(imagePicker, animated: true)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let editedImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
            profileImageView.image = editedImage
        } else if let originalImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            profileImageView.image = originalImage
        }
        dismiss(animated: true, completion: nil)
    }
}

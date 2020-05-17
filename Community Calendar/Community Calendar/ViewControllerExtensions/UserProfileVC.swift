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
        
        view.addSubview(cancelButton)
        view.addSubview(firstNameTextField)
        view.addSubview(lastNameTextField)
        view.addSubview(firstUnderlineView)
        view.addSubview(lastUnderlineView)
        
        cancelButton.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: view.leadingAnchor, trailing: nil, bottom: nil, centerX: nil, centerY: nil, padding: .init(top: 20, left: 20, bottom: 0, right: 0), size: .zero)
        
        menuButton.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: view.leadingAnchor, trailing: nil, bottom: nil, centerX: nil, centerY: nil, padding: .init(top: 20, left: 20, bottom: 0, right: 0), size: .init(width: 40, height: 40))
        
        saveButton.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: nil, trailing: view.trailingAnchor, bottom: nil, centerX: nil, centerY: nil, padding: .init(top: 20, left: 0, bottom: 0, right: -20), size: .zero)
        
        imageBackgroundView.anchor(top: saveButton.bottomAnchor, leading: nil, trailing: nil, bottom: nil, centerX: view.centerXAnchor, centerY: nil, padding: .zero, size: .init(width: view.bounds.width / 2, height: view.bounds.width / 2))
        
        profileImageView.anchor(top: imageBackgroundView.topAnchor, leading: imageBackgroundView.leadingAnchor, trailing: imageBackgroundView.trailingAnchor, bottom: imageBackgroundView.bottomAnchor, centerX: nil, centerY: nil, padding: .init(top: 1, left: 1, bottom: -1, right: -1), size: .zero)
        
        firstNameTextField.anchor(top: imageBackgroundView.bottomAnchor, leading: view.leadingAnchor, trailing: view.centerXAnchor, bottom: nil, centerX: nil, centerY: nil, padding: .init(top: 8, left: 20, bottom: 0, right: -20), size: .zero)
        
        lastNameTextField.anchor(top: imageBackgroundView.bottomAnchor, leading: view.centerXAnchor, trailing: view.trailingAnchor, bottom: nil, centerX: nil, centerY: nil, padding: .init(top: 8, left: 20, bottom: 0, right: -20), size: .zero)
        
        firstUnderlineView.anchor(top: firstNameTextField.bottomAnchor, leading: firstNameTextField.leadingAnchor, trailing: firstNameTextField.trailingAnchor, bottom: firstNameTextField.bottomAnchor, centerX: nil, centerY: nil, padding: .init(top: -1, left: -2, bottom: 1, right: 2), size: .zero)
        
        lastUnderlineView.anchor(top: lastNameTextField.bottomAnchor, leading: lastNameTextField.leadingAnchor, trailing: lastNameTextField.trailingAnchor, bottom: lastNameTextField.bottomAnchor, centerX: nil, centerY: nil, padding: .init(top: -1, left: -2, bottom: 1, right: 2), size: .zero)
        
        nameLabel.anchor(top: imageBackgroundView.bottomAnchor, leading: view.leadingAnchor, trailing: view.trailingAnchor, bottom: nil, centerX: nil, centerY: nil, padding: .init(top: 8, left: 20, bottom: 0, right: -20), size: .zero)
        
        emailLabel.anchor(top: nameLabel.bottomAnchor, leading: view.leadingAnchor, trailing: view.trailingAnchor, bottom: nil, centerX: nil, centerY: nil, padding: .init(top: 8, left: 20, bottom: 0, right: -20), size: .zero)
        
        topView.anchor(top: view.topAnchor, leading: view.leadingAnchor, trailing: view.trailingAnchor, bottom: emailLabel.bottomAnchor, centerX: nil, centerY: nil, padding: .init(top: 0, left: 0, bottom: 8, right: 0), size: .zero)
        
        eventsCountStackView.anchor(top: topView.bottomAnchor, leading: view.leadingAnchor, trailing: view.trailingAnchor, bottom: nil, centerX: view.centerXAnchor, centerY: nil, padding: .init(top: 20, left: 20, bottom: 0, right: -20), size: .zero)
        
        NSLayoutConstraint.activate([
            cameraButton.centerXAnchor.constraint(equalTo: profileImageView.centerXAnchor),
            cameraButton.centerYAnchor.constraint(equalTo: profileImageView.centerYAnchor),
            cameraButton.heightAnchor.constraint(equalTo: profileImageView.heightAnchor, multiplier: 0.3),
            cameraButton.widthAnchor.constraint(equalTo: profileImageView.widthAnchor, multiplier: 0.45),
            saveButton.widthAnchor.constraint(equalToConstant: loginButton.bounds.width * 0.7),
            cancelButton.widthAnchor.constraint(equalToConstant: loginButton.bounds.width * 0.7)
        ])
        
         
        imageBackgroundView.layer.cornerRadius = imageBackgroundView.bounds.height / 2
        imageBackgroundView.blackShadow()
        loginButton.blackShadow()
        profileImageView.layer.cornerRadius = profileImageView.bounds.height / 2
        profileImageView.layer.masksToBounds = true
        profileImageView.contentMode = .scaleAspectFill
        loginButton.layer.cornerRadius = 12
        cancelButton.isHidden = true
        cameraButton.isHidden = true    
        saveButton.isHidden = true
        saveButton.layer.cornerRadius = 12
        cancelButton.layer.cornerRadius = 12
        cancelButton.backgroundColor = .link
        saveButton.backgroundColor = .link
        cancelButton.whiteShadow()
        saveButton.whiteShadow()
        cancelButton.setTitleColor(UIColor.white, for: .normal)
        cancelButton.titleLabel?.font = UIFont(name: PoppinsFont.semiBold.rawValue, size: 17)
        cancelButton.setTitle("Cancel", for: .normal)
        saveButton.setTitleColor(UIColor.white, for: .normal)
        saveButton.titleLabel?.font = UIFont(name: PoppinsFont.semiBold.rawValue, size: 17)
        cancelButton.addTarget(self, action: #selector(cancelTapped), for: .touchUpInside)
        firstNameTextField.textAlignment = .center
        lastNameTextField.textAlignment = .center
        lastNameTextField.textColor = .white
        firstNameTextField.textColor = .white
        firstNameTextField.layer.cornerRadius = 12
        lastNameTextField.layer.cornerRadius = 12
        firstUnderlineView.backgroundColor = #colorLiteral(red: 0.7410163879, green: 0.4183317125, blue: 0.4147843719, alpha: 1)
        lastUnderlineView.backgroundColor = #colorLiteral(red: 0.7410163879, green: 0.4183317125, blue: 0.4147843719, alpha: 1)
        lastNameTextField.borderStyle = .none
        firstNameTextField.borderStyle = .none
        lastNameTextField.backgroundColor = #colorLiteral(red: 0.1721869707, green: 0.1871494651, blue: 0.2290506661, alpha: 1)
        firstNameTextField.backgroundColor = #colorLiteral(red: 0.1721869707, green: 0.1871494651, blue: 0.2290506661, alpha: 1)
        firstUnderlineView.layer.cornerRadius = 0.5
        lastUnderlineView.layer.cornerRadius = 0.5
        self.firstUnderlineView.isHidden = true
        self.lastUnderlineView.isHidden = true
        self.firstNameTextField.isHidden = true
        self.lastNameTextField.isHidden = true
        
        
        if let user = user {
            updateViewsLogin(user: user)
        } else {
            updateViewsLogout()
        }
    }

    func loginUser() {
        loginButton.isHidden = true
        guard let apolloController = apolloController else { return }
        authController?.signIn(viewController: self) { _ in
            if let accessToken = self.authController?.stateManager?.accessToken {
                print("Access Token: \(accessToken)")
                self.authController?.getUser { result in
                    guard let userInfo = try? result.get() else {
                        print("No Okta Auth User Info")
                        return
                    }
                    if let oktaID = userInfo.first, let username = userInfo.last {
                        self.emailLabel.text = username
                        self.apolloController?.apollo = apolloController.configureApolloClient(accessToken: accessToken)
                        self.apolloController?.fetchUserID(oktaID: oktaID) { result in
                            if let user = try? result.get() {
                                print("First Name: \(String(describing: user.firstName)), Last Name: \(String(describing: user.lastName)), profileImage: \(String(describing: user.profileImage))")
                                DispatchQueue.main.async {
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
        authController?.signOut(viewController: self, completion: {
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
            } else {
                self.numberOfEventsCreatedLabel.text = "0"
            }
            if let savedEvents = user.saved {
                let savedCount = savedEvents.count
                self.numberOfSavedLabel.text = "\(savedCount)"
            } else {
                self.numberOfSavedLabel.text = "0"
            }
            if let attendingEvents = user.rsvps {
                let attendingCount = attendingEvents.count
                self.numberOfAttendingLabel.text = "\(attendingCount)"
            } else {
                self.numberOfAttendingLabel.text = "0"
            }
        }
    }
    
    func editingUserProfile() {
        if isEditingUser {
            let fullName = currentUserName
            let nameArray = fullName?.components(separatedBy: " ")
            firstNameTextField.text = nameArray?.first
            lastNameTextField.text = nameArray?.last
            cameraButton.isHidden = false
            saveButton.isHidden = false
            cancelButton.isHidden = false
            firstUnderlineView.isHidden = false
            lastUnderlineView.isHidden = false
            firstNameTextField.isHidden = false
            lastNameTextField.isHidden = false
            menuButton.isHidden = true
            nameLabel.isHidden = true
        } else {
            firstUnderlineView.isHidden = true
            lastUnderlineView.isHidden = true
            firstNameTextField.isHidden = true
            lastNameTextField.isHidden = true
            cameraButton.isHidden = true
            saveButton.isHidden = true
            cancelButton.isHidden = true
            menuButton.isHidden = false
            nameLabel.isHidden = false
            nameLabel.text = currentUserName
        }
    }
    
    func saveTapped() {
        guard
            let firstName = firstNameTextField.text,
            let lastName = lastNameTextField.text
            else { return }
        nameLabel.text = "\(firstName) \(lastName)"
        self.currentUserName = nameLabel.text
//        let nameArray = fullName?.components(separatedBy: " ")
        
        if let imageData = profileImageView.image?.pngData(), let graphQLID = apolloController?.currentUserID, let accessToken = authController?.stateManager?.accessToken {
//            apolloController?.hostImage(imageData: imageData, completion: { result in
//                guard let urlString = try? result.get() else { return }
//                print(urlString)
//                self.apolloController?.updateUserInfo(urlString: urlString, firstName: firstName, lastName: lastName, graphQLID: graphQLID, accessToken: accessToken, completion: { result in
//                    guard let response = try? result.get() else { return }
//                    let updatedImageURL = response.profileImage
//                    let newFirstName = response.firstName
//                    let newLastName = response.lastName
//                    print("New Profile Image String: \(String(describing: updatedImageURL)), New First Name: \(String(describing: newFirstName)), New Last Name: \(String(describing: newLastName))")
//                })
//            })
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
    
    func fetchCreatedEvents(completion: @escaping () -> Void) {
        guard let accessToken = authController?.stateManager?.accessToken else {
            print("No access Token for retrieving users created events")
            return
        }
        guard let graphQLID = Apollo.shared.currentUserID else {
            print("No current graphQLID")
            return
        }
        Apollo.shared.getUserCreatedEvents(graphQLID: graphQLID, accessToken: accessToken, completion: { _ in
            
        })
    }
}

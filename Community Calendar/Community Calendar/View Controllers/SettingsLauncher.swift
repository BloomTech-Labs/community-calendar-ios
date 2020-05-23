//
//  SettingsLauncher.swift
//  Community Calendar
//
//  Created by Michael on 5/14/20.
//  Copyright © 2020 Mazjap Co. All rights reserved.
//

import UIKit

class SettingsLauncher: NSObject, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    let blackView = UIView()
    let editProfileView = UIView()
    let profileImageView = UIImageView()
    let imageBackgroundView = UIView()
    let firstNameTextField = UITextField()
    let lastNameTextField = UITextField()
    let firstUnderlineView = UIView()
    let lastUnderlineView = UIView()
    let saveButton = UIButton()
    let cancelButton = UIButton()
    
    let settingsCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = #colorLiteral(red: 0.1721869707, green: 0.1871494651, blue: 0.2290506661, alpha: 1)
        cv.layer.cornerRadius = 12
        cv.contentInset.top = 100
//        cv.contentInset.top = 25
        return cv
    }()
    
    var height: CGFloat = 0
    var y: CGFloat = 0
    let testLabel = UILabel()
    let logoutButton = UIButton()
    
    let cellID = "SettingCell"
    var profileImage: UIImage? {
        didSet {
            print("Profile Image Set")
        }
    }
    
    var firstName: String? {
        didSet {
            print("First Name Set")
        }
    }
    
    var lastName: String? {
        didSet {
            print("Last Name Set")
        }
    }
    
    override init() {
        super.init()
        
        settingsCollectionView.delegate = self
        settingsCollectionView.dataSource = self
        
        settingsCollectionView.register(SettingCollectionViewCell.self, forCellWithReuseIdentifier: cellID)
        saveButton.addGestureRecognizer(UIGestureRecognizer(target: self, action: #selector(self.saveButtonTapped)))
    }
    
    func showSettings() {
        let window = UIApplication.shared.windows.filter {$0.isKeyWindow}.first
        
        if let window = window {
            
            blackView.backgroundColor = UIColor(white: 0, alpha: 0.5)
            
            blackView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleDismiss)))
            
            
            window.addSubview(blackView)
            
            let height: CGFloat = window.frame.height / 3
            let y = window.frame.height - height
            self.height = height
            self.y = y
            
            let width: CGFloat = window.frame.width / 2.5
            let x = 0 - width
            
            
            settingsCollectionView.frame = CGRect(x: x, y: 0, width: width, height: window.frame.height)
            
//            settingsCollectionView.frame = CGRect(x: 0, y: window.frame.height, width: window.frame.width, height: height)
            window.addSubview(settingsCollectionView)
            
            //            window.addSubview(editProfileView)
            //            editViewConstraints()
            //            setupSubviews()
            
            blackView.frame = CGRect(x: 0, y: 0, width: window.frame.width, height: window.frame.height)
            blackView.alpha = 0
            
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                self.blackView.alpha = 1
                
                self.settingsCollectionView.frame = CGRect(x: -7, y: 0, width: width, height: window.frame.height)
                self.settingsCollectionView.settingsShadow()
//                self.settingsCollectionView.frame = CGRect(x: 0, y: y, width: self.settingsCollectionView.frame.width, height: self.settingsCollectionView.frame.height)
            }, completion: nil)
        }
    }
    
    @objc func handleDismiss() {
        
        UIView.animate(withDuration: 0.5, animations: {
            self.blackView.alpha = 0
            let window = UIApplication.shared.windows.filter {$0.isKeyWindow}.first
            
            if let window = window {
                
                let width = window.frame.width / 2.5
                
                self.settingsCollectionView.frame = CGRect(x: -width, y: 0, width: width, height: window.frame.height)
                
                
//                self.settingsCollectionView.frame = CGRect(x: 0, y: window.frame.height, width: self.settingsCollectionView.frame.width, height: self.settingsCollectionView.frame.height)
                
//                self.editProfileView.frame = CGRect(x: window.frame.width, y: window.frame.height - self.height, width: window.frame.width, height: self.height)
                
            }
        }) { _ in
            self.settingsCollectionView.removeFromSuperview()
            self.editProfileView.removeFromSuperview()
            self.saveButton.removeFromSuperview()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return SettingsOptions.allCases.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as? SettingCollectionViewCell else { return UICollectionViewCell() }
        
        let option = SettingsOptions(rawValue: indexPath.item)?.description
        cell.settingLabel.text = option
        
        switch indexPath.item {
        case 0:
            cell.settingsOptions = .editProfile
        case 1:
            cell.settingsOptions = .logout
        default:
            break
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.width, height: 50)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        0
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.item == 0 {
            NotificationCenter.default.post(.init(name: .editProfile))
            self.handleDismiss()
        } else if indexPath.item == 1 {
            NotificationCenter.default.post(.init(name: .handleLogout))
            self.handleDismiss()
        }
    }
    
    func createAttrText(with title: String, color: UIColor, fontName: String) -> NSAttributedString {
        guard let font = UIFont(name: fontName, size: 17) else { return NSAttributedString() }
        let attrString = NSAttributedString(string: title,
                                            attributes: [NSAttributedString.Key.foregroundColor: color, NSAttributedString.Key.font: font])
        return attrString
    }
    
    @objc func saveButtonTapped() {
        UIView.animate(withDuration: 0.5, animations: {
            self.blackView.alpha = 0
            let window = UIApplication.shared.windows.filter {$0.isKeyWindow}.first
            print("Save Button Tapped!")
            if let window = window {
                
                self.editProfileView.frame = CGRect(x: window.frame.width, y: window.frame.height - self.height, width: self.editProfileView.frame.width, height: self.editProfileView.frame.height)
            }
        }) { _ in
            self.editProfileView.removeFromSuperview()
            self.saveButton.removeFromSuperview()
        }
    }
    
    func presentEditView(completion: @escaping () -> Void) {
        settingsCollectionView.removeFromSuperview()
        self.profileImageView.image = self.profileImage
        self.firstNameTextField.text = self.firstName
        self.lastNameTextField.text = self.lastName
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            self.editProfileView.frame = CGRect(x: 0, y: self.y, width: self.editProfileView.frame.width, height: self.editProfileView.frame.height)
        }) { (true) in
            self.settingsCollectionView.removeFromSuperview()
        }
    }
    
    func editViewConstraints() {
        
        let window = UIApplication.shared.windows.filter {$0.isKeyWindow}.first
        
        if let window = window {
            let height = window.frame.height / 3
            
            editProfileView.frame = CGRect(x: window.frame.width, y: window.frame.height - height, width: window.frame.width, height: height)
            
            window.addSubview(editProfileView)
            editProfileView.addSubview(imageBackgroundView)
            editProfileView.addSubview(firstNameTextField)
            editProfileView.addSubview(lastNameTextField)
            editProfileView.addSubview(firstUnderlineView)
            editProfileView.addSubview(lastUnderlineView)
            editProfileView.addSubview(saveButton)
            editProfileView.addSubview(cancelButton)
            
            let imageheight = editProfileView.frame.height / 2
            
            imageBackgroundView.anchor(top: editProfileView.topAnchor, leading: nil, trailing: nil, bottom: nil, centerX: editProfileView.centerXAnchor, centerY: nil, padding: .init(top: 20, left: 0, bottom: 0, right: 0), size: .init(width: imageheight, height: imageheight))
            
            imageBackgroundView.addSubview(profileImageView)
            
            profileImageView.anchor(top: imageBackgroundView.topAnchor, leading: imageBackgroundView.leadingAnchor, trailing: imageBackgroundView.trailingAnchor, bottom: imageBackgroundView.bottomAnchor, centerX: nil, centerY: nil, padding: .init(top: 2, left: 2, bottom: -2, right: -2), size: .zero)
            
            firstNameTextField.anchor(top: imageBackgroundView.bottomAnchor, leading: editProfileView.leadingAnchor, trailing: editProfileView.centerXAnchor, bottom: nil, centerX: nil, centerY: nil, padding: .init(top: 8, left: 20, bottom: 0, right: -16), size: .zero)
            
            lastNameTextField.anchor(top: imageBackgroundView.bottomAnchor, leading: editProfileView.centerXAnchor, trailing: editProfileView.trailingAnchor, bottom: nil, centerX: nil, centerY: nil, padding: .init(top: 8, left: 16, bottom: 0, right: -20), size: .zero)
            
            firstUnderlineView.anchor(top: firstNameTextField.bottomAnchor, leading: firstNameTextField.leadingAnchor, trailing: firstNameTextField.trailingAnchor, bottom: firstNameTextField.bottomAnchor, centerX: nil, centerY: nil, padding: .init(top: -1, left: -2, bottom: 1, right: 2), size: .zero)
            
            lastUnderlineView.anchor(top: lastNameTextField.bottomAnchor, leading: lastNameTextField.leadingAnchor, trailing: lastNameTextField.trailingAnchor, bottom: lastNameTextField.bottomAnchor, centerX: nil, centerY: nil, padding: .init(top: -1, left: -2, bottom: 1, right: 2), size: .zero)
            
            saveButton.frame = CGRect(x: editProfileView.center.x - 50, y: editProfileView.frame.height - 80, width: 40, height: 100)
            
            saveButton.anchor(top: firstNameTextField.bottomAnchor, leading: nil, trailing: nil, bottom: nil, centerX: editProfileView.centerXAnchor, centerY: nil, padding: .init(top: 20, left: 0, bottom: 0, right: 0), size: .init(width: 100, height: 40))
            
            cancelButton.anchor(top: editProfileView.topAnchor, leading: editProfileView.leadingAnchor, trailing: nil, bottom: nil, centerX: nil, centerY: nil, padding: .init(top: 20, left: 20, bottom: 0, right: 0), size: .init(width: 15, height: 15))
            
            saveButton.addGestureRecognizer(UIGestureRecognizer(target: self, action: #selector(self.saveButtonTapped)))
            profileImageView.layer.cornerRadius = imageheight / 2
            imageBackgroundView.layer.cornerRadius = imageheight / 2
        }
    }
    
    func setupSubviews() {
        editProfileView.backgroundColor = #colorLiteral(red: 0.1721869707, green: 0.1871494651, blue: 0.2290506661, alpha: 1)
        editProfileView.layer.cornerRadius = 12
        imageBackgroundView.backgroundColor = #colorLiteral(red: 0.7410163879, green: 0.4183317125, blue: 0.4147843719, alpha: 1)
        
        firstUnderlineView.backgroundColor = #colorLiteral(red: 0.7410163879, green: 0.4183317125, blue: 0.4147843719, alpha: 1)
        lastUnderlineView.backgroundColor = #colorLiteral(red: 0.7410163879, green: 0.4183317125, blue: 0.4147843719, alpha: 1)
        lastNameTextField.borderStyle = .none
        firstNameTextField.borderStyle = .none
        lastNameTextField.backgroundColor = #colorLiteral(red: 0.1721869707, green: 0.1871494651, blue: 0.2290506661, alpha: 1)
        firstNameTextField.backgroundColor = #colorLiteral(red: 0.1721869707, green: 0.1871494651, blue: 0.2290506661, alpha: 1)
        firstUnderlineView.layer.cornerRadius = 0.5
        lastUnderlineView.layer.cornerRadius = 0.5
        
        self.saveButton.addGestureRecognizer(UIGestureRecognizer(target: self, action: #selector(self.saveButtonTapped)))
        self.saveButton.setTitle("Save", for: .normal)
        self.saveButton.titleLabel?.font = UIFont(name: PoppinsFont.semiBold.rawValue, size: 17)
        self.saveButton.backgroundColor = #colorLiteral(red: 0.7410163879, green: 0.4183317125, blue: 0.4147843719, alpha: 1)
        self.saveButton.setTitleColor(UIColor.white, for: .normal)
        self.saveButton.layer.borderWidth = 2.0
        self.saveButton.layer.borderColor = #colorLiteral(red: 0.7410163879, green: 0.4183317125, blue: 0.4147843719, alpha: 1)
        self.saveButton.layer.cornerRadius = 12
        self.saveButton.isEnabled = true
        firstNameTextField.textAlignment = .center
        lastNameTextField.textAlignment = .center
        lastNameTextField.textColor = .white
        firstNameTextField.textColor = .white
        firstNameTextField.layer.cornerRadius = 12
        lastNameTextField.layer.cornerRadius = 12
        profileImageView.contentMode = .scaleAspectFill
        profileImageView.layer.masksToBounds = true
    }
    
    func configSaveButton(completion: @escaping () -> Void) {
        let window = UIApplication.shared.windows.filter {$0.isKeyWindow}.first
        
        if let window = window {
            let x = window.frame.width / 2
            let saveButtonY = window.frame.height - 80
            self.saveButton.frame = CGRect(x: x - 50, y: saveButtonY, width: 100, height: 40)
            window.addSubview(saveButton)
            self.saveButton.addGestureRecognizer(UIGestureRecognizer(target: self, action: #selector(self.saveButtonTapped)))
            self.saveButton.setTitle("Save", for: .normal)
            self.saveButton.titleLabel?.font = UIFont(name: PoppinsFont.semiBold.rawValue, size: 15)
            self.saveButton.backgroundColor = #colorLiteral(red: 0.7410163879, green: 0.4183317125, blue: 0.4147843719, alpha: 1)
            self.saveButton.setTitleColor(UIColor.white, for: .normal)
            self.saveButton.layer.borderWidth = 2.0
            self.saveButton.layer.borderColor = #colorLiteral(red: 0.7410163879, green: 0.4183317125, blue: 0.4147843719, alpha: 1)
            self.saveButton.layer.cornerRadius = 12
            print("Save Button's Frame: \(self.saveButton.frame)")
            completion()
        }
    }
    
    
}

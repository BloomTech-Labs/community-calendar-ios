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
    var authController: AuthController?
    
    let settingsView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 12
        view.backgroundColor = #colorLiteral(red: 0.1721869707, green: 0.1871494651, blue: 0.2290506661, alpha: 1)
        return view
    }()
    
    let settingsCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = #colorLiteral(red: 0.1721869707, green: 0.1871494651, blue: 0.2290506661, alpha: 1)
        cv.layer.cornerRadius = 12
        cv.contentInset.top = 20
        return cv
    }()
    
    let testLabel = UILabel()
    let logoutButton = UIButton()
    
    let cellID = "SettingCell"
    
    override init() {
        super.init()
        
        
        settingsCollectionView.delegate = self
        settingsCollectionView.dataSource = self
        
        settingsCollectionView.register(SettingCollectionViewCell.self, forCellWithReuseIdentifier: cellID)
        
    }
    
    func showSettings() {
        
        let window = UIApplication.shared.windows.filter {$0.isKeyWindow}.first
        
        if let window = window {
            
            blackView.backgroundColor = UIColor(white: 0, alpha: 0.5)
            
            blackView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleDismiss)))
    
            window.addSubview(blackView)
            
            
            let height: CGFloat = window.frame.height / 3

            let y = window.frame.height - height
            settingsView.frame = CGRect(x: 0, y: window.frame.height, width: window.frame.width, height: height)

            settingsCollectionView.frame = CGRect(x: 0, y: window.frame.height, width: window.frame.width, height: height)
            window.addSubview(settingsCollectionView)
            
            blackView.frame = CGRect(x: 0, y: 0, width: window.frame.width, height: window.frame.height)
            blackView.alpha = 0
            
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                self.blackView.alpha = 1
                
                
                self.settingsCollectionView.frame = CGRect(x: 0, y: y, width: self.settingsCollectionView.frame.width, height: self.settingsCollectionView.frame.height)
            }, completion: nil)
        }
    }
    
    @objc func handleDismiss() {
        UIView.animate(withDuration: 0.5) {
            self.blackView.alpha = 0
            let window = UIApplication.shared.windows.filter {$0.isKeyWindow}.first
            
            if let window = window {
                
                self.settingsCollectionView.frame = CGRect(x: 0, y: window.frame.height, width: self.settingsCollectionView.frame.width, height: self.settingsCollectionView.frame.height)
            }
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
            cell.settingsOptions = .logout
        case 1:
            cell.settingsOptions = .editProfile
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
            NotificationCenter.default.post(.init(name: .handleLogout))
            self.handleDismiss()
        } else if indexPath.item == 1 {
            
        }
    }
    
    func createAttrText(with title: String, color: UIColor, fontName: String) -> NSAttributedString {
        guard let font = UIFont(name: fontName, size: 17) else { return NSAttributedString() }
        let attrString = NSAttributedString(string: title,
                                            attributes: [NSAttributedString.Key.foregroundColor: color, NSAttributedString.Key.font: font])
        return attrString
    }
    
//    func logoutConfirmation(title: String, message: String, completion: @escaping () -> Void) {
//        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
//        let logoutAction = UIAlertAction(title: "Logout", style: .destructive)
//
//
//        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
//        alertController.addAction(cancelAction)
//        alertController.addAction(logoutAction)
//        self.present(alertController, animated: true, completion: completion)
//    }
}

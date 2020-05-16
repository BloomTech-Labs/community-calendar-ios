//
//  SettingCollectionViewCell.swift
//  Community Calendar
//
//  Created by Michael on 5/14/20.
//  Copyright © 2020 Mazjap Co. All rights reserved.
//

import UIKit

class SettingCollectionViewCell: UICollectionViewCell {
    
    var settingsOptions: SettingsOptions? {
        didSet {
            updateView()
        }
    }
    
    let imageView: UIImageView = {
        let imageview = UIImageView()
        imageview.contentMode = .scaleAspectFill
        return imageview
    }()
    
    let settingLabel = UILabel()
    let imageBackgroundView = UIView()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
        setupSubViews()
        
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
    }
    
    func updateView() {
        if settingsOptions == .logout {
            imageView.image = UIImage(named: "icon logout")
        } else if settingsOptions == .editProfile {
            imageView.image = UIImage(named: "edit profile")
        }
    }
    
    func setupSubViews() {
        let stackView = UIStackView(arrangedSubviews: [imageView, settingLabel])
        stackView.alignment = .center
        stackView.axis = .horizontal
        contentView.addSubview(stackView)

        stackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
        settingLabel.text = "  Logout"
        settingLabel.font = UIFont(name: PoppinsFont.semiBold.rawValue, size: 17)
        settingLabel.textColor = .white
    }
}

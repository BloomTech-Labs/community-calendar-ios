//
//  EditProfileView.swift
//  Community Calendar
//
//  Created by Michael on 5/16/20.
//  Copyright © 2020 Mazjap Co. All rights reserved.
//

import UIKit

class EditProfileView: UIView {

    let editProfileView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 12
        view.backgroundColor = #colorLiteral(red: 0.1721869707, green: 0.1871494651, blue: 0.2290506661, alpha: 1)
        return view
    }()
    
    let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.backgroundColor = .blue
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
        setupSubViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupSubViews() {
        let window = UIApplication.shared.windows.filter { $0.isKeyWindow }.first
        
        if let window = window {
            let height: CGFloat = window.frame.height / 3
            let y = window.frame.height - height
            
            window.addSubview(editProfileView)
            editProfileView.frame = CGRect(x: 0, y: y, width: window.frame.width, height: height)
            
            editProfileView.addSubview(profileImageView)
            profileImageView.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                profileImageView.centerXAnchor.constraint(equalTo: editProfileView.centerXAnchor),
                profileImageView.centerYAnchor.constraint(equalTo: editProfileView.centerYAnchor),
                profileImageView.heightAnchor.constraint(equalToConstant: editProfileView.frame.height / 2),
                profileImageView.widthAnchor.constraint(equalToConstant: editProfileView.frame.height / 2)
            ])
            
            profileImageView.backgroundColor = .blue
            profileImageView.layer.cornerRadius = profileImageView.frame.height / 2
        }
    }
}

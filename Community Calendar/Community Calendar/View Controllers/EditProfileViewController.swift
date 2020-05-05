//
//  EditProfileViewController.swift
//  Community Calendar
//
//  Created by Austin Potts on 5/3/20.
//  Copyright © 2020 Mazjap Co. All rights reserved.
//

import UIKit

class EditProfileViewController: UIViewController {

    
    @IBOutlet var saveButton: UIButton!
    @IBOutlet var userImage: UIImageView!
    @IBOutlet var userName: UILabel!
    @IBOutlet var userBlackOpacityView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Green Save Button
        // This Button Will need to be hidden upon initial viewing
        saveButton.layer.cornerRadius = 15
        
        // Users Image
        userImage.layer.borderWidth = 1
        userImage.layer.borderColor = UIColor.black.cgColor
        userImage.contentMode = .scaleAspectFill
        userImage.layer.cornerRadius = userImage.frame.height / 2
        userImage.layer.masksToBounds = false
        userImage.clipsToBounds = true
        
        // Black Opacity View That Overlays User Image
        userBlackOpacityView.contentMode = .scaleAspectFill
        userBlackOpacityView.layer.cornerRadius = userImage.frame.height / 2
        userBlackOpacityView.layer.masksToBounds = false
        userBlackOpacityView.clipsToBounds = true
        
        
        
    }
    

  
    //MARK: - Save the entire Edit on both User Image & Name
    @IBAction func saveEditButtonTapped(_ sender: Any) {
    }
    
    //MARK: - Red Edit Button To Change Users Image (Link to Photo Library for photo access)
    @IBAction func editUserImageButtonTapped(_ sender: Any) {
    }
    
    
    //MARK: - Red edit Button To Change Users Name
    @IBAction func editUserNameButtonTapped(_ sender: Any) {
    }
    
}

//
//  EditProfileViewController.swift
//  Community Calendar
//
//  Created by Austin Potts on 5/3/20.
//  Copyright © 2020 Mazjap Co. All rights reserved.
//

import UIKit
import OktaOidc



class EditProfileViewController: UIViewController {

    //MARK: - TODO: Pass the stateManager to access the Users Token

    
    //MARK: - TODO: Pass the EventController to access the Mutations
    
    
    //MARK: - Outlets
    @IBOutlet var saveButton: UIButton!
    @IBOutlet var editNameButton: UIButton!
    @IBOutlet var editImageButton: UIButton!
    @IBOutlet var userImage: UIImageView!
    @IBOutlet var userName: UILabel!
    @IBOutlet var userBlackOpacityView: UIView!
    @IBOutlet var editNameTextField: UITextField!
    
    //MARK: - Properties
    var eventController: EventController?
    var stateManager: OktaOidcStateManager?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Green Save Button
        // This Button Will need to be hidden upon initial viewing
        saveButton.layer.cornerRadius = 15
        
        // Users Image
        userImage.layer.borderWidth = 1
        userImage.layer.borderColor = UIColor.white.cgColor
        userImage.contentMode = .scaleAspectFill
        userImage.layer.cornerRadius = userImage.frame.height / 2
        userImage.layer.masksToBounds = false
        userImage.clipsToBounds = true
        
        // Black Opacity View That Overlays User Image
        userBlackOpacityView.contentMode = .scaleAspectFill
        userBlackOpacityView.layer.cornerRadius = userImage.frame.height / 2
        userBlackOpacityView.layer.masksToBounds = false
        userBlackOpacityView.clipsToBounds = true
        
        hideSaveButton()
        hideTextFields()
        
    }
    
    // Hide The Save Button On Launch Until Button is Tapped
    func hideSaveButton() {
        saveButton.isHidden = true
    }
    
    // Hide the Text Fields That The User Will Use To Edit Values
    func hideTextFields() {
        editNameTextField.isHidden = true
    }

  
    //MARK: - Save the entire Edit on both User Image & Name
    @IBAction func saveEditButtonTapped(_ sender: Any) {
        
//        guard let userImage = userImage,
//            let userName = userName, else {return}
//
//        eventController?.updateProfilePic(url: <#T##String#>, graphQLID: <#T##String#>, completion: <#T##(Result<AddProfilePicMutation.Data.UpdateUser, Error>) -> Void#>)
//
        
        dismiss(animated: true, completion: nil)
    }
    
    //MARK: - Red Edit Button To Change Users Image (Link to Photo Library for photo access)
    @IBAction func editUserImageButtonTapped(_ sender: Any) {
        
        // Image Picker Set Up
        saveButton.isHidden.toggle()
        let picker = UIImagePickerController()
        picker.allowsEditing = false
       // picker.delegate = self
        picker.sourceType = .photoLibrary
        present(picker, animated: true)
    }
    
    
    //MARK: - Red edit Button To Change Users Name
    @IBAction func editUserNameButtonTapped(_ sender: Any) {
        
        saveButton.isHidden.toggle()
        editNameTextField.isHidden.toggle()
        
        guard let text = editNameTextField else {return}
        
    }
    
}



//MARK: - Image Picker Extensions
extension EditProfileViewController {
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            picker.dismiss(animated: true)
            guard let image = info[.originalImage] as? UIImage else {
                return
            }
            
            UIGraphicsBeginImageContextWithOptions(CGSize(width: 227, height: 227), true, 2.0)
            image.draw(in: CGRect(x: 0, y: 0, width: 414, height: 326))
            let newImage = UIGraphicsGetImageFromCurrentImageContext()!
            UIGraphicsEndImageContext()
            
            let attrs = [kCVPixelBufferCGImageCompatibilityKey: kCFBooleanTrue, kCVPixelBufferCGBitmapContextCompatibilityKey: kCFBooleanTrue] as CFDictionary
            var pixelBuffer : CVPixelBuffer?
            let status = CVPixelBufferCreate(kCFAllocatorDefault, Int(newImage.size.width), Int(newImage.size.height), kCVPixelFormatType_32ARGB, attrs, &pixelBuffer)
            guard (status == kCVReturnSuccess) else {
                return
            }
            
            CVPixelBufferLockBaseAddress(pixelBuffer!, CVPixelBufferLockFlags(rawValue: 0))
            let pixelData = CVPixelBufferGetBaseAddress(pixelBuffer!)
            
            let rgbColorSpace = CGColorSpaceCreateDeviceRGB()
            let context = CGContext(data: pixelData, width: Int(newImage.size.width), height: Int(newImage.size.height), bitsPerComponent: 8, bytesPerRow: CVPixelBufferGetBytesPerRow(pixelBuffer!), space: rgbColorSpace, bitmapInfo: CGImageAlphaInfo.noneSkipFirst.rawValue) //3
            
            context?.translateBy(x: 0, y: newImage.size.height)
            context?.scaleBy(x: 1.0, y: -1.0)
            
            UIGraphicsPushContext(context!)
            newImage.draw(in: CGRect(x: 0, y: 0, width: newImage.size.width, height: newImage.size.height))
            UIGraphicsPopContext()
            CVPixelBufferUnlockBaseAddress(pixelBuffer!, CVPixelBufferLockFlags(rawValue: 0))
            userImage.image = newImage
    
             
        }
    
    
    
    
}

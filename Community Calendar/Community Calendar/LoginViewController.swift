//
//  LoginViewController.swift
//  Community Calendar
//
//  Created by Hayden Hastings on 12/16/19.
//  Copyright © 2019 Mazjap Co. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    // MARK: - IBOutlets
    @IBOutlet weak var loginView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        signUpWithGoogle()
        or()
        lines()

        let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
           backgroundImage.image = UIImage(named: "BG")
        backgroundImage.contentMode = UIView.ContentMode.scaleAspectFill
           self.view.insertSubview(backgroundImage, at: 0)
    
        loginView.layer.cornerRadius = 12
    }
    
//    func signUpWithGoogle() {
//        let view = UIButton()
//        view.frame = CGRect(x: 0, y: 0, width: 145, height: 21)
//        view.backgroundColor = .white
//
//        view.setTitle("Sign up with Google ", for: .normal)
//        view.setTitleColor(UIColor(red: 112/255, green: 112/255, blue: 112/255, alpha: 1), for: .normal)
//        view.layer.cornerRadius = 6
//        view.titleLabel?.font = UIFont(name: "Poppins-Regular", size: 14)
//
//        // Line height: 21 pt
//        // (identical to box height)
//
//
//        let parent = self.loginView!
//        parent.addSubview(view)
//        view.translatesAutoresizingMaskIntoConstraints = false
//        view.widthAnchor.constraint(equalToConstant: 145).isActive = true
//        view.heightAnchor.constraint(equalToConstant: 21).isActive = true
//        view.leadingAnchor.constraint(equalTo: parent.leadingAnchor, constant: 7).isActive = true
//        view.topAnchor.constraint(equalTo: parent.topAnchor, constant: 50).isActive = true
//    }
    
    func lines() {
        let view = UILabel()
        view.frame = CGRect(x: 0, y: 0, width: 141.3, height: 1)
        view.backgroundColor = .white

        view.layer.backgroundColor = UIColor.black.cgColor
        view.layer.cornerRadius = 6

        let parent = self.loginView!
        parent.addSubview(view)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.widthAnchor.constraint(equalToConstant: 141.3).isActive = true
        view.heightAnchor.constraint(equalToConstant: 1).isActive = true
        view.leadingAnchor.constraint(equalTo: parent.leadingAnchor, constant: 28).isActive = true
        view.topAnchor.constraint(equalTo: parent.topAnchor, constant: 119).isActive = true
    }
    
    func or() {
        let view = UILabel()
        view.frame = CGRect(x: 0, y: 0, width: 15, height: 21)
        view.backgroundColor = .white

        view.text = "or"
        view.textColor = UIColor(red: 0.112, green: 0.112, blue: 0.112, alpha: 1)
        view.font = UIFont(name: "Poppins-Regular", size: 14)

        // Line height: 21 pt
        // (identical to box height)


        let parent = self.loginView!
        parent.addSubview(view)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.widthAnchor.constraint(equalToConstant: 17).isActive = true
        view.heightAnchor.constraint(equalToConstant: 21).isActive = true
        view.leadingAnchor.constraint(equalTo: parent.leadingAnchor, constant: 170).isActive = true
        view.topAnchor.constraint(equalTo: parent.topAnchor, constant: 54).isActive = true
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

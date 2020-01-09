//
//  LoginViewController.swift
//  Community Calendar
//
//  Created by Hayden Hastings on 12/16/19.
//  Copyright © 2019 Mazjap Co. All rights reserved.
//

import UIKit
import Auth0

class LoginViewController: UIViewController {
    
    var onAuth: ((Result<Credentials>) -> ())!

    // MARK: - IBOutlets
    @IBOutlet weak var loginView: UIView!
    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        signUpButton.layer.cornerRadius = 12
        signUpButton.layer.maskedCorners = [.layerMinXMinYCorner]
        loginView.addSubview(signUpButton)
        firstNameBorder()
        lastNameBorder()
        emailBorder()
        passwordBorder()
        
        self.onAuth = { [weak self] in
            switch $0 {
            case .failure(let cause):
                DispatchQueue.main.async {
                    let alert = UIAlertController(title: "Auth Failed!", message: "\(cause)", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
                    self?.present(alert, animated: true, completion: nil)
                }
            case .success(let credentials):
                DispatchQueue.main.async {
                    let token = credentials.accessToken ?? credentials.idToken
                    let alert = UIAlertController(title: "Auth Success!", message: "Authorized and got a token \(String(describing: token))", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
                    self?.present(alert, animated: true, completion: nil)
                }
            }
            print($0)
        }

        let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
           backgroundImage.image = UIImage(named: "BG")
        backgroundImage.contentMode = UIView.ContentMode.scaleAspectFill
           self.view.insertSubview(backgroundImage, at: 0)
    
        loginView.layer.cornerRadius = 12
    }
    
    // MARK: - TextField Border Colors
    
    func firstNameBorder() {
        let bottomLine = CALayer()
        bottomLine.frame = CGRect(x: 0.0, y: firstNameTextField.frame.height - 1, width: firstNameTextField.frame.width, height: 1)
        bottomLine.backgroundColor = UIColor(red: 0.129, green: 0.141, blue: 0.173, alpha: 1).cgColor
        firstNameTextField.borderStyle = .none
        firstNameTextField.layer.addSublayer(bottomLine)
    }
    
    func lastNameBorder() {
        let bottomLine = CALayer()
        bottomLine.frame = CGRect(x: 0.0, y: lastNameTextField.frame.height - 1, width: lastNameTextField.frame.width, height: 1)
        bottomLine.backgroundColor = UIColor(red: 0.129, green: 0.141, blue: 0.173, alpha: 1).cgColor
        lastNameTextField.borderStyle = .none
        lastNameTextField.layer.addSublayer(bottomLine)
    }
    
    func emailBorder() {
        let bottomLine = CALayer()
        bottomLine.frame = CGRect(x: 0.0, y: emailTextField.frame.height - 1, width: emailTextField.frame.width, height: 1)
        bottomLine.backgroundColor = UIColor(red: 0.129, green: 0.141, blue: 0.173, alpha: 1).cgColor
        emailTextField.borderStyle = .none
        emailTextField.layer.addSublayer(bottomLine)
    }
    
    func passwordBorder() {
        let bottomLine = CALayer()
        bottomLine.frame = CGRect(x: 0.0, y: passwordTextField.frame.height - 1, width: passwordTextField.frame.width, height: 1)
        bottomLine.backgroundColor = UIColor(red: 0.129, green: 0.141, blue: 0.173, alpha: 1).cgColor
        passwordTextField.borderStyle = .none
        passwordTextField.layer.addSublayer(bottomLine)
    }
    
    // MARK: - IBAction
    
    @IBAction func signInWithGoogle(_ sender: Any) {
//        Auth0.webAuth()
//        .audience("https://communitycalendar-staging.auth0.com/userinfo")
//        .start { result in
//            switch result {
//            case .success(let credentials):
//                print("Obtained credentials: \(credentials)")
//            case .failure(let error):
//                print("Failed with \(error)")
//            }
//        }
        
        Auth0.webAuth()
        .logging(enabled: true)
        .connection("google-oauth2")
        .responseType([.token])
        .start(onAuth)
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

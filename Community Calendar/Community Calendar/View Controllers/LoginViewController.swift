//
//  LoginViewController.swift
//  Community Calendar
//
//  Created by Hayden Hastings on 12/16/19.
//  Copyright © 2019 Lambda School All rights reserved.
//
//  Dev Notes:
//  If you wanted to keep the user logged in even after closing the app,
//  there are some great docs on https://github.com/auth0/JWTDecode.swift.
//  (let jwt = try decode(jwt: token); jwt.expiresAt)
//  When opening the app, you can decode the token and see if it has already
//  expired, if not, refresh the token, if it has expired, log the user in again
//  Store the token in apple's keychain

import UIKit
import OktaOidc

class LoginViewController: UIViewController {
    
    // MARK: - IBOutlets
    @IBOutlet weak var LoginButton: UIButton!
    @IBOutlet weak var logOutButton: UIButton!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    
    // MARK: - Lifecycle Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)

    }
    
    // MARK: - Functions
    private func logoutAlertController() {
        let alert = UIAlertController(title: "Success", message: "You have successfully logged out", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Ok", style: .default) { _ in
            DispatchQueue.main.async {
                self.tabBarController?.selectedIndex = 0
            }
        })
        
        DispatchQueue.main.async{
            self.presentedViewController?.dismiss(animated: false) {
                OperationQueue.main.addOperation {
                    self.present(alert, animated: true)
                }
            }
        }
    }
    

    
    private func updateViews() {
//        guard let name = response["given_name"] else { return }
    }
    
    // MARK: - IBAction
    @IBAction func loginOrSignUpButtonPressed(_ sender: Any) {

    }
    
    @IBAction func logoutButtonPressed(_ sender: Any) {
        

    }
}

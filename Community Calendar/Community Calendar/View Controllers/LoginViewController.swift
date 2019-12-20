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
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        or()
        lines()
        signUpButton.layer.cornerRadius = 12
        signUpButton.layer.maskedCorners = [.layerMinXMinYCorner]
        loginView.addSubview(signUpButton)
        
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
    
    // MARK: - IBAction
    
    @IBAction func signInWithGoogle(_ sender: Any) {
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

//
//  AuthController.swift
//  Community Calendar
//
//  Created by Michael on 5/4/20.
//  Copyright © 2020 Mazjap Co. All rights reserved.
//

import Foundation
import OktaOidc

class AuthController {
    
    var oktaOidc: OktaOidc?
    var stateManager: OktaOidcStateManager?
    
    func setupOktaOidc() {
        do {
            self.oktaOidc = try OktaOidc()
        } catch {
            print("Error creating OktaOidc Object.")
        }
        
        if let oktaOidc = self.oktaOidc, let accessToken = OktaOidcStateManager.readFromSecureStorage(for: oktaOidc.configuration)?.accessToken {
            print("This is the access token: \(accessToken)")
            self.stateManager = OktaOidcStateManager.readFromSecureStorage(for: oktaOidc.configuration)
        }
    }
    
    func signIn(viewController: UIViewController, completion: @escaping () -> Void) {
        oktaOidc?.signInWithBrowser(from: viewController, callback: { [weak self] stateManager, error in
            if let error = error {
                print("Error signing in: \(error)")
                completion()
                return
            }
            if let stateManager = stateManager {
                self?.stateManager?.clear()
                stateManager.writeToSecureStorage()
                self?.stateManager = stateManager
                self?.stateManager = OktaOidcStateManager.readFromSecureStorage(for: (self?.oktaOidc!.configuration)!)
                completion()
            }
        })
    }
    
    func getUser() {
        self.stateManager?.getUser({ [weak self] response, error in
            guard let response = response else {
                print("Returned out of guard let of get user response.")
                return
            }
            print(response)
            let name = response["given_name"]
            let username = response["preferred_username"]
            let timezone = response["zoneinfo"]
            print("Current users Name: \(String(describing: name)), Current users username: \(String(describing: username)), Current users timezone: \(String(describing: timezone))")
            print("Access Token: \(String(describing: self?.stateManager?.accessToken))")
            print("ID Token: \(String(describing: self?.stateManager?.idToken))")
            print("Refresh Token: \(String(describing: self?.stateManager?.refreshToken))")
        })
    }
}

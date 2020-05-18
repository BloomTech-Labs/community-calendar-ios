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
    var accessToken: String?
    var oktaID: String?
    
    func setupOktaOidc(completion: @escaping () -> Void) {
        do {
            self.oktaOidc = try OktaOidc()
        } catch {
            print("Error creating OktaOidc Object.")
        }
        
        if let oktaOidc = self.oktaOidc, let accessToken = OktaOidcStateManager.readFromSecureStorage(for: oktaOidc.configuration)?.accessToken {
//            print("This is the access token: \(accessToken)")
            self.accessToken = accessToken
            self.stateManager = OktaOidcStateManager.readFromSecureStorage(for: oktaOidc.configuration)
        }
    }
    
    func signIn(viewController: UIViewController, completion: @escaping (Swift.Result<OktaOidcStateManager, Error>) -> Void) {
        oktaOidc?.signInWithBrowser(from: viewController, callback: { [weak self] stateManager, error in
            if let error = error {
                print("Error signing in: \(error)")
                completion(.failure(error))
                return
            }
            if let stateManager = stateManager {
                self?.stateManager?.clear()
                stateManager.writeToSecureStorage()
                self?.stateManager = stateManager
                self?.stateManager = OktaOidcStateManager.readFromSecureStorage(for: (self?.oktaOidc!.configuration)!)
                completion(.success(stateManager))
            }
        })
    }
    
    func validateAccessToken(accessToken: String, completion: @escaping (Swift.Result<Bool, Error>) -> Void) {
        stateManager?.introspect(token: accessToken, callback: { payload, error in
            if let error = error {
                print("Error validating users access token: \(error)")
                completion(.failure(error))
                return
            }
            guard let isValid = payload?["active"] as? Bool else {
                print("Error validating access token returned out of guard let: \(String(describing: error))")
                completion(.failure(error!))
                return
            }
//            print("Token is valid: \(isValid)")
            completion(.success(isValid))
        })
    }
    
    func refreshAccessToken(completion: @escaping (Swift.Result<OktaOidcStateManager, Error>) -> Void) {
        stateManager?.renew(callback: { [weak self] stateManager, error in
            if let error = error {
                print("Error refreshing access token: \(error)")
                completion(.failure(error))
                return
            }
            if let stateManager = stateManager {
                stateManager.writeToSecureStorage()
                self?.stateManager = stateManager
                self?.stateManager = OktaOidcStateManager.readFromSecureStorage(for: (self?.oktaOidc!.configuration)!)
                completion(.success(stateManager))
            }
        })
    }
    
    func getUser(completion: @escaping (Swift.Result<[String], Error>) -> Void) {
        self.stateManager?.getUser({ [weak self] response, error in
            if let error = error {
                print("Error retrieving user info: \(error)")
                completion(.failure(error))
            }
            if let response = response {
                if let oktaID = response["sub"] as? String, let username = response["preferred_username"] as? String {
                    print("Okta ID: \(String(describing: oktaID))")
                    self?.oktaID = oktaID
                    let userInfo: [String] = [oktaID, username]
                    let name = response["given_name"]
                    let username = response["preferred_username"]
                    let timezone = response["zoneinfo"]
//                    print("Current users Name: \(String(describing: name)), Current users username: \(String(describing: username)), Current users timezone: \(String(describing: timezone))")
//                    print("Access Token: \(String(describing: self?.stateManager?.accessToken))")
//                    print("ID Token: \(String(describing: self?.stateManager?.idToken))")
//                    print("Refresh Token: \(String(describing: self?.stateManager?.refreshToken))")
                    completion(.success(userInfo))
                }
            }
        })
    }
    
    func signOut(viewController: UIViewController, completion: @escaping () -> Void) {
        guard let stateManager = stateManager, let oktaOidc = oktaOidc else { return }
        let options: OktaSignOutOptions = [.revokeAccessToken, .revokeRefreshToken, .removeTokensFromStorage]
        oktaOidc.signOut(with: options, authStateManager: stateManager, from: viewController, progressHandler: { currentOption in
            if currentOption.contains(.revokeAccessToken) {
                print("Revoking access token: \(currentOption)")
            } else if currentOption.contains(.revokeRefreshToken) {
                print("Revoking refresh token: \(currentOption)")
            } else if currentOption.contains(.removeTokensFromStorage) {
                print("Removing tokens from storage: \(currentOption)")
            } else if currentOption.contains(.signOutFromOkta) {
                print("Signing out: \(currentOption)")
            }
        }) { success, failedOptions in
            if success {
                print("Successfully signed out!")
                completion()
            } else {
                print("Unable to perform all sign out options. Failed sign out options: \(failedOptions)")
                completion()
            }
        }
    }
}

//
//  HomeNavigationController.swift
//  Community Calendar
//
//  Created by Jordan Christensen on 2/5/20.
//  Copyright © 2020 Lambda School All rights reserved.
//

import UIKit
import OktaOidc

class EventNavController: UINavigationController, ControllerDelegate {
    var authController: AuthController? {
        didSet {
            passController()
        }
    }
    
    var apolloController: ApolloController? {
        didSet {
            passController()
        }
    }
    
    var controller: Controller? {
        didSet {
            passController()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        passController()
    }
    
    func passController() {
        guard
            let controller = controller,
            let apolloController = apolloController,
            let authController = authController
            else { return }
        for viewController in self.viewControllers {
            if var VC = viewController as? ControllerDelegate {
                VC.controller = controller
                VC.apolloController = apolloController
                VC.authController = authController
            }
        }
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

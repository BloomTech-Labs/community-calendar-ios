//
//  EventTabBarController.swift
//  Community Calendar
//
//  Created by Jordan Christensen on 2/5/20.
//  Copyright © 2020 Lambda School All rights reserved.
//

import UIKit
import OktaOidc

protocol ControllerDelegate {
    var controller: Controller? { get set }
    var apolloController: ApolloController? { get set }
    var authController: AuthController? { get set }
}

class EventTabBarController: UITabBarController {

    let apolloController = ApolloController()
    let authController = AuthController()
    let controller = Controller()
    var oktaOidc: OktaOidc?
    var stateManager: OktaOidcStateManager?
    
    @IBOutlet weak var eventTabBarController: UITabBar!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        authController.setupOktaOidc()
        if let viewControllers = self.viewControllers {
            for viewController in viewControllers {
                if var VC = viewController as? ControllerDelegate {
                    VC.controller = controller
                    VC.apolloController = apolloController
                    VC.authController = authController
                }
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

//
//  EventTabBarController.swift
//  Community Calendar
//
//  Created by Jordan Christensen on 2/5/20.
//  Copyright © 2020 Lambda School All rights reserved.
//

import UIKit

protocol ControllerDelegate {
    var controller: Controller? { get set }
}

class EventTabBarController: UITabBarController {

    @IBOutlet weak var eventTabBarController: UITabBar!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let controller = Controller()
        if let viewControllers = self.viewControllers {
            for viewController in viewControllers {
                if var VC = viewController as? ControllerDelegate {
                    VC.controller = controller
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

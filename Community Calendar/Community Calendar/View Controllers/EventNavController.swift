//
//  HomeNavigationController.swift
//  Community Calendar
//
//  Created by Jordan Christensen on 2/5/20.
//  Copyright © 2020 Mazjap Co. All rights reserved.
//

import UIKit

class EventNavController: UINavigationController, ControllerDelegate {
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
        guard let controller = controller else { return }
        for viewController in self.viewControllers {
            if var VC = viewController as? ControllerDelegate {
                VC.controller = controller
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

//
//  UIViewController+UserInfoAlert.swift
//  Community Calendar
//
//  Created by Michael on 5/9/20.
//  Copyright © 2020 Mazjap Co. All rights reserved.
//

import UIKit

extension UIViewController {
    func presentUserInfoAlert(title: String?, message: String?, dismissActionCompletion: ((UIAlertAction) -> Void)? = nil, completion: (() -> Void)? = nil) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let dismissAction = UIAlertAction(title: "Dismiss", style: .cancel, handler: dismissActionCompletion)
        
        alertController.addAction(dismissAction)
        
        present(alertController, animated: true, completion: completion)
    }
}

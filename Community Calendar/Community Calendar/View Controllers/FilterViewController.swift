//
//  FilterViewController.swift
//  Community Calendar
//
//  Created by Jordan Christensen on 1/15/20.
//  Copyright © 2020 Mazjap Co. All rights reserved.
//

import UIKit

protocol FilterDelegate {
    func receive(filters: [String])
}

class FilterViewController: UIViewController {
    
    var delegate: FilterDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()

        delegate?.receive(filters: ["hi!"])
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

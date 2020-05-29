//
//  FilteredEventDataSource.swift
//  Community Calendar
//
//  Created by Michael on 5/11/20.
//  Copyright © 2020 Mazjap Co. All rights reserved.
//

import UIKit

//final class FilteredEventDataSource: NSObject, UITableViewDataSource {
//    
//    // MARK: - Properties
//    var events = [Event]()
//    // MARK: - Initializer
//    init?(for filter: FilterEventType) {
//        super.init()
//    }
//    
//    // MARK: - Table View Data Source
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        apolloController?.events?.count
//    }
//    
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "EventTableViewCell", for: indexPath) as! EventTableViewCell
//        
//        let event = events[indexPath.row]
//        
//        cell.event = event
//        
//        return cell
//    }
//}

//
//  FilteredEventPhotoOperation.swift
//  Community Calendar
//
//  Created by Michael on 5/12/20.
//  Copyright © 2020 Mazjap Co. All rights reserved.
//

import UIKit

class FilteredEventPhotoOperation: ConcurrentOperation {
    var dataTask: URLSessionDataTask?
    
    var image: UIImage?
    
    let session: URLSession
    
    let event: FetchEventsQuery.Data.Event
    
    init(event: FetchEventsQuery.Data.Event, session: URLSession = URLSession.shared) {
        self.event = event
        self.session = session
        super.init()
    }
    
    override func start() {
        state = .isExecuting
        guard
            let urlString = (event.eventImages?.first?.url),
            let url = URL(string: urlString)
            else { return }
        
        
        let task = session.dataTask(with: url) { (data, response, error) in
            defer { self.state = .isFinished }
            if self.isCancelled { return }
            if let error = error {
                NSLog("Error fetching data for \(self.event): \(error)")
                return
            }
            
            if let data = data {
                self.image = UIImage(data: data)
            }
        }
        task.resume()
        dataTask = task
    }
    
    override func cancel() {
        dataTask?.cancel()
        super.cancel()
    }
}

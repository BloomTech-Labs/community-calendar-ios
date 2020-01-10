//
//  EventDetailViewController.swift
//  Community Calendar
//
//  Created by Jordan Christensen on 1/11/20.
//  Copyright © 2020 Mazjap Co. All rights reserved.
//

import UIKit

class EventDetailViewController: UIViewController {
    
    var event: Event? {
        didSet {
            updateViews()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        updateViews()
    }
    
    private func updateViews() {
        guard isViewLoaded, let event = event else { return }
        title = event.title
    }
    
    @IBAction func showInMaps(_ sender: UIButton) {
        if let event = event, let address = event.locations.first?.streetAddress, let zip = event.locations.first?.zipcode {
            let baseURL = URL(string: "http://maps.apple.com/")!
            var components = URLComponents(url: baseURL, resolvingAgainstBaseURL: true)
            var addressNoSpaces = ""
            var isFirstSpace = true
            for letter in address {
                if letter != " " {
                    addressNoSpaces = "\(addressNoSpaces)\(letter)"
                } else if isFirstSpace {
                    isFirstSpace = false
                    addressNoSpaces = "\(addressNoSpaces),"
                }
            }
            
            let addressQuery = URLQueryItem(name: "address", value: "\(addressNoSpaces),\(zip)")
            components?.queryItems = [addressQuery]
            UIApplication.shared.open(components?.url ?? baseURL)
        } else if event?.locations.first == nil {
            print("Event has no location listed!")
        }
    }
    
    @IBAction func showInCalendar(_ sender: Any) {
        
    }
}

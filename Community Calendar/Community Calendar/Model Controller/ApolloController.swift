//
//  ApolloClient.swift
//  Community Calendar
//
//  Created by Michael on 5/5/20.
//  Copyright © 2020 Mazjap Co. All rights reserved.
//

import Foundation
import Apollo
import OktaOidc
import Cloudinary

class ApolloController: NSObject, HTTPNetworkTransportDelegate, URLSessionDelegate {

    private static let url = URL(string: "https://apollo.ourcommunitycal.com/")!
    var apollo: ApolloClient = ApolloClient(url: ApolloController.url)
    var currentUserID: GraphQLID?
    var events = [Event]()
    var userEvents = [Event]()
    var events2 = [FetchEventsQuery.Data.Event]()
    var filteredEvents = [FetchEventsQuery.Data.Event]()
    var attendingEvents = [FetchUserIdQuery.Data.User.Rsvp]()
    var createdEvents = [FetchUserIdQuery.Data.User.CreatedEvent]()
    var todaysEvents = [FetchDateRangedEventsQuery.Data.Event]()
    var savedEvents = [FetchUserIdQuery.Data.User.Saved]()
    var tomorrowsEvents = [FetchDateRangedEventsQuery.Data.Event]()
    var weekendEvents = [FetchDateRangedEventsQuery.Data.Event]()
    var allEvents = [FetchDateRangedEventsQuery.Data.Event]()
    var allUsersEvents = [FetchUserIdQuery.Data.User]()
    
    let defaults = UserDefaults.standard
    
    func fetchEvents(completion: @escaping (Swift.Result<[FetchEventsQuery.Data.Event], Error>) -> Void) {
        apollo.fetch(query: FetchEventsQuery(), cachePolicy: .returnCacheDataElseFetch) { result in
            switch result {
            case .failure(let error):
                print("Error fetching events: \(error)")
                completion(.failure(error))
            case .success(let graphQLResult):
                if let events = graphQLResult.data?.events {
                    let sortedEvents = events.sorted(by: { $0.start < $1.start })
                    self.events2 = sortedEvents
                    for event in sortedEvents {
                        let newEvent = Event(event: event)
                        self.events.append(newEvent)
                    }
                    completion(.success(sortedEvents))
                }
            }
        }
    }
    
    func fetchUserID(oktaID: String, completion: @escaping (Swift.Result<FetchUserIdQuery.Data.User, Error>) -> Void) {
        apollo.fetch(query: FetchUserIdQuery(oktaId: oktaID), cachePolicy: .returnCacheDataElseFetch) { result in
            switch result {
            case .failure(let error):
                print("Error getting user ID: \(error)")
                completion(.failure(error))
            case .success(let graphQLResult):
                if let user = graphQLResult.data?.user, let createdEvents = user.createdEvents, let savedEvents = user.saved, let attendingEvents = user.rsvps {
                    let sortedAttending = attendingEvents.sorted(by: { $0.startDate < $1.startDate })
                    let sortedSaved = savedEvents.sorted(by: { $0.startDate < $1.startDate })
                    let sortedCreated = createdEvents.sorted(by: { $0.startDate < $1.startDate })
                    for event in sortedAttending {
                        let attendingEvent = Event(attending: event)
                        self.userEvents.append(attendingEvent)
                    }
                    for event in sortedSaved {
                        let savedEvent = Event(saved: event)
                        self.userEvents.append(savedEvent)
                    }
                    for event in sortedCreated {
                        let createdEvent = Event(created: event)
                        self.userEvents.append(createdEvent)
                    }
                    self.currentUserID = user.id
//                    self.attendingEvents = sortedAttending
//                    self.savedEvents = sortedSaved
//                    self.createdEvents = sortedCreated
                    
                    completion(.success(user))
                }
            }
        }
    }
    
    func updateProfilePic(image: String, graphQLID: String, accessToken: String, file: GraphQLFile, completion: @escaping (Swift.Result<AddProfilePicMutation.Data.UpdateUser, Error>) -> Void) {
        apollo = configureApolloClient(accessToken: accessToken)
        apollo.upload(operation: AddProfilePicMutation(image: image, id: graphQLID), files: [file]) { result in
            switch result {
            case .failure(let error):
                print("Error updating users profile picture: \(error)")
                completion(.failure(error))
            case .success(let graphQLResult):
                if let user = graphQLResult.data?.updateUser {
                    let userID = user.id
                    let profileImage = user.profileImage
                    print("Success! User ID: \(userID), Profile Image: \(String(describing: profileImage))")
                    completion(.success(user))
                }
            }
        }
    }
    
    func updateProfileImage(urlString: String, graphQLID: String, accessToken: String, completion: @escaping (Swift.Result<UpdateProfileImageMutation.Data.UpdateUser, Error>) -> Void) {
        apollo = configureApolloClient(accessToken: accessToken)
        apollo.perform(mutation: UpdateProfileImageMutation(profileImage: urlString, id: graphQLID)) { result in
            switch result {
            case .failure(let error):
                print("Error updating users profile picture on back end: \(error)")
                completion(.failure(error))
            case .success(let graphQLResult):
                if let response = graphQLResult.data?.updateUser {
                    let profileImage = response.profileImage
                    let userID = response.id
                    print("Successfully updated users profile image: \(String(describing: profileImage)), for user ID: \(userID)")
                    completion(.success(response))
                }
            }
        }
    }
    
    func configureApolloClient(accessToken: String) -> ApolloClient {
        let configuration = URLSessionConfiguration.default
        configuration.httpAdditionalHeaders = ["Authorization": "Bearer \(accessToken)"]
        
        let client = URLSessionClient(sessionConfiguration: configuration, callbackQueue: nil)
        let transport = HTTPNetworkTransport(url: ApolloController.url, client: client)
        transport.delegate = self
        
        return ApolloClient(networkTransport: transport)
    }
    
    func updateUserInfo(urlString: String?, firstName: String?, lastName: String?, graphQLID: String, accessToken: String, completion: @escaping (Swift.Result<UpdateUserInfoMutation.Data.UpdateUser, Error>) -> Void) {
        apollo = configureApolloClient(accessToken: accessToken)
        apollo.perform(mutation: UpdateUserInfoMutation(profileImage: urlString, firstName: firstName, lastName: lastName, id: graphQLID)) { result in
            switch result {
            case .failure(let error):
                print("Error updating users profile info: \(error)")
                completion(.failure(error))
            case .success(let graphQLResult):
                if let response = graphQLResult.data?.updateUser {
                    let userID = response.id
                    let profileImage = response.profileImage
                    let firstName = response.firstName
                    let lastName = response.lastName
//                    print("Successfully updated user information for User ID: \(userID), Profile Image: \(String(describing: profileImage)), First Name: \(String(describing: firstName)), Last Name: \(String(describing: lastName))")
                    completion(.success(response))
                }
            }
        }
    }
    
    // MARK: - Cloudinary Host Image Function
    func hostImage(imageData: Data, completion: @escaping (Swift.Result<String, Error>) -> Void) {
        let config = CLDConfiguration(cloudName: "communitycalendar")
        let cloudinary = CLDCloudinary(configuration: config)
        cloudinary.createUploader().upload(data: imageData, uploadPreset: "ComCal") { response, error in
            if let error = error {
                print("Error hosting image: \(error)")
                completion(.failure(error))
            }
            if let response = response, let urlString = response.secureUrl {
                print("Cloudinary response: \(response)")
                completion(.success(urlString))
            }
        }
    }
    
    func getAttendingEvents(graphQLID: String, accessToken: String, completion: @escaping (Swift.Result<[GetUsersEventsQuery.Data.User.Rsvp], Error>) -> Void) {
        apollo = configureApolloClient(accessToken: accessToken)
        apollo.fetch(query: GetUsersEventsQuery(id: graphQLID), cachePolicy: .returnCacheDataElseFetch) { result in
            switch result {
            case .failure(let error):
                print("Error fetching users rsvp'd events: \(error)")
                completion(.failure(error))
            case .success(let graphQLResult):
                if let eventsAttending = graphQLResult.data?.user.rsvps {
                    
                    print("This is the rsvp'd events: \(String(describing: eventsAttending))")
                    completion(.success(eventsAttending))
                }
            }
        }
    }
    
    func getUserCreatedEvents(graphQLID: String, accessToken: String, completion: @escaping (Swift.Result<[GetUsersCreatedEventsQuery.Data.User.CreatedEvent], Error>) -> Void) {
        apollo = configureApolloClient(accessToken: accessToken)
        apollo.fetch(query: GetUsersCreatedEventsQuery(id: graphQLID), cachePolicy: .returnCacheDataElseFetch) { result in
            switch result {
            case .failure(let error):
                print("Error fetching users created events: \(error)")
                completion(.failure(error))
            case .success(let graphQLResult):
                if let createdEvents = graphQLResult.data?.user.createdEvents {
                    print(createdEvents.count)
                    completion(.success(createdEvents))
                }
            }
        }
    }
    
    func fetchTomorrowsEvents(completion: @escaping (Swift.Result<[FetchDateRangedEventsQuery.Data.Event], Error>) -> Void) {
        let dates = tomorrowsDateRange()
        guard let startDate = dates.first, let endDate = dates.last else {
            print("Returned out of dates guard let in fetch tomorrow's events function")
            return
        }
        let start = backendDateFormatter.string(from: startDate)
        let end = backendDateFormatter.string(from: endDate)
        apollo.fetch(query: FetchDateRangedEventsQuery(start: start, end: end), cachePolicy: .returnCacheDataElseFetch) { result in
            switch result {
            case .failure(let error):
                print("Error fetching events for tomorrow: \(error)")
                completion(.failure(error))
            case .success(let graphQLResult):
                if let tomorrowsEvents = graphQLResult.data?.events {
                    self.tomorrowsEvents = tomorrowsEvents
                    print(tomorrowsEvents.count)
                    completion(.success(tomorrowsEvents))
                }
            }
        }
    }
    
    func fetchTodaysEvents(completion: @escaping (Swift.Result<[FetchDateRangedEventsQuery.Data.Event], Error>) -> Void) {
        let dates = todaysDateRange()
        guard let startDate = dates.first, let endDate = dates.last else {
            print("Returned out of dates guard let in fetch today's events function.")
            return
        }
       
        let start = backendDateFormatter.string(from: startDate)
        let end = backendDateFormatter.string(from: endDate)
        apollo.fetch(query: FetchDateRangedEventsQuery(start: start, end: end), cachePolicy: .returnCacheDataElseFetch) { result in
            switch result {
            case .failure(let error):
                print("Error fetching events for today: \(error)")
                completion(.failure(error))
            case .success(let graphQLResult):
                if let todaysEvents = graphQLResult.data?.events {
                    self.todaysEvents = todaysEvents
                    print("Todays Event Count: \(todaysEvents.count)")
                    completion(.success(todaysEvents))
                }
            }
        }
    }
    
    func fetchWeekendEvents(completion: @escaping (Swift.Result<[FetchDateRangedEventsQuery.Data.Event], Error>) -> Void) {
        let dates = weekendDateRange()
        guard let startDate = dates.first, let endDate = dates.last else {
            print("Returned out of dates guard let in fetch weekend events function.")
            return
        }
        let start = backendDateFormatter.string(from: startDate)
        let end = backendDateFormatter.string(from: endDate)
        apollo.fetch(query: FetchDateRangedEventsQuery(start: start, end: end), cachePolicy: .returnCacheDataElseFetch) { result in
            switch result {
            case .failure(let error):
                print("Error fetching events for weekend: \(error)")
                completion(.failure(error))
            case .success(let graphQLResult):
                if let weekendEvents = graphQLResult.data?.events {
                    self.weekendEvents = weekendEvents
                    print("Weekend Event Count: \(weekendEvents.count)")
                    completion(.success(weekendEvents))
                }
            }
        }
    }
    
    func fetchAllEvents(completion: @escaping (Swift.Result<[FetchDateRangedEventsQuery.Data.Event], Error>) -> Void) {
        let dates = allEventsRange()
        guard let startDate = dates.first, let endDate = dates.last else {
            print("Returned out of dates guard let in fetch all events function.")
            return
        }
        let start = backendDateFormatter.string(from: startDate)
        let end = backendDateFormatter.string(from: endDate)
        apollo.fetch(query: FetchDateRangedEventsQuery(start: start, end: end), cachePolicy: .returnCacheDataElseFetch) { result in
            switch result {
            case .failure(let error):
                print("Error fetching all events of filtered events: \(error)")
                completion(.failure(error))
            case .success(let graphQLResult):
                if let allEvents = graphQLResult.data?.events {
                    self.allEvents = allEvents
                    print(allEvents.count)
                    completion(.success(allEvents))
                }
            }
        }
    }
    
    func todaysDateRange() -> [Date] {
        var todayRange = [Date]()
        let calendar = Calendar.current
        let today = Date()
        let midnight = calendar.startOfDay(for: today)
        let tomorrow = calendar.date(byAdding: .day, value: 1, to: today)!
        
        todayRange.append(midnight)
        todayRange.append(tomorrow)
        
        return todayRange
    }
    
    func selectedDate(date: Date) -> [Date] {
        var dateRange = [Date]()
        let calendar = Calendar.current
        let selectedDate = date
        let midnight = calendar.startOfDay(for: selectedDate)
        let tomorrow = calendar.date(byAdding: .day, value: 1, to: midnight)!

        dateRange.append(midnight)
        dateRange.append(tomorrow)
        
        return dateRange
    }
    
    func tomorrowsDateRange() -> [Date] {
        var dateRange = [Date]()
        let calendar = Calendar.current
        let today = Date()
        let midnight = calendar.startOfDay(for: today)
        let tomorrow = calendar.date(byAdding: .day, value: 1, to: midnight)!
        let dayAfterTomorrow = calendar.date(byAdding: .day, value: 2, to: midnight)!
        
        dateRange.append(tomorrow)
        dateRange.append(dayAfterTomorrow)
        
        return dateRange
    }
    
    func weekendDateRange() -> [Date] {
        var dateRange = [Date]()
        let calendar = Calendar.current
        let today = Date()
        let weekend = calendar.nextWeekend(startingAfter: today)
        dateRange.append(weekend!.start)
        dateRange.append(weekend!.end)
        
        return dateRange
    }
    
    func allEventsRange() -> [Date] {
        var dateRange = [Date]()
        let calendar = Calendar.current
        let today = Date()
        let severYears = calendar.date(byAdding: .year, value: 7, to: today)!
        
        dateRange.append(today)
        dateRange.append(severYears)
        
        return dateRange
    }
}

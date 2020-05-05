//
//  ApolloClient.swift
//  Community Calendar
//
//  Created by Michael on 5/5/20.
//  Copyright © 2020 Mazjap Co. All rights reserved.
//

import Foundation

//class ApolloClient: NSObject, HTTPNetworkTransportDelegate, URLSessionDelegate {
//    
//    
//    func configureApolloClient(accessToken: String) -> ApolloClient {
//        let configuration = URLSessionConfiguration.default
//        configuration.httpAdditionalHeaders = ["Authorization": "Bearer \(accessToken)"]
//        
//        let client = URLSessionClient(sessionConfiguration: configuration, callbackQueue: nil)
//        let transport = HTTPNetworkTransport(url: EventController.url, client: client)
//        print("Apollo Client: \(accessToken)")
//        
//        return ApolloClient(networkTransport: transport)
//        //        return ApolloClient(networkTransport: HTTPNetworkTransport(url: EventController.url, session: URLSession(configuration: configuration), delegate: self))
//    }
//}

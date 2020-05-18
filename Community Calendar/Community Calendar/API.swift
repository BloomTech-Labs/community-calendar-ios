// @generated
//  This file was automatically generated and should not be edited.

import Apollo
import Foundation

public final class FetchEventsQuery: GraphQLQuery {
  /// The raw GraphQL definition of this operation.
  public let operationDefinition: String =
    """
    query FetchEvents {
      events {
        __typename
        id
        title
        description
        start
        end
        ticketPrice
        creator {
          __typename
          id
          firstName
          lastName
          profileImage
        }
        eventImages {
          __typename
          id
          url
        }
        locations {
          __typename
          id
          name
          streetAddress
          streetAddress2
          city
          state
          zipcode
          longitude
          latitude
          neighborhood {
            __typename
            id
            geoJson {
              __typename
              id
            }
          }
        }
      }
    }
    """

  public let operationName: String = "FetchEvents"

  public init() {
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes: [String] = ["Query"]

    public static let selections: [GraphQLSelection] = [
      GraphQLField("events", type: .list(.nonNull(.object(Event.selections)))),
    ]

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(events: [Event]? = nil) {
      self.init(unsafeResultMap: ["__typename": "Query", "events": events.flatMap { (value: [Event]) -> [ResultMap] in value.map { (value: Event) -> ResultMap in value.resultMap } }])
    }

    public var events: [Event]? {
      get {
        return (resultMap["events"] as? [ResultMap]).flatMap { (value: [ResultMap]) -> [Event] in value.map { (value: ResultMap) -> Event in Event(unsafeResultMap: value) } }
      }
      set {
        resultMap.updateValue(newValue.flatMap { (value: [Event]) -> [ResultMap] in value.map { (value: Event) -> ResultMap in value.resultMap } }, forKey: "events")
      }
    }

    public struct Event: GraphQLSelectionSet {
      public static let possibleTypes: [String] = ["Event"]

      public static let selections: [GraphQLSelection] = [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("id", type: .nonNull(.scalar(GraphQLID.self))),
        GraphQLField("title", type: .nonNull(.scalar(String.self))),
        GraphQLField("description", type: .nonNull(.scalar(String.self))),
        GraphQLField("start", type: .nonNull(.scalar(String.self))),
        GraphQLField("end", type: .nonNull(.scalar(String.self))),
        GraphQLField("ticketPrice", type: .nonNull(.scalar(Double.self))),
        GraphQLField("creator", type: .object(Creator.selections)),
        GraphQLField("eventImages", type: .list(.nonNull(.object(EventImage.selections)))),
        GraphQLField("locations", type: .list(.nonNull(.object(Location.selections)))),
      ]

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(id: GraphQLID, title: String, description: String, start: String, end: String, ticketPrice: Double, creator: Creator? = nil, eventImages: [EventImage]? = nil, locations: [Location]? = nil) {
        self.init(unsafeResultMap: ["__typename": "Event", "id": id, "title": title, "description": description, "start": start, "end": end, "ticketPrice": ticketPrice, "creator": creator.flatMap { (value: Creator) -> ResultMap in value.resultMap }, "eventImages": eventImages.flatMap { (value: [EventImage]) -> [ResultMap] in value.map { (value: EventImage) -> ResultMap in value.resultMap } }, "locations": locations.flatMap { (value: [Location]) -> [ResultMap] in value.map { (value: Location) -> ResultMap in value.resultMap } }])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

      public var id: GraphQLID {
        get {
          return resultMap["id"]! as! GraphQLID
        }
        set {
          resultMap.updateValue(newValue, forKey: "id")
        }
      }

      public var title: String {
        get {
          return resultMap["title"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "title")
        }
      }

      public var description: String {
        get {
          return resultMap["description"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "description")
        }
      }

      public var start: String {
        get {
          return resultMap["start"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "start")
        }
      }

      public var end: String {
        get {
          return resultMap["end"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "end")
        }
      }

      public var ticketPrice: Double {
        get {
          return resultMap["ticketPrice"]! as! Double
        }
        set {
          resultMap.updateValue(newValue, forKey: "ticketPrice")
        }
      }

      public var creator: Creator? {
        get {
          return (resultMap["creator"] as? ResultMap).flatMap { Creator(unsafeResultMap: $0) }
        }
        set {
          resultMap.updateValue(newValue?.resultMap, forKey: "creator")
        }
      }

      public var eventImages: [EventImage]? {
        get {
          return (resultMap["eventImages"] as? [ResultMap]).flatMap { (value: [ResultMap]) -> [EventImage] in value.map { (value: ResultMap) -> EventImage in EventImage(unsafeResultMap: value) } }
        }
        set {
          resultMap.updateValue(newValue.flatMap { (value: [EventImage]) -> [ResultMap] in value.map { (value: EventImage) -> ResultMap in value.resultMap } }, forKey: "eventImages")
        }
      }

      public var locations: [Location]? {
        get {
          return (resultMap["locations"] as? [ResultMap]).flatMap { (value: [ResultMap]) -> [Location] in value.map { (value: ResultMap) -> Location in Location(unsafeResultMap: value) } }
        }
        set {
          resultMap.updateValue(newValue.flatMap { (value: [Location]) -> [ResultMap] in value.map { (value: Location) -> ResultMap in value.resultMap } }, forKey: "locations")
        }
      }

      public struct Creator: GraphQLSelectionSet {
        public static let possibleTypes: [String] = ["User"]

        public static let selections: [GraphQLSelection] = [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("id", type: .nonNull(.scalar(GraphQLID.self))),
          GraphQLField("firstName", type: .scalar(String.self)),
          GraphQLField("lastName", type: .scalar(String.self)),
          GraphQLField("profileImage", type: .scalar(String.self)),
        ]

        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public init(id: GraphQLID, firstName: String? = nil, lastName: String? = nil, profileImage: String? = nil) {
          self.init(unsafeResultMap: ["__typename": "User", "id": id, "firstName": firstName, "lastName": lastName, "profileImage": profileImage])
        }

        public var __typename: String {
          get {
            return resultMap["__typename"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "__typename")
          }
        }

        public var id: GraphQLID {
          get {
            return resultMap["id"]! as! GraphQLID
          }
          set {
            resultMap.updateValue(newValue, forKey: "id")
          }
        }

        public var firstName: String? {
          get {
            return resultMap["firstName"] as? String
          }
          set {
            resultMap.updateValue(newValue, forKey: "firstName")
          }
        }

        public var lastName: String? {
          get {
            return resultMap["lastName"] as? String
          }
          set {
            resultMap.updateValue(newValue, forKey: "lastName")
          }
        }

        public var profileImage: String? {
          get {
            return resultMap["profileImage"] as? String
          }
          set {
            resultMap.updateValue(newValue, forKey: "profileImage")
          }
        }
      }

      public struct EventImage: GraphQLSelectionSet {
        public static let possibleTypes: [String] = ["EventImage"]

        public static let selections: [GraphQLSelection] = [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("id", type: .nonNull(.scalar(GraphQLID.self))),
          GraphQLField("url", type: .nonNull(.scalar(String.self))),
        ]

        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public init(id: GraphQLID, url: String) {
          self.init(unsafeResultMap: ["__typename": "EventImage", "id": id, "url": url])
        }

        public var __typename: String {
          get {
            return resultMap["__typename"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "__typename")
          }
        }

        public var id: GraphQLID {
          get {
            return resultMap["id"]! as! GraphQLID
          }
          set {
            resultMap.updateValue(newValue, forKey: "id")
          }
        }

        public var url: String {
          get {
            return resultMap["url"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "url")
          }
        }
      }

      public struct Location: GraphQLSelectionSet {
        public static let possibleTypes: [String] = ["Location"]

        public static let selections: [GraphQLSelection] = [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("id", type: .nonNull(.scalar(GraphQLID.self))),
          GraphQLField("name", type: .nonNull(.scalar(String.self))),
          GraphQLField("streetAddress", type: .nonNull(.scalar(String.self))),
          GraphQLField("streetAddress2", type: .scalar(String.self)),
          GraphQLField("city", type: .nonNull(.scalar(String.self))),
          GraphQLField("state", type: .nonNull(.scalar(String.self))),
          GraphQLField("zipcode", type: .nonNull(.scalar(Int.self))),
          GraphQLField("longitude", type: .scalar(Double.self)),
          GraphQLField("latitude", type: .scalar(Double.self)),
          GraphQLField("neighborhood", type: .object(Neighborhood.selections)),
        ]

        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public init(id: GraphQLID, name: String, streetAddress: String, streetAddress2: String? = nil, city: String, state: String, zipcode: Int, longitude: Double? = nil, latitude: Double? = nil, neighborhood: Neighborhood? = nil) {
          self.init(unsafeResultMap: ["__typename": "Location", "id": id, "name": name, "streetAddress": streetAddress, "streetAddress2": streetAddress2, "city": city, "state": state, "zipcode": zipcode, "longitude": longitude, "latitude": latitude, "neighborhood": neighborhood.flatMap { (value: Neighborhood) -> ResultMap in value.resultMap }])
        }

        public var __typename: String {
          get {
            return resultMap["__typename"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "__typename")
          }
        }

        public var id: GraphQLID {
          get {
            return resultMap["id"]! as! GraphQLID
          }
          set {
            resultMap.updateValue(newValue, forKey: "id")
          }
        }

        public var name: String {
          get {
            return resultMap["name"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "name")
          }
        }

        public var streetAddress: String {
          get {
            return resultMap["streetAddress"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "streetAddress")
          }
        }

        public var streetAddress2: String? {
          get {
            return resultMap["streetAddress2"] as? String
          }
          set {
            resultMap.updateValue(newValue, forKey: "streetAddress2")
          }
        }

        public var city: String {
          get {
            return resultMap["city"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "city")
          }
        }

        public var state: String {
          get {
            return resultMap["state"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "state")
          }
        }

        public var zipcode: Int {
          get {
            return resultMap["zipcode"]! as! Int
          }
          set {
            resultMap.updateValue(newValue, forKey: "zipcode")
          }
        }

        public var longitude: Double? {
          get {
            return resultMap["longitude"] as? Double
          }
          set {
            resultMap.updateValue(newValue, forKey: "longitude")
          }
        }

        public var latitude: Double? {
          get {
            return resultMap["latitude"] as? Double
          }
          set {
            resultMap.updateValue(newValue, forKey: "latitude")
          }
        }

        public var neighborhood: Neighborhood? {
          get {
            return (resultMap["neighborhood"] as? ResultMap).flatMap { Neighborhood(unsafeResultMap: $0) }
          }
          set {
            resultMap.updateValue(newValue?.resultMap, forKey: "neighborhood")
          }
        }

        public struct Neighborhood: GraphQLSelectionSet {
          public static let possibleTypes: [String] = ["Neighborhood"]

          public static let selections: [GraphQLSelection] = [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("id", type: .nonNull(.scalar(GraphQLID.self))),
            GraphQLField("geoJson", type: .nonNull(.object(GeoJson.selections))),
          ]

          public private(set) var resultMap: ResultMap

          public init(unsafeResultMap: ResultMap) {
            self.resultMap = unsafeResultMap
          }

          public init(id: GraphQLID, geoJson: GeoJson) {
            self.init(unsafeResultMap: ["__typename": "Neighborhood", "id": id, "geoJson": geoJson.resultMap])
          }

          public var __typename: String {
            get {
              return resultMap["__typename"]! as! String
            }
            set {
              resultMap.updateValue(newValue, forKey: "__typename")
            }
          }

          public var id: GraphQLID {
            get {
              return resultMap["id"]! as! GraphQLID
            }
            set {
              resultMap.updateValue(newValue, forKey: "id")
            }
          }

          public var geoJson: GeoJson {
            get {
              return GeoJson(unsafeResultMap: resultMap["geoJson"]! as! ResultMap)
            }
            set {
              resultMap.updateValue(newValue.resultMap, forKey: "geoJson")
            }
          }

          public struct GeoJson: GraphQLSelectionSet {
            public static let possibleTypes: [String] = ["GeoJson"]

            public static let selections: [GraphQLSelection] = [
              GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
              GraphQLField("id", type: .nonNull(.scalar(GraphQLID.self))),
            ]

            public private(set) var resultMap: ResultMap

            public init(unsafeResultMap: ResultMap) {
              self.resultMap = unsafeResultMap
            }

            public init(id: GraphQLID) {
              self.init(unsafeResultMap: ["__typename": "GeoJson", "id": id])
            }

            public var __typename: String {
              get {
                return resultMap["__typename"]! as! String
              }
              set {
                resultMap.updateValue(newValue, forKey: "__typename")
              }
            }

            public var id: GraphQLID {
              get {
                return resultMap["id"]! as! GraphQLID
              }
              set {
                resultMap.updateValue(newValue, forKey: "id")
              }
            }
          }
        }
      }
    }
  }
}

public final class GetUsersEventsQuery: GraphQLQuery {
  /// The raw GraphQL definition of this operation.
  public let operationDefinition: String =
    """
    query GetUsersEvents($id: ID!) {
      user(where: {id: $id}) {
        __typename
        rsvps {
          __typename
          id
          title
          description
          start
          end
          ticketPrice
          creator {
            __typename
            id
            firstName
            lastName
            profileImage
          }
          locations {
            __typename
            id
            name
            streetAddress
            streetAddress2
            city
            zipcode
            state
            latitude
            longitude
            neighborhood {
              __typename
              id
              geoJson {
                __typename
                id
              }
            }
          }
          eventImages {
            __typename
            id
            url
          }
        }
      }
    }
    """

  public let operationName: String = "GetUsersEvents"

  public var id: GraphQLID

  public init(id: GraphQLID) {
    self.id = id
  }

  public var variables: GraphQLMap? {
    return ["id": id]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes: [String] = ["Query"]

    public static let selections: [GraphQLSelection] = [
      GraphQLField("user", arguments: ["where": ["id": GraphQLVariable("id")]], type: .nonNull(.object(User.selections))),
    ]

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(user: User) {
      self.init(unsafeResultMap: ["__typename": "Query", "user": user.resultMap])
    }

    public var user: User {
      get {
        return User(unsafeResultMap: resultMap["user"]! as! ResultMap)
      }
      set {
        resultMap.updateValue(newValue.resultMap, forKey: "user")
      }
    }

    public struct User: GraphQLSelectionSet {
      public static let possibleTypes: [String] = ["User"]

      public static let selections: [GraphQLSelection] = [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("rsvps", type: .list(.nonNull(.object(Rsvp.selections)))),
      ]

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(rsvps: [Rsvp]? = nil) {
        self.init(unsafeResultMap: ["__typename": "User", "rsvps": rsvps.flatMap { (value: [Rsvp]) -> [ResultMap] in value.map { (value: Rsvp) -> ResultMap in value.resultMap } }])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

      public var rsvps: [Rsvp]? {
        get {
          return (resultMap["rsvps"] as? [ResultMap]).flatMap { (value: [ResultMap]) -> [Rsvp] in value.map { (value: ResultMap) -> Rsvp in Rsvp(unsafeResultMap: value) } }
        }
        set {
          resultMap.updateValue(newValue.flatMap { (value: [Rsvp]) -> [ResultMap] in value.map { (value: Rsvp) -> ResultMap in value.resultMap } }, forKey: "rsvps")
        }
      }

      public struct Rsvp: GraphQLSelectionSet {
        public static let possibleTypes: [String] = ["Event"]

        public static let selections: [GraphQLSelection] = [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("id", type: .nonNull(.scalar(GraphQLID.self))),
          GraphQLField("title", type: .nonNull(.scalar(String.self))),
          GraphQLField("description", type: .nonNull(.scalar(String.self))),
          GraphQLField("start", type: .nonNull(.scalar(String.self))),
          GraphQLField("end", type: .nonNull(.scalar(String.self))),
          GraphQLField("ticketPrice", type: .nonNull(.scalar(Double.self))),
          GraphQLField("creator", type: .object(Creator.selections)),
          GraphQLField("locations", type: .list(.nonNull(.object(Location.selections)))),
          GraphQLField("eventImages", type: .list(.nonNull(.object(EventImage.selections)))),
        ]

        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public init(id: GraphQLID, title: String, description: String, start: String, end: String, ticketPrice: Double, creator: Creator? = nil, locations: [Location]? = nil, eventImages: [EventImage]? = nil) {
          self.init(unsafeResultMap: ["__typename": "Event", "id": id, "title": title, "description": description, "start": start, "end": end, "ticketPrice": ticketPrice, "creator": creator.flatMap { (value: Creator) -> ResultMap in value.resultMap }, "locations": locations.flatMap { (value: [Location]) -> [ResultMap] in value.map { (value: Location) -> ResultMap in value.resultMap } }, "eventImages": eventImages.flatMap { (value: [EventImage]) -> [ResultMap] in value.map { (value: EventImage) -> ResultMap in value.resultMap } }])
        }

        public var __typename: String {
          get {
            return resultMap["__typename"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "__typename")
          }
        }

        public var id: GraphQLID {
          get {
            return resultMap["id"]! as! GraphQLID
          }
          set {
            resultMap.updateValue(newValue, forKey: "id")
          }
        }

        public var title: String {
          get {
            return resultMap["title"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "title")
          }
        }

        public var description: String {
          get {
            return resultMap["description"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "description")
          }
        }

        public var start: String {
          get {
            return resultMap["start"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "start")
          }
        }

        public var end: String {
          get {
            return resultMap["end"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "end")
          }
        }

        public var ticketPrice: Double {
          get {
            return resultMap["ticketPrice"]! as! Double
          }
          set {
            resultMap.updateValue(newValue, forKey: "ticketPrice")
          }
        }

        public var creator: Creator? {
          get {
            return (resultMap["creator"] as? ResultMap).flatMap { Creator(unsafeResultMap: $0) }
          }
          set {
            resultMap.updateValue(newValue?.resultMap, forKey: "creator")
          }
        }

        public var locations: [Location]? {
          get {
            return (resultMap["locations"] as? [ResultMap]).flatMap { (value: [ResultMap]) -> [Location] in value.map { (value: ResultMap) -> Location in Location(unsafeResultMap: value) } }
          }
          set {
            resultMap.updateValue(newValue.flatMap { (value: [Location]) -> [ResultMap] in value.map { (value: Location) -> ResultMap in value.resultMap } }, forKey: "locations")
          }
        }

        public var eventImages: [EventImage]? {
          get {
            return (resultMap["eventImages"] as? [ResultMap]).flatMap { (value: [ResultMap]) -> [EventImage] in value.map { (value: ResultMap) -> EventImage in EventImage(unsafeResultMap: value) } }
          }
          set {
            resultMap.updateValue(newValue.flatMap { (value: [EventImage]) -> [ResultMap] in value.map { (value: EventImage) -> ResultMap in value.resultMap } }, forKey: "eventImages")
          }
        }

        public struct Creator: GraphQLSelectionSet {
          public static let possibleTypes: [String] = ["User"]

          public static let selections: [GraphQLSelection] = [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("id", type: .nonNull(.scalar(GraphQLID.self))),
            GraphQLField("firstName", type: .scalar(String.self)),
            GraphQLField("lastName", type: .scalar(String.self)),
            GraphQLField("profileImage", type: .scalar(String.self)),
          ]

          public private(set) var resultMap: ResultMap

          public init(unsafeResultMap: ResultMap) {
            self.resultMap = unsafeResultMap
          }

          public init(id: GraphQLID, firstName: String? = nil, lastName: String? = nil, profileImage: String? = nil) {
            self.init(unsafeResultMap: ["__typename": "User", "id": id, "firstName": firstName, "lastName": lastName, "profileImage": profileImage])
          }

          public var __typename: String {
            get {
              return resultMap["__typename"]! as! String
            }
            set {
              resultMap.updateValue(newValue, forKey: "__typename")
            }
          }

          public var id: GraphQLID {
            get {
              return resultMap["id"]! as! GraphQLID
            }
            set {
              resultMap.updateValue(newValue, forKey: "id")
            }
          }

          public var firstName: String? {
            get {
              return resultMap["firstName"] as? String
            }
            set {
              resultMap.updateValue(newValue, forKey: "firstName")
            }
          }

          public var lastName: String? {
            get {
              return resultMap["lastName"] as? String
            }
            set {
              resultMap.updateValue(newValue, forKey: "lastName")
            }
          }

          public var profileImage: String? {
            get {
              return resultMap["profileImage"] as? String
            }
            set {
              resultMap.updateValue(newValue, forKey: "profileImage")
            }
          }
        }

        public struct Location: GraphQLSelectionSet {
          public static let possibleTypes: [String] = ["Location"]

          public static let selections: [GraphQLSelection] = [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("id", type: .nonNull(.scalar(GraphQLID.self))),
            GraphQLField("name", type: .nonNull(.scalar(String.self))),
            GraphQLField("streetAddress", type: .nonNull(.scalar(String.self))),
            GraphQLField("streetAddress2", type: .scalar(String.self)),
            GraphQLField("city", type: .nonNull(.scalar(String.self))),
            GraphQLField("zipcode", type: .nonNull(.scalar(Int.self))),
            GraphQLField("state", type: .nonNull(.scalar(String.self))),
            GraphQLField("latitude", type: .scalar(Double.self)),
            GraphQLField("longitude", type: .scalar(Double.self)),
            GraphQLField("neighborhood", type: .object(Neighborhood.selections)),
          ]

          public private(set) var resultMap: ResultMap

          public init(unsafeResultMap: ResultMap) {
            self.resultMap = unsafeResultMap
          }

          public init(id: GraphQLID, name: String, streetAddress: String, streetAddress2: String? = nil, city: String, zipcode: Int, state: String, latitude: Double? = nil, longitude: Double? = nil, neighborhood: Neighborhood? = nil) {
            self.init(unsafeResultMap: ["__typename": "Location", "id": id, "name": name, "streetAddress": streetAddress, "streetAddress2": streetAddress2, "city": city, "zipcode": zipcode, "state": state, "latitude": latitude, "longitude": longitude, "neighborhood": neighborhood.flatMap { (value: Neighborhood) -> ResultMap in value.resultMap }])
          }

          public var __typename: String {
            get {
              return resultMap["__typename"]! as! String
            }
            set {
              resultMap.updateValue(newValue, forKey: "__typename")
            }
          }

          public var id: GraphQLID {
            get {
              return resultMap["id"]! as! GraphQLID
            }
            set {
              resultMap.updateValue(newValue, forKey: "id")
            }
          }

          public var name: String {
            get {
              return resultMap["name"]! as! String
            }
            set {
              resultMap.updateValue(newValue, forKey: "name")
            }
          }

          public var streetAddress: String {
            get {
              return resultMap["streetAddress"]! as! String
            }
            set {
              resultMap.updateValue(newValue, forKey: "streetAddress")
            }
          }

          public var streetAddress2: String? {
            get {
              return resultMap["streetAddress2"] as? String
            }
            set {
              resultMap.updateValue(newValue, forKey: "streetAddress2")
            }
          }

          public var city: String {
            get {
              return resultMap["city"]! as! String
            }
            set {
              resultMap.updateValue(newValue, forKey: "city")
            }
          }

          public var zipcode: Int {
            get {
              return resultMap["zipcode"]! as! Int
            }
            set {
              resultMap.updateValue(newValue, forKey: "zipcode")
            }
          }

          public var state: String {
            get {
              return resultMap["state"]! as! String
            }
            set {
              resultMap.updateValue(newValue, forKey: "state")
            }
          }

          public var latitude: Double? {
            get {
              return resultMap["latitude"] as? Double
            }
            set {
              resultMap.updateValue(newValue, forKey: "latitude")
            }
          }

          public var longitude: Double? {
            get {
              return resultMap["longitude"] as? Double
            }
            set {
              resultMap.updateValue(newValue, forKey: "longitude")
            }
          }

          public var neighborhood: Neighborhood? {
            get {
              return (resultMap["neighborhood"] as? ResultMap).flatMap { Neighborhood(unsafeResultMap: $0) }
            }
            set {
              resultMap.updateValue(newValue?.resultMap, forKey: "neighborhood")
            }
          }

          public struct Neighborhood: GraphQLSelectionSet {
            public static let possibleTypes: [String] = ["Neighborhood"]

            public static let selections: [GraphQLSelection] = [
              GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
              GraphQLField("id", type: .nonNull(.scalar(GraphQLID.self))),
              GraphQLField("geoJson", type: .nonNull(.object(GeoJson.selections))),
            ]

            public private(set) var resultMap: ResultMap

            public init(unsafeResultMap: ResultMap) {
              self.resultMap = unsafeResultMap
            }

            public init(id: GraphQLID, geoJson: GeoJson) {
              self.init(unsafeResultMap: ["__typename": "Neighborhood", "id": id, "geoJson": geoJson.resultMap])
            }

            public var __typename: String {
              get {
                return resultMap["__typename"]! as! String
              }
              set {
                resultMap.updateValue(newValue, forKey: "__typename")
              }
            }

            public var id: GraphQLID {
              get {
                return resultMap["id"]! as! GraphQLID
              }
              set {
                resultMap.updateValue(newValue, forKey: "id")
              }
            }

            public var geoJson: GeoJson {
              get {
                return GeoJson(unsafeResultMap: resultMap["geoJson"]! as! ResultMap)
              }
              set {
                resultMap.updateValue(newValue.resultMap, forKey: "geoJson")
              }
            }

            public struct GeoJson: GraphQLSelectionSet {
              public static let possibleTypes: [String] = ["GeoJson"]

              public static let selections: [GraphQLSelection] = [
                GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                GraphQLField("id", type: .nonNull(.scalar(GraphQLID.self))),
              ]

              public private(set) var resultMap: ResultMap

              public init(unsafeResultMap: ResultMap) {
                self.resultMap = unsafeResultMap
              }

              public init(id: GraphQLID) {
                self.init(unsafeResultMap: ["__typename": "GeoJson", "id": id])
              }

              public var __typename: String {
                get {
                  return resultMap["__typename"]! as! String
                }
                set {
                  resultMap.updateValue(newValue, forKey: "__typename")
                }
              }

              public var id: GraphQLID {
                get {
                  return resultMap["id"]! as! GraphQLID
                }
                set {
                  resultMap.updateValue(newValue, forKey: "id")
                }
              }
            }
          }
        }

        public struct EventImage: GraphQLSelectionSet {
          public static let possibleTypes: [String] = ["EventImage"]

          public static let selections: [GraphQLSelection] = [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("id", type: .nonNull(.scalar(GraphQLID.self))),
            GraphQLField("url", type: .nonNull(.scalar(String.self))),
          ]

          public private(set) var resultMap: ResultMap

          public init(unsafeResultMap: ResultMap) {
            self.resultMap = unsafeResultMap
          }

          public init(id: GraphQLID, url: String) {
            self.init(unsafeResultMap: ["__typename": "EventImage", "id": id, "url": url])
          }

          public var __typename: String {
            get {
              return resultMap["__typename"]! as! String
            }
            set {
              resultMap.updateValue(newValue, forKey: "__typename")
            }
          }

          public var id: GraphQLID {
            get {
              return resultMap["id"]! as! GraphQLID
            }
            set {
              resultMap.updateValue(newValue, forKey: "id")
            }
          }

          public var url: String {
            get {
              return resultMap["url"]! as! String
            }
            set {
              resultMap.updateValue(newValue, forKey: "url")
            }
          }
        }
      }
    }
  }
}

public final class GetUsersCreatedEventsQuery: GraphQLQuery {
  /// The raw GraphQL definition of this operation.
  public let operationDefinition: String =
    """
    query GetUsersCreatedEvents($id: ID!) {
      user(where: {id: $id}) {
        __typename
        createdEvents {
          __typename
          id
          title
          description
          start
          end
          ticketPrice
          locations {
            __typename
            id
            name
            streetAddress
            streetAddress2
            city
            zipcode
            state
            latitude
            longitude
            neighborhood {
              __typename
              id
            }
          }
          eventImages {
            __typename
            id
            url
          }
        }
      }
    }
    """

  public let operationName: String = "GetUsersCreatedEvents"

  public var id: GraphQLID

  public init(id: GraphQLID) {
    self.id = id
  }

  public var variables: GraphQLMap? {
    return ["id": id]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes: [String] = ["Query"]

    public static let selections: [GraphQLSelection] = [
      GraphQLField("user", arguments: ["where": ["id": GraphQLVariable("id")]], type: .nonNull(.object(User.selections))),
    ]

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(user: User) {
      self.init(unsafeResultMap: ["__typename": "Query", "user": user.resultMap])
    }

    public var user: User {
      get {
        return User(unsafeResultMap: resultMap["user"]! as! ResultMap)
      }
      set {
        resultMap.updateValue(newValue.resultMap, forKey: "user")
      }
    }

    public struct User: GraphQLSelectionSet {
      public static let possibleTypes: [String] = ["User"]

      public static let selections: [GraphQLSelection] = [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("createdEvents", type: .list(.nonNull(.object(CreatedEvent.selections)))),
      ]

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(createdEvents: [CreatedEvent]? = nil) {
        self.init(unsafeResultMap: ["__typename": "User", "createdEvents": createdEvents.flatMap { (value: [CreatedEvent]) -> [ResultMap] in value.map { (value: CreatedEvent) -> ResultMap in value.resultMap } }])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

      public var createdEvents: [CreatedEvent]? {
        get {
          return (resultMap["createdEvents"] as? [ResultMap]).flatMap { (value: [ResultMap]) -> [CreatedEvent] in value.map { (value: ResultMap) -> CreatedEvent in CreatedEvent(unsafeResultMap: value) } }
        }
        set {
          resultMap.updateValue(newValue.flatMap { (value: [CreatedEvent]) -> [ResultMap] in value.map { (value: CreatedEvent) -> ResultMap in value.resultMap } }, forKey: "createdEvents")
        }
      }

      public struct CreatedEvent: GraphQLSelectionSet {
        public static let possibleTypes: [String] = ["Event"]

        public static let selections: [GraphQLSelection] = [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("id", type: .nonNull(.scalar(GraphQLID.self))),
          GraphQLField("title", type: .nonNull(.scalar(String.self))),
          GraphQLField("description", type: .nonNull(.scalar(String.self))),
          GraphQLField("start", type: .nonNull(.scalar(String.self))),
          GraphQLField("end", type: .nonNull(.scalar(String.self))),
          GraphQLField("ticketPrice", type: .nonNull(.scalar(Double.self))),
          GraphQLField("locations", type: .list(.nonNull(.object(Location.selections)))),
          GraphQLField("eventImages", type: .list(.nonNull(.object(EventImage.selections)))),
        ]

        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public init(id: GraphQLID, title: String, description: String, start: String, end: String, ticketPrice: Double, locations: [Location]? = nil, eventImages: [EventImage]? = nil) {
          self.init(unsafeResultMap: ["__typename": "Event", "id": id, "title": title, "description": description, "start": start, "end": end, "ticketPrice": ticketPrice, "locations": locations.flatMap { (value: [Location]) -> [ResultMap] in value.map { (value: Location) -> ResultMap in value.resultMap } }, "eventImages": eventImages.flatMap { (value: [EventImage]) -> [ResultMap] in value.map { (value: EventImage) -> ResultMap in value.resultMap } }])
        }

        public var __typename: String {
          get {
            return resultMap["__typename"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "__typename")
          }
        }

        public var id: GraphQLID {
          get {
            return resultMap["id"]! as! GraphQLID
          }
          set {
            resultMap.updateValue(newValue, forKey: "id")
          }
        }

        public var title: String {
          get {
            return resultMap["title"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "title")
          }
        }

        public var description: String {
          get {
            return resultMap["description"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "description")
          }
        }

        public var start: String {
          get {
            return resultMap["start"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "start")
          }
        }

        public var end: String {
          get {
            return resultMap["end"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "end")
          }
        }

        public var ticketPrice: Double {
          get {
            return resultMap["ticketPrice"]! as! Double
          }
          set {
            resultMap.updateValue(newValue, forKey: "ticketPrice")
          }
        }

        public var locations: [Location]? {
          get {
            return (resultMap["locations"] as? [ResultMap]).flatMap { (value: [ResultMap]) -> [Location] in value.map { (value: ResultMap) -> Location in Location(unsafeResultMap: value) } }
          }
          set {
            resultMap.updateValue(newValue.flatMap { (value: [Location]) -> [ResultMap] in value.map { (value: Location) -> ResultMap in value.resultMap } }, forKey: "locations")
          }
        }

        public var eventImages: [EventImage]? {
          get {
            return (resultMap["eventImages"] as? [ResultMap]).flatMap { (value: [ResultMap]) -> [EventImage] in value.map { (value: ResultMap) -> EventImage in EventImage(unsafeResultMap: value) } }
          }
          set {
            resultMap.updateValue(newValue.flatMap { (value: [EventImage]) -> [ResultMap] in value.map { (value: EventImage) -> ResultMap in value.resultMap } }, forKey: "eventImages")
          }
        }

        public struct Location: GraphQLSelectionSet {
          public static let possibleTypes: [String] = ["Location"]

          public static let selections: [GraphQLSelection] = [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("id", type: .nonNull(.scalar(GraphQLID.self))),
            GraphQLField("name", type: .nonNull(.scalar(String.self))),
            GraphQLField("streetAddress", type: .nonNull(.scalar(String.self))),
            GraphQLField("streetAddress2", type: .scalar(String.self)),
            GraphQLField("city", type: .nonNull(.scalar(String.self))),
            GraphQLField("zipcode", type: .nonNull(.scalar(Int.self))),
            GraphQLField("state", type: .nonNull(.scalar(String.self))),
            GraphQLField("latitude", type: .scalar(Double.self)),
            GraphQLField("longitude", type: .scalar(Double.self)),
            GraphQLField("neighborhood", type: .object(Neighborhood.selections)),
          ]

          public private(set) var resultMap: ResultMap

          public init(unsafeResultMap: ResultMap) {
            self.resultMap = unsafeResultMap
          }

          public init(id: GraphQLID, name: String, streetAddress: String, streetAddress2: String? = nil, city: String, zipcode: Int, state: String, latitude: Double? = nil, longitude: Double? = nil, neighborhood: Neighborhood? = nil) {
            self.init(unsafeResultMap: ["__typename": "Location", "id": id, "name": name, "streetAddress": streetAddress, "streetAddress2": streetAddress2, "city": city, "zipcode": zipcode, "state": state, "latitude": latitude, "longitude": longitude, "neighborhood": neighborhood.flatMap { (value: Neighborhood) -> ResultMap in value.resultMap }])
          }

          public var __typename: String {
            get {
              return resultMap["__typename"]! as! String
            }
            set {
              resultMap.updateValue(newValue, forKey: "__typename")
            }
          }

          public var id: GraphQLID {
            get {
              return resultMap["id"]! as! GraphQLID
            }
            set {
              resultMap.updateValue(newValue, forKey: "id")
            }
          }

          public var name: String {
            get {
              return resultMap["name"]! as! String
            }
            set {
              resultMap.updateValue(newValue, forKey: "name")
            }
          }

          public var streetAddress: String {
            get {
              return resultMap["streetAddress"]! as! String
            }
            set {
              resultMap.updateValue(newValue, forKey: "streetAddress")
            }
          }

          public var streetAddress2: String? {
            get {
              return resultMap["streetAddress2"] as? String
            }
            set {
              resultMap.updateValue(newValue, forKey: "streetAddress2")
            }
          }

          public var city: String {
            get {
              return resultMap["city"]! as! String
            }
            set {
              resultMap.updateValue(newValue, forKey: "city")
            }
          }

          public var zipcode: Int {
            get {
              return resultMap["zipcode"]! as! Int
            }
            set {
              resultMap.updateValue(newValue, forKey: "zipcode")
            }
          }

          public var state: String {
            get {
              return resultMap["state"]! as! String
            }
            set {
              resultMap.updateValue(newValue, forKey: "state")
            }
          }

          public var latitude: Double? {
            get {
              return resultMap["latitude"] as? Double
            }
            set {
              resultMap.updateValue(newValue, forKey: "latitude")
            }
          }

          public var longitude: Double? {
            get {
              return resultMap["longitude"] as? Double
            }
            set {
              resultMap.updateValue(newValue, forKey: "longitude")
            }
          }

          public var neighborhood: Neighborhood? {
            get {
              return (resultMap["neighborhood"] as? ResultMap).flatMap { Neighborhood(unsafeResultMap: $0) }
            }
            set {
              resultMap.updateValue(newValue?.resultMap, forKey: "neighborhood")
            }
          }

          public struct Neighborhood: GraphQLSelectionSet {
            public static let possibleTypes: [String] = ["Neighborhood"]

            public static let selections: [GraphQLSelection] = [
              GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
              GraphQLField("id", type: .nonNull(.scalar(GraphQLID.self))),
            ]

            public private(set) var resultMap: ResultMap

            public init(unsafeResultMap: ResultMap) {
              self.resultMap = unsafeResultMap
            }

            public init(id: GraphQLID) {
              self.init(unsafeResultMap: ["__typename": "Neighborhood", "id": id])
            }

            public var __typename: String {
              get {
                return resultMap["__typename"]! as! String
              }
              set {
                resultMap.updateValue(newValue, forKey: "__typename")
              }
            }

            public var id: GraphQLID {
              get {
                return resultMap["id"]! as! GraphQLID
              }
              set {
                resultMap.updateValue(newValue, forKey: "id")
              }
            }
          }
        }

        public struct EventImage: GraphQLSelectionSet {
          public static let possibleTypes: [String] = ["EventImage"]

          public static let selections: [GraphQLSelection] = [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("id", type: .nonNull(.scalar(GraphQLID.self))),
            GraphQLField("url", type: .nonNull(.scalar(String.self))),
          ]

          public private(set) var resultMap: ResultMap

          public init(unsafeResultMap: ResultMap) {
            self.resultMap = unsafeResultMap
          }

          public init(id: GraphQLID, url: String) {
            self.init(unsafeResultMap: ["__typename": "EventImage", "id": id, "url": url])
          }

          public var __typename: String {
            get {
              return resultMap["__typename"]! as! String
            }
            set {
              resultMap.updateValue(newValue, forKey: "__typename")
            }
          }

          public var id: GraphQLID {
            get {
              return resultMap["id"]! as! GraphQLID
            }
            set {
              resultMap.updateValue(newValue, forKey: "id")
            }
          }

          public var url: String {
            get {
              return resultMap["url"]! as! String
            }
            set {
              resultMap.updateValue(newValue, forKey: "url")
            }
          }
        }
      }
    }
  }
}

public final class FetchDateRangedEventsQuery: GraphQLQuery {
  /// The raw GraphQL definition of this operation.
  public let operationDefinition: String =
    """
    query FetchDateRangedEvents($start: DateTime, $end: DateTime) {
      events(where: {start_gte: $start, start_lte: $end}) {
        __typename
        id
        title
        description
        start
        end
        creator {
          __typename
          id
          firstName
          lastName
          profileImage
        }
        ticketPrice
        rsvps {
          __typename
          id
          firstName
          lastName
          profileImage
        }
        eventImages {
          __typename
          id
          url
        }
        locations {
          __typename
          id
          streetAddress
          streetAddress2
          city
          state
          zipcode
          latitude
          longitude
        }
        tags {
          __typename
          id
          title
        }
      }
    }
    """

  public let operationName: String = "FetchDateRangedEvents"

  public var start: String?
  public var end: String?

  public init(start: String? = nil, end: String? = nil) {
    self.start = start
    self.end = end
  }

  public var variables: GraphQLMap? {
    return ["start": start, "end": end]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes: [String] = ["Query"]

    public static let selections: [GraphQLSelection] = [
      GraphQLField("events", arguments: ["where": ["start_gte": GraphQLVariable("start"), "start_lte": GraphQLVariable("end")]], type: .list(.nonNull(.object(Event.selections)))),
    ]

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(events: [Event]? = nil) {
      self.init(unsafeResultMap: ["__typename": "Query", "events": events.flatMap { (value: [Event]) -> [ResultMap] in value.map { (value: Event) -> ResultMap in value.resultMap } }])
    }

    public var events: [Event]? {
      get {
        return (resultMap["events"] as? [ResultMap]).flatMap { (value: [ResultMap]) -> [Event] in value.map { (value: ResultMap) -> Event in Event(unsafeResultMap: value) } }
      }
      set {
        resultMap.updateValue(newValue.flatMap { (value: [Event]) -> [ResultMap] in value.map { (value: Event) -> ResultMap in value.resultMap } }, forKey: "events")
      }
    }

    public struct Event: GraphQLSelectionSet {
      public static let possibleTypes: [String] = ["Event"]

      public static let selections: [GraphQLSelection] = [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("id", type: .nonNull(.scalar(GraphQLID.self))),
        GraphQLField("title", type: .nonNull(.scalar(String.self))),
        GraphQLField("description", type: .nonNull(.scalar(String.self))),
        GraphQLField("start", type: .nonNull(.scalar(String.self))),
        GraphQLField("end", type: .nonNull(.scalar(String.self))),
        GraphQLField("creator", type: .object(Creator.selections)),
        GraphQLField("ticketPrice", type: .nonNull(.scalar(Double.self))),
        GraphQLField("rsvps", type: .list(.nonNull(.object(Rsvp.selections)))),
        GraphQLField("eventImages", type: .list(.nonNull(.object(EventImage.selections)))),
        GraphQLField("locations", type: .list(.nonNull(.object(Location.selections)))),
        GraphQLField("tags", type: .list(.nonNull(.object(Tag.selections)))),
      ]

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(id: GraphQLID, title: String, description: String, start: String, end: String, creator: Creator? = nil, ticketPrice: Double, rsvps: [Rsvp]? = nil, eventImages: [EventImage]? = nil, locations: [Location]? = nil, tags: [Tag]? = nil) {
        self.init(unsafeResultMap: ["__typename": "Event", "id": id, "title": title, "description": description, "start": start, "end": end, "creator": creator.flatMap { (value: Creator) -> ResultMap in value.resultMap }, "ticketPrice": ticketPrice, "rsvps": rsvps.flatMap { (value: [Rsvp]) -> [ResultMap] in value.map { (value: Rsvp) -> ResultMap in value.resultMap } }, "eventImages": eventImages.flatMap { (value: [EventImage]) -> [ResultMap] in value.map { (value: EventImage) -> ResultMap in value.resultMap } }, "locations": locations.flatMap { (value: [Location]) -> [ResultMap] in value.map { (value: Location) -> ResultMap in value.resultMap } }, "tags": tags.flatMap { (value: [Tag]) -> [ResultMap] in value.map { (value: Tag) -> ResultMap in value.resultMap } }])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

      public var id: GraphQLID {
        get {
          return resultMap["id"]! as! GraphQLID
        }
        set {
          resultMap.updateValue(newValue, forKey: "id")
        }
      }

      public var title: String {
        get {
          return resultMap["title"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "title")
        }
      }

      public var description: String {
        get {
          return resultMap["description"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "description")
        }
      }

      public var start: String {
        get {
          return resultMap["start"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "start")
        }
      }

      public var end: String {
        get {
          return resultMap["end"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "end")
        }
      }

      public var creator: Creator? {
        get {
          return (resultMap["creator"] as? ResultMap).flatMap { Creator(unsafeResultMap: $0) }
        }
        set {
          resultMap.updateValue(newValue?.resultMap, forKey: "creator")
        }
      }

      public var ticketPrice: Double {
        get {
          return resultMap["ticketPrice"]! as! Double
        }
        set {
          resultMap.updateValue(newValue, forKey: "ticketPrice")
        }
      }

      public var rsvps: [Rsvp]? {
        get {
          return (resultMap["rsvps"] as? [ResultMap]).flatMap { (value: [ResultMap]) -> [Rsvp] in value.map { (value: ResultMap) -> Rsvp in Rsvp(unsafeResultMap: value) } }
        }
        set {
          resultMap.updateValue(newValue.flatMap { (value: [Rsvp]) -> [ResultMap] in value.map { (value: Rsvp) -> ResultMap in value.resultMap } }, forKey: "rsvps")
        }
      }

      public var eventImages: [EventImage]? {
        get {
          return (resultMap["eventImages"] as? [ResultMap]).flatMap { (value: [ResultMap]) -> [EventImage] in value.map { (value: ResultMap) -> EventImage in EventImage(unsafeResultMap: value) } }
        }
        set {
          resultMap.updateValue(newValue.flatMap { (value: [EventImage]) -> [ResultMap] in value.map { (value: EventImage) -> ResultMap in value.resultMap } }, forKey: "eventImages")
        }
      }

      public var locations: [Location]? {
        get {
          return (resultMap["locations"] as? [ResultMap]).flatMap { (value: [ResultMap]) -> [Location] in value.map { (value: ResultMap) -> Location in Location(unsafeResultMap: value) } }
        }
        set {
          resultMap.updateValue(newValue.flatMap { (value: [Location]) -> [ResultMap] in value.map { (value: Location) -> ResultMap in value.resultMap } }, forKey: "locations")
        }
      }

      public var tags: [Tag]? {
        get {
          return (resultMap["tags"] as? [ResultMap]).flatMap { (value: [ResultMap]) -> [Tag] in value.map { (value: ResultMap) -> Tag in Tag(unsafeResultMap: value) } }
        }
        set {
          resultMap.updateValue(newValue.flatMap { (value: [Tag]) -> [ResultMap] in value.map { (value: Tag) -> ResultMap in value.resultMap } }, forKey: "tags")
        }
      }

      public struct Creator: GraphQLSelectionSet {
        public static let possibleTypes: [String] = ["User"]

        public static let selections: [GraphQLSelection] = [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("id", type: .nonNull(.scalar(GraphQLID.self))),
          GraphQLField("firstName", type: .scalar(String.self)),
          GraphQLField("lastName", type: .scalar(String.self)),
          GraphQLField("profileImage", type: .scalar(String.self)),
        ]

        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public init(id: GraphQLID, firstName: String? = nil, lastName: String? = nil, profileImage: String? = nil) {
          self.init(unsafeResultMap: ["__typename": "User", "id": id, "firstName": firstName, "lastName": lastName, "profileImage": profileImage])
        }

        public var __typename: String {
          get {
            return resultMap["__typename"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "__typename")
          }
        }

        public var id: GraphQLID {
          get {
            return resultMap["id"]! as! GraphQLID
          }
          set {
            resultMap.updateValue(newValue, forKey: "id")
          }
        }

        public var firstName: String? {
          get {
            return resultMap["firstName"] as? String
          }
          set {
            resultMap.updateValue(newValue, forKey: "firstName")
          }
        }

        public var lastName: String? {
          get {
            return resultMap["lastName"] as? String
          }
          set {
            resultMap.updateValue(newValue, forKey: "lastName")
          }
        }

        public var profileImage: String? {
          get {
            return resultMap["profileImage"] as? String
          }
          set {
            resultMap.updateValue(newValue, forKey: "profileImage")
          }
        }
      }

      public struct Rsvp: GraphQLSelectionSet {
        public static let possibleTypes: [String] = ["User"]

        public static let selections: [GraphQLSelection] = [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("id", type: .nonNull(.scalar(GraphQLID.self))),
          GraphQLField("firstName", type: .scalar(String.self)),
          GraphQLField("lastName", type: .scalar(String.self)),
          GraphQLField("profileImage", type: .scalar(String.self)),
        ]

        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public init(id: GraphQLID, firstName: String? = nil, lastName: String? = nil, profileImage: String? = nil) {
          self.init(unsafeResultMap: ["__typename": "User", "id": id, "firstName": firstName, "lastName": lastName, "profileImage": profileImage])
        }

        public var __typename: String {
          get {
            return resultMap["__typename"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "__typename")
          }
        }

        public var id: GraphQLID {
          get {
            return resultMap["id"]! as! GraphQLID
          }
          set {
            resultMap.updateValue(newValue, forKey: "id")
          }
        }

        public var firstName: String? {
          get {
            return resultMap["firstName"] as? String
          }
          set {
            resultMap.updateValue(newValue, forKey: "firstName")
          }
        }

        public var lastName: String? {
          get {
            return resultMap["lastName"] as? String
          }
          set {
            resultMap.updateValue(newValue, forKey: "lastName")
          }
        }

        public var profileImage: String? {
          get {
            return resultMap["profileImage"] as? String
          }
          set {
            resultMap.updateValue(newValue, forKey: "profileImage")
          }
        }
      }

      public struct EventImage: GraphQLSelectionSet {
        public static let possibleTypes: [String] = ["EventImage"]

        public static let selections: [GraphQLSelection] = [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("id", type: .nonNull(.scalar(GraphQLID.self))),
          GraphQLField("url", type: .nonNull(.scalar(String.self))),
        ]

        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public init(id: GraphQLID, url: String) {
          self.init(unsafeResultMap: ["__typename": "EventImage", "id": id, "url": url])
        }

        public var __typename: String {
          get {
            return resultMap["__typename"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "__typename")
          }
        }

        public var id: GraphQLID {
          get {
            return resultMap["id"]! as! GraphQLID
          }
          set {
            resultMap.updateValue(newValue, forKey: "id")
          }
        }

        public var url: String {
          get {
            return resultMap["url"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "url")
          }
        }
      }

      public struct Location: GraphQLSelectionSet {
        public static let possibleTypes: [String] = ["Location"]

        public static let selections: [GraphQLSelection] = [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("id", type: .nonNull(.scalar(GraphQLID.self))),
          GraphQLField("streetAddress", type: .nonNull(.scalar(String.self))),
          GraphQLField("streetAddress2", type: .scalar(String.self)),
          GraphQLField("city", type: .nonNull(.scalar(String.self))),
          GraphQLField("state", type: .nonNull(.scalar(String.self))),
          GraphQLField("zipcode", type: .nonNull(.scalar(Int.self))),
          GraphQLField("latitude", type: .scalar(Double.self)),
          GraphQLField("longitude", type: .scalar(Double.self)),
        ]

        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public init(id: GraphQLID, streetAddress: String, streetAddress2: String? = nil, city: String, state: String, zipcode: Int, latitude: Double? = nil, longitude: Double? = nil) {
          self.init(unsafeResultMap: ["__typename": "Location", "id": id, "streetAddress": streetAddress, "streetAddress2": streetAddress2, "city": city, "state": state, "zipcode": zipcode, "latitude": latitude, "longitude": longitude])
        }

        public var __typename: String {
          get {
            return resultMap["__typename"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "__typename")
          }
        }

        public var id: GraphQLID {
          get {
            return resultMap["id"]! as! GraphQLID
          }
          set {
            resultMap.updateValue(newValue, forKey: "id")
          }
        }

        public var streetAddress: String {
          get {
            return resultMap["streetAddress"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "streetAddress")
          }
        }

        public var streetAddress2: String? {
          get {
            return resultMap["streetAddress2"] as? String
          }
          set {
            resultMap.updateValue(newValue, forKey: "streetAddress2")
          }
        }

        public var city: String {
          get {
            return resultMap["city"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "city")
          }
        }

        public var state: String {
          get {
            return resultMap["state"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "state")
          }
        }

        public var zipcode: Int {
          get {
            return resultMap["zipcode"]! as! Int
          }
          set {
            resultMap.updateValue(newValue, forKey: "zipcode")
          }
        }

        public var latitude: Double? {
          get {
            return resultMap["latitude"] as? Double
          }
          set {
            resultMap.updateValue(newValue, forKey: "latitude")
          }
        }

        public var longitude: Double? {
          get {
            return resultMap["longitude"] as? Double
          }
          set {
            resultMap.updateValue(newValue, forKey: "longitude")
          }
        }
      }

      public struct Tag: GraphQLSelectionSet {
        public static let possibleTypes: [String] = ["Tag"]

        public static let selections: [GraphQLSelection] = [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("id", type: .nonNull(.scalar(GraphQLID.self))),
          GraphQLField("title", type: .nonNull(.scalar(String.self))),
        ]

        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public init(id: GraphQLID, title: String) {
          self.init(unsafeResultMap: ["__typename": "Tag", "id": id, "title": title])
        }

        public var __typename: String {
          get {
            return resultMap["__typename"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "__typename")
          }
        }

        public var id: GraphQLID {
          get {
            return resultMap["id"]! as! GraphQLID
          }
          set {
            resultMap.updateValue(newValue, forKey: "id")
          }
        }

        public var title: String {
          get {
            return resultMap["title"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "title")
          }
        }
      }
    }
  }
}

public final class AddProfilePicMutation: GraphQLMutation {
  /// The raw GraphQL definition of this operation.
  public let operationDefinition: String =
    """
    mutation AddProfilePic($image: Upload, $id: ID) {
      updateUser(image: $image, where: {id: $id}) {
        __typename
        id
        profileImage
      }
    }
    """

  public let operationName: String = "AddProfilePic"

  public var image: String?
  public var id: GraphQLID?

  public init(image: String? = nil, id: GraphQLID? = nil) {
    self.image = image
    self.id = id
  }

  public var variables: GraphQLMap? {
    return ["image": image, "id": id]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes: [String] = ["Mutation"]

    public static let selections: [GraphQLSelection] = [
      GraphQLField("updateUser", arguments: ["image": GraphQLVariable("image"), "where": ["id": GraphQLVariable("id")]], type: .nonNull(.object(UpdateUser.selections))),
    ]

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(updateUser: UpdateUser) {
      self.init(unsafeResultMap: ["__typename": "Mutation", "updateUser": updateUser.resultMap])
    }

    public var updateUser: UpdateUser {
      get {
        return UpdateUser(unsafeResultMap: resultMap["updateUser"]! as! ResultMap)
      }
      set {
        resultMap.updateValue(newValue.resultMap, forKey: "updateUser")
      }
    }

    public struct UpdateUser: GraphQLSelectionSet {
      public static let possibleTypes: [String] = ["User"]

      public static let selections: [GraphQLSelection] = [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("id", type: .nonNull(.scalar(GraphQLID.self))),
        GraphQLField("profileImage", type: .scalar(String.self)),
      ]

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(id: GraphQLID, profileImage: String? = nil) {
        self.init(unsafeResultMap: ["__typename": "User", "id": id, "profileImage": profileImage])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

      public var id: GraphQLID {
        get {
          return resultMap["id"]! as! GraphQLID
        }
        set {
          resultMap.updateValue(newValue, forKey: "id")
        }
      }

      public var profileImage: String? {
        get {
          return resultMap["profileImage"] as? String
        }
        set {
          resultMap.updateValue(newValue, forKey: "profileImage")
        }
      }
    }
  }
}

public final class FetchUserIdQuery: GraphQLQuery {
  /// The raw GraphQL definition of this operation.
  public let operationDefinition: String =
    """
    query fetchUserID($oktaId: String) {
      user(where: {oktaId: $oktaId}) {
        __typename
        id
        firstName
        lastName
        profileImage
        saved {
          __typename
          id
          title
          description
          start
          end
          ticketPrice
          locations {
            __typename
            id
            name
            streetAddress
            streetAddress2
            city
            state
            zipcode
            latitude
            longitude
          }
          eventImages {
            __typename
            id
            url
          }
          creator {
            __typename
            id
            firstName
            lastName
            profileImage
          }
        }
        rsvps {
          __typename
          id
          title
          description
          start
          end
          ticketPrice
          locations {
            __typename
            id
            name
            streetAddress
            streetAddress2
            city
            state
            zipcode
            latitude
            longitude
          }
          eventImages {
            __typename
            id
            url
          }
          creator {
            __typename
            id
            firstName
            lastName
            profileImage
          }
        }
        createdEvents {
          __typename
          id
          title
          description
          start
          end
          ticketPrice
          locations {
            __typename
            id
            name
            streetAddress
            streetAddress2
            city
            state
            zipcode
            latitude
            longitude
          }
          eventImages {
            __typename
            id
            url
          }
          creator {
            __typename
            id
            firstName
            lastName
            profileImage
          }
        }
      }
    }
    """

  public let operationName: String = "fetchUserID"

  public var oktaId: String?

  public init(oktaId: String? = nil) {
    self.oktaId = oktaId
  }

  public var variables: GraphQLMap? {
    return ["oktaId": oktaId]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes: [String] = ["Query"]

    public static let selections: [GraphQLSelection] = [
      GraphQLField("user", arguments: ["where": ["oktaId": GraphQLVariable("oktaId")]], type: .nonNull(.object(User.selections))),
    ]

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(user: User) {
      self.init(unsafeResultMap: ["__typename": "Query", "user": user.resultMap])
    }

    public var user: User {
      get {
        return User(unsafeResultMap: resultMap["user"]! as! ResultMap)
      }
      set {
        resultMap.updateValue(newValue.resultMap, forKey: "user")
      }
    }

    public struct User: GraphQLSelectionSet {
      public static let possibleTypes: [String] = ["User"]

      public static let selections: [GraphQLSelection] = [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("id", type: .nonNull(.scalar(GraphQLID.self))),
        GraphQLField("firstName", type: .scalar(String.self)),
        GraphQLField("lastName", type: .scalar(String.self)),
        GraphQLField("profileImage", type: .scalar(String.self)),
        GraphQLField("saved", type: .list(.nonNull(.object(Saved.selections)))),
        GraphQLField("rsvps", type: .list(.nonNull(.object(Rsvp.selections)))),
        GraphQLField("createdEvents", type: .list(.nonNull(.object(CreatedEvent.selections)))),
      ]

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(id: GraphQLID, firstName: String? = nil, lastName: String? = nil, profileImage: String? = nil, saved: [Saved]? = nil, rsvps: [Rsvp]? = nil, createdEvents: [CreatedEvent]? = nil) {
        self.init(unsafeResultMap: ["__typename": "User", "id": id, "firstName": firstName, "lastName": lastName, "profileImage": profileImage, "saved": saved.flatMap { (value: [Saved]) -> [ResultMap] in value.map { (value: Saved) -> ResultMap in value.resultMap } }, "rsvps": rsvps.flatMap { (value: [Rsvp]) -> [ResultMap] in value.map { (value: Rsvp) -> ResultMap in value.resultMap } }, "createdEvents": createdEvents.flatMap { (value: [CreatedEvent]) -> [ResultMap] in value.map { (value: CreatedEvent) -> ResultMap in value.resultMap } }])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

      public var id: GraphQLID {
        get {
          return resultMap["id"]! as! GraphQLID
        }
        set {
          resultMap.updateValue(newValue, forKey: "id")
        }
      }

      public var firstName: String? {
        get {
          return resultMap["firstName"] as? String
        }
        set {
          resultMap.updateValue(newValue, forKey: "firstName")
        }
      }

      public var lastName: String? {
        get {
          return resultMap["lastName"] as? String
        }
        set {
          resultMap.updateValue(newValue, forKey: "lastName")
        }
      }

      public var profileImage: String? {
        get {
          return resultMap["profileImage"] as? String
        }
        set {
          resultMap.updateValue(newValue, forKey: "profileImage")
        }
      }

      public var saved: [Saved]? {
        get {
          return (resultMap["saved"] as? [ResultMap]).flatMap { (value: [ResultMap]) -> [Saved] in value.map { (value: ResultMap) -> Saved in Saved(unsafeResultMap: value) } }
        }
        set {
          resultMap.updateValue(newValue.flatMap { (value: [Saved]) -> [ResultMap] in value.map { (value: Saved) -> ResultMap in value.resultMap } }, forKey: "saved")
        }
      }

      public var rsvps: [Rsvp]? {
        get {
          return (resultMap["rsvps"] as? [ResultMap]).flatMap { (value: [ResultMap]) -> [Rsvp] in value.map { (value: ResultMap) -> Rsvp in Rsvp(unsafeResultMap: value) } }
        }
        set {
          resultMap.updateValue(newValue.flatMap { (value: [Rsvp]) -> [ResultMap] in value.map { (value: Rsvp) -> ResultMap in value.resultMap } }, forKey: "rsvps")
        }
      }

      public var createdEvents: [CreatedEvent]? {
        get {
          return (resultMap["createdEvents"] as? [ResultMap]).flatMap { (value: [ResultMap]) -> [CreatedEvent] in value.map { (value: ResultMap) -> CreatedEvent in CreatedEvent(unsafeResultMap: value) } }
        }
        set {
          resultMap.updateValue(newValue.flatMap { (value: [CreatedEvent]) -> [ResultMap] in value.map { (value: CreatedEvent) -> ResultMap in value.resultMap } }, forKey: "createdEvents")
        }
      }

      public struct Saved: GraphQLSelectionSet {
        public static let possibleTypes: [String] = ["Event"]

        public static let selections: [GraphQLSelection] = [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("id", type: .nonNull(.scalar(GraphQLID.self))),
          GraphQLField("title", type: .nonNull(.scalar(String.self))),
          GraphQLField("description", type: .nonNull(.scalar(String.self))),
          GraphQLField("start", type: .nonNull(.scalar(String.self))),
          GraphQLField("end", type: .nonNull(.scalar(String.self))),
          GraphQLField("ticketPrice", type: .nonNull(.scalar(Double.self))),
          GraphQLField("locations", type: .list(.nonNull(.object(Location.selections)))),
          GraphQLField("eventImages", type: .list(.nonNull(.object(EventImage.selections)))),
          GraphQLField("creator", type: .object(Creator.selections)),
        ]

        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public init(id: GraphQLID, title: String, description: String, start: String, end: String, ticketPrice: Double, locations: [Location]? = nil, eventImages: [EventImage]? = nil, creator: Creator? = nil) {
          self.init(unsafeResultMap: ["__typename": "Event", "id": id, "title": title, "description": description, "start": start, "end": end, "ticketPrice": ticketPrice, "locations": locations.flatMap { (value: [Location]) -> [ResultMap] in value.map { (value: Location) -> ResultMap in value.resultMap } }, "eventImages": eventImages.flatMap { (value: [EventImage]) -> [ResultMap] in value.map { (value: EventImage) -> ResultMap in value.resultMap } }, "creator": creator.flatMap { (value: Creator) -> ResultMap in value.resultMap }])
        }

        public var __typename: String {
          get {
            return resultMap["__typename"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "__typename")
          }
        }

        public var id: GraphQLID {
          get {
            return resultMap["id"]! as! GraphQLID
          }
          set {
            resultMap.updateValue(newValue, forKey: "id")
          }
        }

        public var title: String {
          get {
            return resultMap["title"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "title")
          }
        }

        public var description: String {
          get {
            return resultMap["description"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "description")
          }
        }

        public var start: String {
          get {
            return resultMap["start"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "start")
          }
        }

        public var end: String {
          get {
            return resultMap["end"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "end")
          }
        }

        public var ticketPrice: Double {
          get {
            return resultMap["ticketPrice"]! as! Double
          }
          set {
            resultMap.updateValue(newValue, forKey: "ticketPrice")
          }
        }

        public var locations: [Location]? {
          get {
            return (resultMap["locations"] as? [ResultMap]).flatMap { (value: [ResultMap]) -> [Location] in value.map { (value: ResultMap) -> Location in Location(unsafeResultMap: value) } }
          }
          set {
            resultMap.updateValue(newValue.flatMap { (value: [Location]) -> [ResultMap] in value.map { (value: Location) -> ResultMap in value.resultMap } }, forKey: "locations")
          }
        }

        public var eventImages: [EventImage]? {
          get {
            return (resultMap["eventImages"] as? [ResultMap]).flatMap { (value: [ResultMap]) -> [EventImage] in value.map { (value: ResultMap) -> EventImage in EventImage(unsafeResultMap: value) } }
          }
          set {
            resultMap.updateValue(newValue.flatMap { (value: [EventImage]) -> [ResultMap] in value.map { (value: EventImage) -> ResultMap in value.resultMap } }, forKey: "eventImages")
          }
        }

        public var creator: Creator? {
          get {
            return (resultMap["creator"] as? ResultMap).flatMap { Creator(unsafeResultMap: $0) }
          }
          set {
            resultMap.updateValue(newValue?.resultMap, forKey: "creator")
          }
        }

        public struct Location: GraphQLSelectionSet {
          public static let possibleTypes: [String] = ["Location"]

          public static let selections: [GraphQLSelection] = [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("id", type: .nonNull(.scalar(GraphQLID.self))),
            GraphQLField("name", type: .nonNull(.scalar(String.self))),
            GraphQLField("streetAddress", type: .nonNull(.scalar(String.self))),
            GraphQLField("streetAddress2", type: .scalar(String.self)),
            GraphQLField("city", type: .nonNull(.scalar(String.self))),
            GraphQLField("state", type: .nonNull(.scalar(String.self))),
            GraphQLField("zipcode", type: .nonNull(.scalar(Int.self))),
            GraphQLField("latitude", type: .scalar(Double.self)),
            GraphQLField("longitude", type: .scalar(Double.self)),
          ]

          public private(set) var resultMap: ResultMap

          public init(unsafeResultMap: ResultMap) {
            self.resultMap = unsafeResultMap
          }

          public init(id: GraphQLID, name: String, streetAddress: String, streetAddress2: String? = nil, city: String, state: String, zipcode: Int, latitude: Double? = nil, longitude: Double? = nil) {
            self.init(unsafeResultMap: ["__typename": "Location", "id": id, "name": name, "streetAddress": streetAddress, "streetAddress2": streetAddress2, "city": city, "state": state, "zipcode": zipcode, "latitude": latitude, "longitude": longitude])
          }

          public var __typename: String {
            get {
              return resultMap["__typename"]! as! String
            }
            set {
              resultMap.updateValue(newValue, forKey: "__typename")
            }
          }

          public var id: GraphQLID {
            get {
              return resultMap["id"]! as! GraphQLID
            }
            set {
              resultMap.updateValue(newValue, forKey: "id")
            }
          }

          public var name: String {
            get {
              return resultMap["name"]! as! String
            }
            set {
              resultMap.updateValue(newValue, forKey: "name")
            }
          }

          public var streetAddress: String {
            get {
              return resultMap["streetAddress"]! as! String
            }
            set {
              resultMap.updateValue(newValue, forKey: "streetAddress")
            }
          }

          public var streetAddress2: String? {
            get {
              return resultMap["streetAddress2"] as? String
            }
            set {
              resultMap.updateValue(newValue, forKey: "streetAddress2")
            }
          }

          public var city: String {
            get {
              return resultMap["city"]! as! String
            }
            set {
              resultMap.updateValue(newValue, forKey: "city")
            }
          }

          public var state: String {
            get {
              return resultMap["state"]! as! String
            }
            set {
              resultMap.updateValue(newValue, forKey: "state")
            }
          }

          public var zipcode: Int {
            get {
              return resultMap["zipcode"]! as! Int
            }
            set {
              resultMap.updateValue(newValue, forKey: "zipcode")
            }
          }

          public var latitude: Double? {
            get {
              return resultMap["latitude"] as? Double
            }
            set {
              resultMap.updateValue(newValue, forKey: "latitude")
            }
          }

          public var longitude: Double? {
            get {
              return resultMap["longitude"] as? Double
            }
            set {
              resultMap.updateValue(newValue, forKey: "longitude")
            }
          }
        }

        public struct EventImage: GraphQLSelectionSet {
          public static let possibleTypes: [String] = ["EventImage"]

          public static let selections: [GraphQLSelection] = [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("id", type: .nonNull(.scalar(GraphQLID.self))),
            GraphQLField("url", type: .nonNull(.scalar(String.self))),
          ]

          public private(set) var resultMap: ResultMap

          public init(unsafeResultMap: ResultMap) {
            self.resultMap = unsafeResultMap
          }

          public init(id: GraphQLID, url: String) {
            self.init(unsafeResultMap: ["__typename": "EventImage", "id": id, "url": url])
          }

          public var __typename: String {
            get {
              return resultMap["__typename"]! as! String
            }
            set {
              resultMap.updateValue(newValue, forKey: "__typename")
            }
          }

          public var id: GraphQLID {
            get {
              return resultMap["id"]! as! GraphQLID
            }
            set {
              resultMap.updateValue(newValue, forKey: "id")
            }
          }

          public var url: String {
            get {
              return resultMap["url"]! as! String
            }
            set {
              resultMap.updateValue(newValue, forKey: "url")
            }
          }
        }

        public struct Creator: GraphQLSelectionSet {
          public static let possibleTypes: [String] = ["User"]

          public static let selections: [GraphQLSelection] = [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("id", type: .nonNull(.scalar(GraphQLID.self))),
            GraphQLField("firstName", type: .scalar(String.self)),
            GraphQLField("lastName", type: .scalar(String.self)),
            GraphQLField("profileImage", type: .scalar(String.self)),
          ]

          public private(set) var resultMap: ResultMap

          public init(unsafeResultMap: ResultMap) {
            self.resultMap = unsafeResultMap
          }

          public init(id: GraphQLID, firstName: String? = nil, lastName: String? = nil, profileImage: String? = nil) {
            self.init(unsafeResultMap: ["__typename": "User", "id": id, "firstName": firstName, "lastName": lastName, "profileImage": profileImage])
          }

          public var __typename: String {
            get {
              return resultMap["__typename"]! as! String
            }
            set {
              resultMap.updateValue(newValue, forKey: "__typename")
            }
          }

          public var id: GraphQLID {
            get {
              return resultMap["id"]! as! GraphQLID
            }
            set {
              resultMap.updateValue(newValue, forKey: "id")
            }
          }

          public var firstName: String? {
            get {
              return resultMap["firstName"] as? String
            }
            set {
              resultMap.updateValue(newValue, forKey: "firstName")
            }
          }

          public var lastName: String? {
            get {
              return resultMap["lastName"] as? String
            }
            set {
              resultMap.updateValue(newValue, forKey: "lastName")
            }
          }

          public var profileImage: String? {
            get {
              return resultMap["profileImage"] as? String
            }
            set {
              resultMap.updateValue(newValue, forKey: "profileImage")
            }
          }
        }
      }

      public struct Rsvp: GraphQLSelectionSet {
        public static let possibleTypes: [String] = ["Event"]

        public static let selections: [GraphQLSelection] = [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("id", type: .nonNull(.scalar(GraphQLID.self))),
          GraphQLField("title", type: .nonNull(.scalar(String.self))),
          GraphQLField("description", type: .nonNull(.scalar(String.self))),
          GraphQLField("start", type: .nonNull(.scalar(String.self))),
          GraphQLField("end", type: .nonNull(.scalar(String.self))),
          GraphQLField("ticketPrice", type: .nonNull(.scalar(Double.self))),
          GraphQLField("locations", type: .list(.nonNull(.object(Location.selections)))),
          GraphQLField("eventImages", type: .list(.nonNull(.object(EventImage.selections)))),
          GraphQLField("creator", type: .object(Creator.selections)),
        ]

        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public init(id: GraphQLID, title: String, description: String, start: String, end: String, ticketPrice: Double, locations: [Location]? = nil, eventImages: [EventImage]? = nil, creator: Creator? = nil) {
          self.init(unsafeResultMap: ["__typename": "Event", "id": id, "title": title, "description": description, "start": start, "end": end, "ticketPrice": ticketPrice, "locations": locations.flatMap { (value: [Location]) -> [ResultMap] in value.map { (value: Location) -> ResultMap in value.resultMap } }, "eventImages": eventImages.flatMap { (value: [EventImage]) -> [ResultMap] in value.map { (value: EventImage) -> ResultMap in value.resultMap } }, "creator": creator.flatMap { (value: Creator) -> ResultMap in value.resultMap }])
        }

        public var __typename: String {
          get {
            return resultMap["__typename"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "__typename")
          }
        }

        public var id: GraphQLID {
          get {
            return resultMap["id"]! as! GraphQLID
          }
          set {
            resultMap.updateValue(newValue, forKey: "id")
          }
        }

        public var title: String {
          get {
            return resultMap["title"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "title")
          }
        }

        public var description: String {
          get {
            return resultMap["description"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "description")
          }
        }

        public var start: String {
          get {
            return resultMap["start"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "start")
          }
        }

        public var end: String {
          get {
            return resultMap["end"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "end")
          }
        }

        public var ticketPrice: Double {
          get {
            return resultMap["ticketPrice"]! as! Double
          }
          set {
            resultMap.updateValue(newValue, forKey: "ticketPrice")
          }
        }

        public var locations: [Location]? {
          get {
            return (resultMap["locations"] as? [ResultMap]).flatMap { (value: [ResultMap]) -> [Location] in value.map { (value: ResultMap) -> Location in Location(unsafeResultMap: value) } }
          }
          set {
            resultMap.updateValue(newValue.flatMap { (value: [Location]) -> [ResultMap] in value.map { (value: Location) -> ResultMap in value.resultMap } }, forKey: "locations")
          }
        }

        public var eventImages: [EventImage]? {
          get {
            return (resultMap["eventImages"] as? [ResultMap]).flatMap { (value: [ResultMap]) -> [EventImage] in value.map { (value: ResultMap) -> EventImage in EventImage(unsafeResultMap: value) } }
          }
          set {
            resultMap.updateValue(newValue.flatMap { (value: [EventImage]) -> [ResultMap] in value.map { (value: EventImage) -> ResultMap in value.resultMap } }, forKey: "eventImages")
          }
        }

        public var creator: Creator? {
          get {
            return (resultMap["creator"] as? ResultMap).flatMap { Creator(unsafeResultMap: $0) }
          }
          set {
            resultMap.updateValue(newValue?.resultMap, forKey: "creator")
          }
        }

        public struct Location: GraphQLSelectionSet {
          public static let possibleTypes: [String] = ["Location"]

          public static let selections: [GraphQLSelection] = [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("id", type: .nonNull(.scalar(GraphQLID.self))),
            GraphQLField("name", type: .nonNull(.scalar(String.self))),
            GraphQLField("streetAddress", type: .nonNull(.scalar(String.self))),
            GraphQLField("streetAddress2", type: .scalar(String.self)),
            GraphQLField("city", type: .nonNull(.scalar(String.self))),
            GraphQLField("state", type: .nonNull(.scalar(String.self))),
            GraphQLField("zipcode", type: .nonNull(.scalar(Int.self))),
            GraphQLField("latitude", type: .scalar(Double.self)),
            GraphQLField("longitude", type: .scalar(Double.self)),
          ]

          public private(set) var resultMap: ResultMap

          public init(unsafeResultMap: ResultMap) {
            self.resultMap = unsafeResultMap
          }

          public init(id: GraphQLID, name: String, streetAddress: String, streetAddress2: String? = nil, city: String, state: String, zipcode: Int, latitude: Double? = nil, longitude: Double? = nil) {
            self.init(unsafeResultMap: ["__typename": "Location", "id": id, "name": name, "streetAddress": streetAddress, "streetAddress2": streetAddress2, "city": city, "state": state, "zipcode": zipcode, "latitude": latitude, "longitude": longitude])
          }

          public var __typename: String {
            get {
              return resultMap["__typename"]! as! String
            }
            set {
              resultMap.updateValue(newValue, forKey: "__typename")
            }
          }

          public var id: GraphQLID {
            get {
              return resultMap["id"]! as! GraphQLID
            }
            set {
              resultMap.updateValue(newValue, forKey: "id")
            }
          }

          public var name: String {
            get {
              return resultMap["name"]! as! String
            }
            set {
              resultMap.updateValue(newValue, forKey: "name")
            }
          }

          public var streetAddress: String {
            get {
              return resultMap["streetAddress"]! as! String
            }
            set {
              resultMap.updateValue(newValue, forKey: "streetAddress")
            }
          }

          public var streetAddress2: String? {
            get {
              return resultMap["streetAddress2"] as? String
            }
            set {
              resultMap.updateValue(newValue, forKey: "streetAddress2")
            }
          }

          public var city: String {
            get {
              return resultMap["city"]! as! String
            }
            set {
              resultMap.updateValue(newValue, forKey: "city")
            }
          }

          public var state: String {
            get {
              return resultMap["state"]! as! String
            }
            set {
              resultMap.updateValue(newValue, forKey: "state")
            }
          }

          public var zipcode: Int {
            get {
              return resultMap["zipcode"]! as! Int
            }
            set {
              resultMap.updateValue(newValue, forKey: "zipcode")
            }
          }

          public var latitude: Double? {
            get {
              return resultMap["latitude"] as? Double
            }
            set {
              resultMap.updateValue(newValue, forKey: "latitude")
            }
          }

          public var longitude: Double? {
            get {
              return resultMap["longitude"] as? Double
            }
            set {
              resultMap.updateValue(newValue, forKey: "longitude")
            }
          }
        }

        public struct EventImage: GraphQLSelectionSet {
          public static let possibleTypes: [String] = ["EventImage"]

          public static let selections: [GraphQLSelection] = [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("id", type: .nonNull(.scalar(GraphQLID.self))),
            GraphQLField("url", type: .nonNull(.scalar(String.self))),
          ]

          public private(set) var resultMap: ResultMap

          public init(unsafeResultMap: ResultMap) {
            self.resultMap = unsafeResultMap
          }

          public init(id: GraphQLID, url: String) {
            self.init(unsafeResultMap: ["__typename": "EventImage", "id": id, "url": url])
          }

          public var __typename: String {
            get {
              return resultMap["__typename"]! as! String
            }
            set {
              resultMap.updateValue(newValue, forKey: "__typename")
            }
          }

          public var id: GraphQLID {
            get {
              return resultMap["id"]! as! GraphQLID
            }
            set {
              resultMap.updateValue(newValue, forKey: "id")
            }
          }

          public var url: String {
            get {
              return resultMap["url"]! as! String
            }
            set {
              resultMap.updateValue(newValue, forKey: "url")
            }
          }
        }

        public struct Creator: GraphQLSelectionSet {
          public static let possibleTypes: [String] = ["User"]

          public static let selections: [GraphQLSelection] = [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("id", type: .nonNull(.scalar(GraphQLID.self))),
            GraphQLField("firstName", type: .scalar(String.self)),
            GraphQLField("lastName", type: .scalar(String.self)),
            GraphQLField("profileImage", type: .scalar(String.self)),
          ]

          public private(set) var resultMap: ResultMap

          public init(unsafeResultMap: ResultMap) {
            self.resultMap = unsafeResultMap
          }

          public init(id: GraphQLID, firstName: String? = nil, lastName: String? = nil, profileImage: String? = nil) {
            self.init(unsafeResultMap: ["__typename": "User", "id": id, "firstName": firstName, "lastName": lastName, "profileImage": profileImage])
          }

          public var __typename: String {
            get {
              return resultMap["__typename"]! as! String
            }
            set {
              resultMap.updateValue(newValue, forKey: "__typename")
            }
          }

          public var id: GraphQLID {
            get {
              return resultMap["id"]! as! GraphQLID
            }
            set {
              resultMap.updateValue(newValue, forKey: "id")
            }
          }

          public var firstName: String? {
            get {
              return resultMap["firstName"] as? String
            }
            set {
              resultMap.updateValue(newValue, forKey: "firstName")
            }
          }

          public var lastName: String? {
            get {
              return resultMap["lastName"] as? String
            }
            set {
              resultMap.updateValue(newValue, forKey: "lastName")
            }
          }

          public var profileImage: String? {
            get {
              return resultMap["profileImage"] as? String
            }
            set {
              resultMap.updateValue(newValue, forKey: "profileImage")
            }
          }
        }
      }

      public struct CreatedEvent: GraphQLSelectionSet {
        public static let possibleTypes: [String] = ["Event"]

        public static let selections: [GraphQLSelection] = [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("id", type: .nonNull(.scalar(GraphQLID.self))),
          GraphQLField("title", type: .nonNull(.scalar(String.self))),
          GraphQLField("description", type: .nonNull(.scalar(String.self))),
          GraphQLField("start", type: .nonNull(.scalar(String.self))),
          GraphQLField("end", type: .nonNull(.scalar(String.self))),
          GraphQLField("ticketPrice", type: .nonNull(.scalar(Double.self))),
          GraphQLField("locations", type: .list(.nonNull(.object(Location.selections)))),
          GraphQLField("eventImages", type: .list(.nonNull(.object(EventImage.selections)))),
          GraphQLField("creator", type: .object(Creator.selections)),
        ]

        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public init(id: GraphQLID, title: String, description: String, start: String, end: String, ticketPrice: Double, locations: [Location]? = nil, eventImages: [EventImage]? = nil, creator: Creator? = nil) {
          self.init(unsafeResultMap: ["__typename": "Event", "id": id, "title": title, "description": description, "start": start, "end": end, "ticketPrice": ticketPrice, "locations": locations.flatMap { (value: [Location]) -> [ResultMap] in value.map { (value: Location) -> ResultMap in value.resultMap } }, "eventImages": eventImages.flatMap { (value: [EventImage]) -> [ResultMap] in value.map { (value: EventImage) -> ResultMap in value.resultMap } }, "creator": creator.flatMap { (value: Creator) -> ResultMap in value.resultMap }])
        }

        public var __typename: String {
          get {
            return resultMap["__typename"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "__typename")
          }
        }

        public var id: GraphQLID {
          get {
            return resultMap["id"]! as! GraphQLID
          }
          set {
            resultMap.updateValue(newValue, forKey: "id")
          }
        }

        public var title: String {
          get {
            return resultMap["title"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "title")
          }
        }

        public var description: String {
          get {
            return resultMap["description"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "description")
          }
        }

        public var start: String {
          get {
            return resultMap["start"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "start")
          }
        }

        public var end: String {
          get {
            return resultMap["end"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "end")
          }
        }

        public var ticketPrice: Double {
          get {
            return resultMap["ticketPrice"]! as! Double
          }
          set {
            resultMap.updateValue(newValue, forKey: "ticketPrice")
          }
        }

        public var locations: [Location]? {
          get {
            return (resultMap["locations"] as? [ResultMap]).flatMap { (value: [ResultMap]) -> [Location] in value.map { (value: ResultMap) -> Location in Location(unsafeResultMap: value) } }
          }
          set {
            resultMap.updateValue(newValue.flatMap { (value: [Location]) -> [ResultMap] in value.map { (value: Location) -> ResultMap in value.resultMap } }, forKey: "locations")
          }
        }

        public var eventImages: [EventImage]? {
          get {
            return (resultMap["eventImages"] as? [ResultMap]).flatMap { (value: [ResultMap]) -> [EventImage] in value.map { (value: ResultMap) -> EventImage in EventImage(unsafeResultMap: value) } }
          }
          set {
            resultMap.updateValue(newValue.flatMap { (value: [EventImage]) -> [ResultMap] in value.map { (value: EventImage) -> ResultMap in value.resultMap } }, forKey: "eventImages")
          }
        }

        public var creator: Creator? {
          get {
            return (resultMap["creator"] as? ResultMap).flatMap { Creator(unsafeResultMap: $0) }
          }
          set {
            resultMap.updateValue(newValue?.resultMap, forKey: "creator")
          }
        }

        public struct Location: GraphQLSelectionSet {
          public static let possibleTypes: [String] = ["Location"]

          public static let selections: [GraphQLSelection] = [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("id", type: .nonNull(.scalar(GraphQLID.self))),
            GraphQLField("name", type: .nonNull(.scalar(String.self))),
            GraphQLField("streetAddress", type: .nonNull(.scalar(String.self))),
            GraphQLField("streetAddress2", type: .scalar(String.self)),
            GraphQLField("city", type: .nonNull(.scalar(String.self))),
            GraphQLField("state", type: .nonNull(.scalar(String.self))),
            GraphQLField("zipcode", type: .nonNull(.scalar(Int.self))),
            GraphQLField("latitude", type: .scalar(Double.self)),
            GraphQLField("longitude", type: .scalar(Double.self)),
          ]

          public private(set) var resultMap: ResultMap

          public init(unsafeResultMap: ResultMap) {
            self.resultMap = unsafeResultMap
          }

          public init(id: GraphQLID, name: String, streetAddress: String, streetAddress2: String? = nil, city: String, state: String, zipcode: Int, latitude: Double? = nil, longitude: Double? = nil) {
            self.init(unsafeResultMap: ["__typename": "Location", "id": id, "name": name, "streetAddress": streetAddress, "streetAddress2": streetAddress2, "city": city, "state": state, "zipcode": zipcode, "latitude": latitude, "longitude": longitude])
          }

          public var __typename: String {
            get {
              return resultMap["__typename"]! as! String
            }
            set {
              resultMap.updateValue(newValue, forKey: "__typename")
            }
          }

          public var id: GraphQLID {
            get {
              return resultMap["id"]! as! GraphQLID
            }
            set {
              resultMap.updateValue(newValue, forKey: "id")
            }
          }

          public var name: String {
            get {
              return resultMap["name"]! as! String
            }
            set {
              resultMap.updateValue(newValue, forKey: "name")
            }
          }

          public var streetAddress: String {
            get {
              return resultMap["streetAddress"]! as! String
            }
            set {
              resultMap.updateValue(newValue, forKey: "streetAddress")
            }
          }

          public var streetAddress2: String? {
            get {
              return resultMap["streetAddress2"] as? String
            }
            set {
              resultMap.updateValue(newValue, forKey: "streetAddress2")
            }
          }

          public var city: String {
            get {
              return resultMap["city"]! as! String
            }
            set {
              resultMap.updateValue(newValue, forKey: "city")
            }
          }

          public var state: String {
            get {
              return resultMap["state"]! as! String
            }
            set {
              resultMap.updateValue(newValue, forKey: "state")
            }
          }

          public var zipcode: Int {
            get {
              return resultMap["zipcode"]! as! Int
            }
            set {
              resultMap.updateValue(newValue, forKey: "zipcode")
            }
          }

          public var latitude: Double? {
            get {
              return resultMap["latitude"] as? Double
            }
            set {
              resultMap.updateValue(newValue, forKey: "latitude")
            }
          }

          public var longitude: Double? {
            get {
              return resultMap["longitude"] as? Double
            }
            set {
              resultMap.updateValue(newValue, forKey: "longitude")
            }
          }
        }

        public struct EventImage: GraphQLSelectionSet {
          public static let possibleTypes: [String] = ["EventImage"]

          public static let selections: [GraphQLSelection] = [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("id", type: .nonNull(.scalar(GraphQLID.self))),
            GraphQLField("url", type: .nonNull(.scalar(String.self))),
          ]

          public private(set) var resultMap: ResultMap

          public init(unsafeResultMap: ResultMap) {
            self.resultMap = unsafeResultMap
          }

          public init(id: GraphQLID, url: String) {
            self.init(unsafeResultMap: ["__typename": "EventImage", "id": id, "url": url])
          }

          public var __typename: String {
            get {
              return resultMap["__typename"]! as! String
            }
            set {
              resultMap.updateValue(newValue, forKey: "__typename")
            }
          }

          public var id: GraphQLID {
            get {
              return resultMap["id"]! as! GraphQLID
            }
            set {
              resultMap.updateValue(newValue, forKey: "id")
            }
          }

          public var url: String {
            get {
              return resultMap["url"]! as! String
            }
            set {
              resultMap.updateValue(newValue, forKey: "url")
            }
          }
        }

        public struct Creator: GraphQLSelectionSet {
          public static let possibleTypes: [String] = ["User"]

          public static let selections: [GraphQLSelection] = [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("id", type: .nonNull(.scalar(GraphQLID.self))),
            GraphQLField("firstName", type: .scalar(String.self)),
            GraphQLField("lastName", type: .scalar(String.self)),
            GraphQLField("profileImage", type: .scalar(String.self)),
          ]

          public private(set) var resultMap: ResultMap

          public init(unsafeResultMap: ResultMap) {
            self.resultMap = unsafeResultMap
          }

          public init(id: GraphQLID, firstName: String? = nil, lastName: String? = nil, profileImage: String? = nil) {
            self.init(unsafeResultMap: ["__typename": "User", "id": id, "firstName": firstName, "lastName": lastName, "profileImage": profileImage])
          }

          public var __typename: String {
            get {
              return resultMap["__typename"]! as! String
            }
            set {
              resultMap.updateValue(newValue, forKey: "__typename")
            }
          }

          public var id: GraphQLID {
            get {
              return resultMap["id"]! as! GraphQLID
            }
            set {
              resultMap.updateValue(newValue, forKey: "id")
            }
          }

          public var firstName: String? {
            get {
              return resultMap["firstName"] as? String
            }
            set {
              resultMap.updateValue(newValue, forKey: "firstName")
            }
          }

          public var lastName: String? {
            get {
              return resultMap["lastName"] as? String
            }
            set {
              resultMap.updateValue(newValue, forKey: "lastName")
            }
          }

          public var profileImage: String? {
            get {
              return resultMap["profileImage"] as? String
            }
            set {
              resultMap.updateValue(newValue, forKey: "profileImage")
            }
          }
        }
      }
    }
  }
}

public final class UpdateUserInfoMutation: GraphQLMutation {
  /// The raw GraphQL definition of this operation.
  public let operationDefinition: String =
    """
    mutation UpdateUserInfo($profileImage: String, $firstName: String, $lastName: String, $id: ID!) {
      updateUser(data: {profileImage: $profileImage, firstName: $firstName, lastName: $lastName}, where: {id: $id}) {
        __typename
        id
        profileImage
        firstName
        lastName
      }
    }
    """

  public let operationName: String = "UpdateUserInfo"

  public var profileImage: String?
  public var firstName: String?
  public var lastName: String?
  public var id: GraphQLID

  public init(profileImage: String? = nil, firstName: String? = nil, lastName: String? = nil, id: GraphQLID) {
    self.profileImage = profileImage
    self.firstName = firstName
    self.lastName = lastName
    self.id = id
  }

  public var variables: GraphQLMap? {
    return ["profileImage": profileImage, "firstName": firstName, "lastName": lastName, "id": id]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes: [String] = ["Mutation"]

    public static let selections: [GraphQLSelection] = [
      GraphQLField("updateUser", arguments: ["data": ["profileImage": GraphQLVariable("profileImage"), "firstName": GraphQLVariable("firstName"), "lastName": GraphQLVariable("lastName")], "where": ["id": GraphQLVariable("id")]], type: .nonNull(.object(UpdateUser.selections))),
    ]

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(updateUser: UpdateUser) {
      self.init(unsafeResultMap: ["__typename": "Mutation", "updateUser": updateUser.resultMap])
    }

    public var updateUser: UpdateUser {
      get {
        return UpdateUser(unsafeResultMap: resultMap["updateUser"]! as! ResultMap)
      }
      set {
        resultMap.updateValue(newValue.resultMap, forKey: "updateUser")
      }
    }

    public struct UpdateUser: GraphQLSelectionSet {
      public static let possibleTypes: [String] = ["User"]

      public static let selections: [GraphQLSelection] = [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("id", type: .nonNull(.scalar(GraphQLID.self))),
        GraphQLField("profileImage", type: .scalar(String.self)),
        GraphQLField("firstName", type: .scalar(String.self)),
        GraphQLField("lastName", type: .scalar(String.self)),
      ]

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(id: GraphQLID, profileImage: String? = nil, firstName: String? = nil, lastName: String? = nil) {
        self.init(unsafeResultMap: ["__typename": "User", "id": id, "profileImage": profileImage, "firstName": firstName, "lastName": lastName])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

      public var id: GraphQLID {
        get {
          return resultMap["id"]! as! GraphQLID
        }
        set {
          resultMap.updateValue(newValue, forKey: "id")
        }
      }

      public var profileImage: String? {
        get {
          return resultMap["profileImage"] as? String
        }
        set {
          resultMap.updateValue(newValue, forKey: "profileImage")
        }
      }

      public var firstName: String? {
        get {
          return resultMap["firstName"] as? String
        }
        set {
          resultMap.updateValue(newValue, forKey: "firstName")
        }
      }

      public var lastName: String? {
        get {
          return resultMap["lastName"] as? String
        }
        set {
          resultMap.updateValue(newValue, forKey: "lastName")
        }
      }
    }
  }
}

public final class UpdateProfileImageMutation: GraphQLMutation {
  /// The raw GraphQL definition of this operation.
  public let operationDefinition: String =
    """
    mutation UpdateProfileImage($profileImage: String, $id: ID!) {
      updateUser(data: {profileImage: $profileImage}, where: {id: $id}) {
        __typename
        id
        profileImage
      }
    }
    """

  public let operationName: String = "UpdateProfileImage"

  public var profileImage: String?
  public var id: GraphQLID

  public init(profileImage: String? = nil, id: GraphQLID) {
    self.profileImage = profileImage
    self.id = id
  }

  public var variables: GraphQLMap? {
    return ["profileImage": profileImage, "id": id]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes: [String] = ["Mutation"]

    public static let selections: [GraphQLSelection] = [
      GraphQLField("updateUser", arguments: ["data": ["profileImage": GraphQLVariable("profileImage")], "where": ["id": GraphQLVariable("id")]], type: .nonNull(.object(UpdateUser.selections))),
    ]

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(updateUser: UpdateUser) {
      self.init(unsafeResultMap: ["__typename": "Mutation", "updateUser": updateUser.resultMap])
    }

    public var updateUser: UpdateUser {
      get {
        return UpdateUser(unsafeResultMap: resultMap["updateUser"]! as! ResultMap)
      }
      set {
        resultMap.updateValue(newValue.resultMap, forKey: "updateUser")
      }
    }

    public struct UpdateUser: GraphQLSelectionSet {
      public static let possibleTypes: [String] = ["User"]

      public static let selections: [GraphQLSelection] = [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("id", type: .nonNull(.scalar(GraphQLID.self))),
        GraphQLField("profileImage", type: .scalar(String.self)),
      ]

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(id: GraphQLID, profileImage: String? = nil) {
        self.init(unsafeResultMap: ["__typename": "User", "id": id, "profileImage": profileImage])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

      public var id: GraphQLID {
        get {
          return resultMap["id"]! as! GraphQLID
        }
        set {
          resultMap.updateValue(newValue, forKey: "id")
        }
      }

      public var profileImage: String? {
        get {
          return resultMap["profileImage"] as? String
        }
        set {
          resultMap.updateValue(newValue, forKey: "profileImage")
        }
      }
    }
  }
}

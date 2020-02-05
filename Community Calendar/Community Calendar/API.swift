//  This file was automatically generated and should not be edited.

import Apollo
import Foundation

public struct SearchFilters: GraphQLMapConvertible {
  public var graphQLMap: GraphQLMap

  public init(index: Swift.Optional<String?> = nil, location: Swift.Optional<LocationSearchInput?> = nil, tags: Swift.Optional<[String]?> = nil, ticketPrice: Swift.Optional<[TicketPriceSearchInput]?> = nil, dateRange: Swift.Optional<DateRangeSearchInput?> = nil) {
    graphQLMap = ["index": index, "location": location, "tags": tags, "ticketPrice": ticketPrice, "dateRange": dateRange]
  }

  public var index: Swift.Optional<String?> {
    get {
      return graphQLMap["index"] as? Swift.Optional<String?> ?? Swift.Optional<String?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "index")
    }
  }

  public var location: Swift.Optional<LocationSearchInput?> {
    get {
      return graphQLMap["location"] as? Swift.Optional<LocationSearchInput?> ?? Swift.Optional<LocationSearchInput?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "location")
    }
  }

  public var tags: Swift.Optional<[String]?> {
    get {
      return graphQLMap["tags"] as? Swift.Optional<[String]?> ?? Swift.Optional<[String]?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "tags")
    }
  }

  public var ticketPrice: Swift.Optional<[TicketPriceSearchInput]?> {
    get {
      return graphQLMap["ticketPrice"] as? Swift.Optional<[TicketPriceSearchInput]?> ?? Swift.Optional<[TicketPriceSearchInput]?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "ticketPrice")
    }
  }

  public var dateRange: Swift.Optional<DateRangeSearchInput?> {
    get {
      return graphQLMap["dateRange"] as? Swift.Optional<DateRangeSearchInput?> ?? Swift.Optional<DateRangeSearchInput?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "dateRange")
    }
  }
}

public struct LocationSearchInput: GraphQLMapConvertible {
  public var graphQLMap: GraphQLMap

  public init(userLongitude: Double, userLatitude: Double, radius: Int) {
    graphQLMap = ["userLongitude": userLongitude, "userLatitude": userLatitude, "radius": radius]
  }

  public var userLongitude: Double {
    get {
      return graphQLMap["userLongitude"] as! Double
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "userLongitude")
    }
  }

  public var userLatitude: Double {
    get {
      return graphQLMap["userLatitude"] as! Double
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "userLatitude")
    }
  }

  public var radius: Int {
    get {
      return graphQLMap["radius"] as! Int
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "radius")
    }
  }
}

public struct TicketPriceSearchInput: GraphQLMapConvertible {
  public var graphQLMap: GraphQLMap

  public init(minPrice: Swift.Optional<Int?> = nil, maxPrice: Swift.Optional<Int?> = nil) {
    graphQLMap = ["minPrice": minPrice, "maxPrice": maxPrice]
  }

  public var minPrice: Swift.Optional<Int?> {
    get {
      return graphQLMap["minPrice"] as? Swift.Optional<Int?> ?? Swift.Optional<Int?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "minPrice")
    }
  }

  public var maxPrice: Swift.Optional<Int?> {
    get {
      return graphQLMap["maxPrice"] as? Swift.Optional<Int?> ?? Swift.Optional<Int?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "maxPrice")
    }
  }
}

public struct DateRangeSearchInput: GraphQLMapConvertible {
  public var graphQLMap: GraphQLMap

  public init(start: String, end: String) {
    graphQLMap = ["start": start, "end": end]
  }

  public var start: String {
    get {
      return graphQLMap["start"] as! String
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "start")
    }
  }

  public var end: String {
    get {
      return graphQLMap["end"] as! String
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "end")
    }
  }
}

public struct EventIdInput: GraphQLMapConvertible {
  public var graphQLMap: GraphQLMap

  public init(id: GraphQLID) {
    graphQLMap = ["id": id]
  }

  public var id: GraphQLID {
    get {
      return graphQLMap["id"] as! GraphQLID
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "id")
    }
  }
}

public final class GetEventsByFilterQuery: GraphQLQuery {
  /// The raw GraphQL definition of this operation.
  public let operationDefinition =
    """
    query getEventsByFilter($filters: SearchFilters) {
      events(searchFilters: $filters) {
        __typename
        title
        description
        start
        end
        ticketPrice
        id
        creator {
          __typename
          firstName
          lastName
          auth0Id
          profileImage
        }
        eventImages {
          __typename
          url
        }
        rsvps {
          __typename
          firstName
          lastName
        }
        urls {
          __typename
          url
        }
        locations {
          __typename
          latitude
          longitude
          name
          state
          city
          streetAddress
          streetAddress2
          zipcode
          neighborhood {
            __typename
            geoJson {
              __typename
              geoJson
            }
          }
        }
        tags {
          __typename
          title
          id
        }
      }
    }
    """

  public let operationName = "getEventsByFilter"

  public var filters: SearchFilters?

  public init(filters: SearchFilters? = nil) {
    self.filters = filters
  }

  public var variables: GraphQLMap? {
    return ["filters": filters]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes = ["Query"]

    public static let selections: [GraphQLSelection] = [
      GraphQLField("events", arguments: ["searchFilters": GraphQLVariable("filters")], type: .list(.nonNull(.object(Event.selections)))),
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
      public static let possibleTypes = ["Event"]

      public static let selections: [GraphQLSelection] = [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("title", type: .nonNull(.scalar(String.self))),
        GraphQLField("description", type: .nonNull(.scalar(String.self))),
        GraphQLField("start", type: .nonNull(.scalar(String.self))),
        GraphQLField("end", type: .nonNull(.scalar(String.self))),
        GraphQLField("ticketPrice", type: .nonNull(.scalar(Double.self))),
        GraphQLField("id", type: .nonNull(.scalar(GraphQLID.self))),
        GraphQLField("creator", type: .object(Creator.selections)),
        GraphQLField("eventImages", type: .list(.nonNull(.object(EventImage.selections)))),
        GraphQLField("rsvps", type: .list(.nonNull(.object(Rsvp.selections)))),
        GraphQLField("urls", type: .list(.nonNull(.object(Url.selections)))),
        GraphQLField("locations", type: .list(.nonNull(.object(Location.selections)))),
        GraphQLField("tags", type: .list(.nonNull(.object(Tag.selections)))),
      ]

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(title: String, description: String, start: String, end: String, ticketPrice: Double, id: GraphQLID, creator: Creator? = nil, eventImages: [EventImage]? = nil, rsvps: [Rsvp]? = nil, urls: [Url]? = nil, locations: [Location]? = nil, tags: [Tag]? = nil) {
        self.init(unsafeResultMap: ["__typename": "Event", "title": title, "description": description, "start": start, "end": end, "ticketPrice": ticketPrice, "id": id, "creator": creator.flatMap { (value: Creator) -> ResultMap in value.resultMap }, "eventImages": eventImages.flatMap { (value: [EventImage]) -> [ResultMap] in value.map { (value: EventImage) -> ResultMap in value.resultMap } }, "rsvps": rsvps.flatMap { (value: [Rsvp]) -> [ResultMap] in value.map { (value: Rsvp) -> ResultMap in value.resultMap } }, "urls": urls.flatMap { (value: [Url]) -> [ResultMap] in value.map { (value: Url) -> ResultMap in value.resultMap } }, "locations": locations.flatMap { (value: [Location]) -> [ResultMap] in value.map { (value: Location) -> ResultMap in value.resultMap } }, "tags": tags.flatMap { (value: [Tag]) -> [ResultMap] in value.map { (value: Tag) -> ResultMap in value.resultMap } }])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
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

      public var id: GraphQLID {
        get {
          return resultMap["id"]! as! GraphQLID
        }
        set {
          resultMap.updateValue(newValue, forKey: "id")
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

      public var rsvps: [Rsvp]? {
        get {
          return (resultMap["rsvps"] as? [ResultMap]).flatMap { (value: [ResultMap]) -> [Rsvp] in value.map { (value: ResultMap) -> Rsvp in Rsvp(unsafeResultMap: value) } }
        }
        set {
          resultMap.updateValue(newValue.flatMap { (value: [Rsvp]) -> [ResultMap] in value.map { (value: Rsvp) -> ResultMap in value.resultMap } }, forKey: "rsvps")
        }
      }

      public var urls: [Url]? {
        get {
          return (resultMap["urls"] as? [ResultMap]).flatMap { (value: [ResultMap]) -> [Url] in value.map { (value: ResultMap) -> Url in Url(unsafeResultMap: value) } }
        }
        set {
          resultMap.updateValue(newValue.flatMap { (value: [Url]) -> [ResultMap] in value.map { (value: Url) -> ResultMap in value.resultMap } }, forKey: "urls")
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
        public static let possibleTypes = ["User"]

        public static let selections: [GraphQLSelection] = [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("firstName", type: .scalar(String.self)),
          GraphQLField("lastName", type: .scalar(String.self)),
          GraphQLField("auth0Id", type: .nonNull(.scalar(String.self))),
          GraphQLField("profileImage", type: .scalar(String.self)),
        ]

        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public init(firstName: String? = nil, lastName: String? = nil, auth0Id: String, profileImage: String? = nil) {
          self.init(unsafeResultMap: ["__typename": "User", "firstName": firstName, "lastName": lastName, "auth0Id": auth0Id, "profileImage": profileImage])
        }

        public var __typename: String {
          get {
            return resultMap["__typename"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "__typename")
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

        public var auth0Id: String {
          get {
            return resultMap["auth0Id"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "auth0Id")
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
        public static let possibleTypes = ["EventImage"]

        public static let selections: [GraphQLSelection] = [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("url", type: .nonNull(.scalar(String.self))),
        ]

        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public init(url: String) {
          self.init(unsafeResultMap: ["__typename": "EventImage", "url": url])
        }

        public var __typename: String {
          get {
            return resultMap["__typename"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "__typename")
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

      public struct Rsvp: GraphQLSelectionSet {
        public static let possibleTypes = ["User"]

        public static let selections: [GraphQLSelection] = [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("firstName", type: .scalar(String.self)),
          GraphQLField("lastName", type: .scalar(String.self)),
        ]

        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public init(firstName: String? = nil, lastName: String? = nil) {
          self.init(unsafeResultMap: ["__typename": "User", "firstName": firstName, "lastName": lastName])
        }

        public var __typename: String {
          get {
            return resultMap["__typename"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "__typename")
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

      public struct Url: GraphQLSelectionSet {
        public static let possibleTypes = ["EventUrl"]

        public static let selections: [GraphQLSelection] = [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("url", type: .nonNull(.scalar(String.self))),
        ]

        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public init(url: String) {
          self.init(unsafeResultMap: ["__typename": "EventUrl", "url": url])
        }

        public var __typename: String {
          get {
            return resultMap["__typename"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "__typename")
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
        public static let possibleTypes = ["Location"]

        public static let selections: [GraphQLSelection] = [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("latitude", type: .scalar(Double.self)),
          GraphQLField("longitude", type: .scalar(Double.self)),
          GraphQLField("name", type: .nonNull(.scalar(String.self))),
          GraphQLField("state", type: .nonNull(.scalar(String.self))),
          GraphQLField("city", type: .nonNull(.scalar(String.self))),
          GraphQLField("streetAddress", type: .nonNull(.scalar(String.self))),
          GraphQLField("streetAddress2", type: .scalar(String.self)),
          GraphQLField("zipcode", type: .nonNull(.scalar(Int.self))),
          GraphQLField("neighborhood", type: .object(Neighborhood.selections)),
        ]

        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public init(latitude: Double? = nil, longitude: Double? = nil, name: String, state: String, city: String, streetAddress: String, streetAddress2: String? = nil, zipcode: Int, neighborhood: Neighborhood? = nil) {
          self.init(unsafeResultMap: ["__typename": "Location", "latitude": latitude, "longitude": longitude, "name": name, "state": state, "city": city, "streetAddress": streetAddress, "streetAddress2": streetAddress2, "zipcode": zipcode, "neighborhood": neighborhood.flatMap { (value: Neighborhood) -> ResultMap in value.resultMap }])
        }

        public var __typename: String {
          get {
            return resultMap["__typename"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "__typename")
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

        public var name: String {
          get {
            return resultMap["name"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "name")
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

        public var city: String {
          get {
            return resultMap["city"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "city")
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

        public var zipcode: Int {
          get {
            return resultMap["zipcode"]! as! Int
          }
          set {
            resultMap.updateValue(newValue, forKey: "zipcode")
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
          public static let possibleTypes = ["Neighborhood"]

          public static let selections: [GraphQLSelection] = [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("geoJson", type: .nonNull(.object(GeoJson.selections))),
          ]

          public private(set) var resultMap: ResultMap

          public init(unsafeResultMap: ResultMap) {
            self.resultMap = unsafeResultMap
          }

          public init(geoJson: GeoJson) {
            self.init(unsafeResultMap: ["__typename": "Neighborhood", "geoJson": geoJson.resultMap])
          }

          public var __typename: String {
            get {
              return resultMap["__typename"]! as! String
            }
            set {
              resultMap.updateValue(newValue, forKey: "__typename")
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
            public static let possibleTypes = ["GeoJson"]

            public static let selections: [GraphQLSelection] = [
              GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
              GraphQLField("geoJson", type: .nonNull(.scalar(String.self))),
            ]

            public private(set) var resultMap: ResultMap

            public init(unsafeResultMap: ResultMap) {
              self.resultMap = unsafeResultMap
            }

            public init(geoJson: String) {
              self.init(unsafeResultMap: ["__typename": "GeoJson", "geoJson": geoJson])
            }

            public var __typename: String {
              get {
                return resultMap["__typename"]! as! String
              }
              set {
                resultMap.updateValue(newValue, forKey: "__typename")
              }
            }

            public var geoJson: String {
              get {
                return resultMap["geoJson"]! as! String
              }
              set {
                resultMap.updateValue(newValue, forKey: "geoJson")
              }
            }
          }
        }
      }

      public struct Tag: GraphQLSelectionSet {
        public static let possibleTypes = ["Tag"]

        public static let selections: [GraphQLSelection] = [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("title", type: .nonNull(.scalar(String.self))),
          GraphQLField("id", type: .nonNull(.scalar(GraphQLID.self))),
        ]

        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public init(title: String, id: GraphQLID) {
          self.init(unsafeResultMap: ["__typename": "Tag", "title": title, "id": id])
        }

        public var __typename: String {
          get {
            return resultMap["__typename"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "__typename")
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

public final class GetEventsQuery: GraphQLQuery {
  /// The raw GraphQL definition of this operation.
  public let operationDefinition =
    """
    query getEvents {
      events {
        __typename
        title
        description
        start
        end
        ticketPrice
        id
        creator {
          __typename
          firstName
          lastName
          auth0Id
          profileImage
        }
        eventImages {
          __typename
          url
        }
        rsvps {
          __typename
          firstName
          lastName
        }
        urls {
          __typename
          url
        }
        locations {
          __typename
          latitude
          longitude
          name
          state
          city
          streetAddress
          streetAddress2
          zipcode
          neighborhood {
            __typename
            geoJson {
              __typename
              geoJson
            }
          }
        }
        tags {
          __typename
          title
          id
        }
      }
    }
    """

  public let operationName = "getEvents"

  public init() {
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes = ["Query"]

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
      public static let possibleTypes = ["Event"]

      public static let selections: [GraphQLSelection] = [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("title", type: .nonNull(.scalar(String.self))),
        GraphQLField("description", type: .nonNull(.scalar(String.self))),
        GraphQLField("start", type: .nonNull(.scalar(String.self))),
        GraphQLField("end", type: .nonNull(.scalar(String.self))),
        GraphQLField("ticketPrice", type: .nonNull(.scalar(Double.self))),
        GraphQLField("id", type: .nonNull(.scalar(GraphQLID.self))),
        GraphQLField("creator", type: .object(Creator.selections)),
        GraphQLField("eventImages", type: .list(.nonNull(.object(EventImage.selections)))),
        GraphQLField("rsvps", type: .list(.nonNull(.object(Rsvp.selections)))),
        GraphQLField("urls", type: .list(.nonNull(.object(Url.selections)))),
        GraphQLField("locations", type: .list(.nonNull(.object(Location.selections)))),
        GraphQLField("tags", type: .list(.nonNull(.object(Tag.selections)))),
      ]

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(title: String, description: String, start: String, end: String, ticketPrice: Double, id: GraphQLID, creator: Creator? = nil, eventImages: [EventImage]? = nil, rsvps: [Rsvp]? = nil, urls: [Url]? = nil, locations: [Location]? = nil, tags: [Tag]? = nil) {
        self.init(unsafeResultMap: ["__typename": "Event", "title": title, "description": description, "start": start, "end": end, "ticketPrice": ticketPrice, "id": id, "creator": creator.flatMap { (value: Creator) -> ResultMap in value.resultMap }, "eventImages": eventImages.flatMap { (value: [EventImage]) -> [ResultMap] in value.map { (value: EventImage) -> ResultMap in value.resultMap } }, "rsvps": rsvps.flatMap { (value: [Rsvp]) -> [ResultMap] in value.map { (value: Rsvp) -> ResultMap in value.resultMap } }, "urls": urls.flatMap { (value: [Url]) -> [ResultMap] in value.map { (value: Url) -> ResultMap in value.resultMap } }, "locations": locations.flatMap { (value: [Location]) -> [ResultMap] in value.map { (value: Location) -> ResultMap in value.resultMap } }, "tags": tags.flatMap { (value: [Tag]) -> [ResultMap] in value.map { (value: Tag) -> ResultMap in value.resultMap } }])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
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

      public var id: GraphQLID {
        get {
          return resultMap["id"]! as! GraphQLID
        }
        set {
          resultMap.updateValue(newValue, forKey: "id")
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

      public var rsvps: [Rsvp]? {
        get {
          return (resultMap["rsvps"] as? [ResultMap]).flatMap { (value: [ResultMap]) -> [Rsvp] in value.map { (value: ResultMap) -> Rsvp in Rsvp(unsafeResultMap: value) } }
        }
        set {
          resultMap.updateValue(newValue.flatMap { (value: [Rsvp]) -> [ResultMap] in value.map { (value: Rsvp) -> ResultMap in value.resultMap } }, forKey: "rsvps")
        }
      }

      public var urls: [Url]? {
        get {
          return (resultMap["urls"] as? [ResultMap]).flatMap { (value: [ResultMap]) -> [Url] in value.map { (value: ResultMap) -> Url in Url(unsafeResultMap: value) } }
        }
        set {
          resultMap.updateValue(newValue.flatMap { (value: [Url]) -> [ResultMap] in value.map { (value: Url) -> ResultMap in value.resultMap } }, forKey: "urls")
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
        public static let possibleTypes = ["User"]

        public static let selections: [GraphQLSelection] = [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("firstName", type: .scalar(String.self)),
          GraphQLField("lastName", type: .scalar(String.self)),
          GraphQLField("auth0Id", type: .nonNull(.scalar(String.self))),
          GraphQLField("profileImage", type: .scalar(String.self)),
        ]

        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public init(firstName: String? = nil, lastName: String? = nil, auth0Id: String, profileImage: String? = nil) {
          self.init(unsafeResultMap: ["__typename": "User", "firstName": firstName, "lastName": lastName, "auth0Id": auth0Id, "profileImage": profileImage])
        }

        public var __typename: String {
          get {
            return resultMap["__typename"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "__typename")
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

        public var auth0Id: String {
          get {
            return resultMap["auth0Id"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "auth0Id")
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
        public static let possibleTypes = ["EventImage"]

        public static let selections: [GraphQLSelection] = [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("url", type: .nonNull(.scalar(String.self))),
        ]

        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public init(url: String) {
          self.init(unsafeResultMap: ["__typename": "EventImage", "url": url])
        }

        public var __typename: String {
          get {
            return resultMap["__typename"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "__typename")
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

      public struct Rsvp: GraphQLSelectionSet {
        public static let possibleTypes = ["User"]

        public static let selections: [GraphQLSelection] = [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("firstName", type: .scalar(String.self)),
          GraphQLField("lastName", type: .scalar(String.self)),
        ]

        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public init(firstName: String? = nil, lastName: String? = nil) {
          self.init(unsafeResultMap: ["__typename": "User", "firstName": firstName, "lastName": lastName])
        }

        public var __typename: String {
          get {
            return resultMap["__typename"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "__typename")
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

      public struct Url: GraphQLSelectionSet {
        public static let possibleTypes = ["EventUrl"]

        public static let selections: [GraphQLSelection] = [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("url", type: .nonNull(.scalar(String.self))),
        ]

        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public init(url: String) {
          self.init(unsafeResultMap: ["__typename": "EventUrl", "url": url])
        }

        public var __typename: String {
          get {
            return resultMap["__typename"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "__typename")
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
        public static let possibleTypes = ["Location"]

        public static let selections: [GraphQLSelection] = [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("latitude", type: .scalar(Double.self)),
          GraphQLField("longitude", type: .scalar(Double.self)),
          GraphQLField("name", type: .nonNull(.scalar(String.self))),
          GraphQLField("state", type: .nonNull(.scalar(String.self))),
          GraphQLField("city", type: .nonNull(.scalar(String.self))),
          GraphQLField("streetAddress", type: .nonNull(.scalar(String.self))),
          GraphQLField("streetAddress2", type: .scalar(String.self)),
          GraphQLField("zipcode", type: .nonNull(.scalar(Int.self))),
          GraphQLField("neighborhood", type: .object(Neighborhood.selections)),
        ]

        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public init(latitude: Double? = nil, longitude: Double? = nil, name: String, state: String, city: String, streetAddress: String, streetAddress2: String? = nil, zipcode: Int, neighborhood: Neighborhood? = nil) {
          self.init(unsafeResultMap: ["__typename": "Location", "latitude": latitude, "longitude": longitude, "name": name, "state": state, "city": city, "streetAddress": streetAddress, "streetAddress2": streetAddress2, "zipcode": zipcode, "neighborhood": neighborhood.flatMap { (value: Neighborhood) -> ResultMap in value.resultMap }])
        }

        public var __typename: String {
          get {
            return resultMap["__typename"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "__typename")
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

        public var name: String {
          get {
            return resultMap["name"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "name")
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

        public var city: String {
          get {
            return resultMap["city"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "city")
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

        public var zipcode: Int {
          get {
            return resultMap["zipcode"]! as! Int
          }
          set {
            resultMap.updateValue(newValue, forKey: "zipcode")
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
          public static let possibleTypes = ["Neighborhood"]

          public static let selections: [GraphQLSelection] = [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("geoJson", type: .nonNull(.object(GeoJson.selections))),
          ]

          public private(set) var resultMap: ResultMap

          public init(unsafeResultMap: ResultMap) {
            self.resultMap = unsafeResultMap
          }

          public init(geoJson: GeoJson) {
            self.init(unsafeResultMap: ["__typename": "Neighborhood", "geoJson": geoJson.resultMap])
          }

          public var __typename: String {
            get {
              return resultMap["__typename"]! as! String
            }
            set {
              resultMap.updateValue(newValue, forKey: "__typename")
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
            public static let possibleTypes = ["GeoJson"]

            public static let selections: [GraphQLSelection] = [
              GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
              GraphQLField("geoJson", type: .nonNull(.scalar(String.self))),
            ]

            public private(set) var resultMap: ResultMap

            public init(unsafeResultMap: ResultMap) {
              self.resultMap = unsafeResultMap
            }

            public init(geoJson: String) {
              self.init(unsafeResultMap: ["__typename": "GeoJson", "geoJson": geoJson])
            }

            public var __typename: String {
              get {
                return resultMap["__typename"]! as! String
              }
              set {
                resultMap.updateValue(newValue, forKey: "__typename")
              }
            }

            public var geoJson: String {
              get {
                return resultMap["geoJson"]! as! String
              }
              set {
                resultMap.updateValue(newValue, forKey: "geoJson")
              }
            }
          }
        }
      }

      public struct Tag: GraphQLSelectionSet {
        public static let possibleTypes = ["Tag"]

        public static let selections: [GraphQLSelection] = [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("title", type: .nonNull(.scalar(String.self))),
          GraphQLField("id", type: .nonNull(.scalar(GraphQLID.self))),
        ]

        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public init(title: String, id: GraphQLID) {
          self.init(unsafeResultMap: ["__typename": "Tag", "title": title, "id": id])
        }

        public var __typename: String {
          get {
            return resultMap["__typename"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "__typename")
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

public final class GetTagsQuery: GraphQLQuery {
  /// The raw GraphQL definition of this operation.
  public let operationDefinition =
    """
    query getTags {
      tags {
        __typename
        title
        id
      }
    }
    """

  public let operationName = "getTags"

  public init() {
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes = ["Query"]

    public static let selections: [GraphQLSelection] = [
      GraphQLField("tags", type: .list(.nonNull(.object(Tag.selections)))),
    ]

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(tags: [Tag]? = nil) {
      self.init(unsafeResultMap: ["__typename": "Query", "tags": tags.flatMap { (value: [Tag]) -> [ResultMap] in value.map { (value: Tag) -> ResultMap in value.resultMap } }])
    }

    public var tags: [Tag]? {
      get {
        return (resultMap["tags"] as? [ResultMap]).flatMap { (value: [ResultMap]) -> [Tag] in value.map { (value: ResultMap) -> Tag in Tag(unsafeResultMap: value) } }
      }
      set {
        resultMap.updateValue(newValue.flatMap { (value: [Tag]) -> [ResultMap] in value.map { (value: Tag) -> ResultMap in value.resultMap } }, forKey: "tags")
      }
    }

    public struct Tag: GraphQLSelectionSet {
      public static let possibleTypes = ["Tag"]

      public static let selections: [GraphQLSelection] = [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("title", type: .nonNull(.scalar(String.self))),
        GraphQLField("id", type: .nonNull(.scalar(GraphQLID.self))),
      ]

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(title: String, id: GraphQLID) {
        self.init(unsafeResultMap: ["__typename": "Tag", "title": title, "id": id])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
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

public final class RsvpToEventMutation: GraphQLMutation {
  /// The raw GraphQL definition of this operation.
  public let operationDefinition =
    """
    mutation rsvpToEvent($id: EventIdInput!) {
      rsvpEvent(event: $id)
    }
    """

  public let operationName = "rsvpToEvent"

  public var id: EventIdInput

  public init(id: EventIdInput) {
    self.id = id
  }

  public var variables: GraphQLMap? {
    return ["id": id]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes = ["Mutation"]

    public static let selections: [GraphQLSelection] = [
      GraphQLField("rsvpEvent", arguments: ["event": GraphQLVariable("id")], type: .nonNull(.scalar(Bool.self))),
    ]

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(rsvpEvent: Bool) {
      self.init(unsafeResultMap: ["__typename": "Mutation", "rsvpEvent": rsvpEvent])
    }

    public var rsvpEvent: Bool {
      get {
        return resultMap["rsvpEvent"]! as! Bool
      }
      set {
        resultMap.updateValue(newValue, forKey: "rsvpEvent")
      }
    }
  }
}

public final class GetUserRsvPsQuery: GraphQLQuery {
  /// The raw GraphQL definition of this operation.
  public let operationDefinition =
    """
    query getUserRSVPs($id: ID) {
      users(where: {id: $id}) {
        __typename
        rsvps {
          __typename
          id
          title
        }
      }
    }
    """

  public let operationName = "getUserRSVPs"

  public var id: GraphQLID?

  public init(id: GraphQLID? = nil) {
    self.id = id
  }

  public var variables: GraphQLMap? {
    return ["id": id]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes = ["Query"]

    public static let selections: [GraphQLSelection] = [
      GraphQLField("users", arguments: ["where": ["id": GraphQLVariable("id")]], type: .list(.nonNull(.object(User.selections)))),
    ]

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(users: [User]? = nil) {
      self.init(unsafeResultMap: ["__typename": "Query", "users": users.flatMap { (value: [User]) -> [ResultMap] in value.map { (value: User) -> ResultMap in value.resultMap } }])
    }

    public var users: [User]? {
      get {
        return (resultMap["users"] as? [ResultMap]).flatMap { (value: [ResultMap]) -> [User] in value.map { (value: ResultMap) -> User in User(unsafeResultMap: value) } }
      }
      set {
        resultMap.updateValue(newValue.flatMap { (value: [User]) -> [ResultMap] in value.map { (value: User) -> ResultMap in value.resultMap } }, forKey: "users")
      }
    }

    public struct User: GraphQLSelectionSet {
      public static let possibleTypes = ["User"]

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
        public static let possibleTypes = ["Event"]

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
          self.init(unsafeResultMap: ["__typename": "Event", "id": id, "title": title])
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

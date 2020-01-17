//  This file was automatically generated and should not be edited.

import Apollo
import Foundation

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
        creator {
          __typename
          firstName
          lastName
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

      public init(title: String, description: String, start: String, end: String, creator: Creator? = nil, eventImages: [EventImage]? = nil, rsvps: [Rsvp]? = nil, urls: [Url]? = nil, locations: [Location]? = nil, tags: [Tag]? = nil) {
        self.init(unsafeResultMap: ["__typename": "Event", "title": title, "description": description, "start": start, "end": end, "creator": creator.flatMap { (value: Creator) -> ResultMap in value.resultMap }, "eventImages": eventImages.flatMap { (value: [EventImage]) -> [ResultMap] in value.map { (value: EventImage) -> ResultMap in value.resultMap } }, "rsvps": rsvps.flatMap { (value: [Rsvp]) -> [ResultMap] in value.map { (value: Rsvp) -> ResultMap in value.resultMap } }, "urls": urls.flatMap { (value: [Url]) -> [ResultMap] in value.map { (value: Url) -> ResultMap in value.resultMap } }, "locations": locations.flatMap { (value: [Location]) -> [ResultMap] in value.map { (value: Location) -> ResultMap in value.resultMap } }, "tags": tags.flatMap { (value: [Tag]) -> [ResultMap] in value.map { (value: Tag) -> ResultMap in value.resultMap } }])
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

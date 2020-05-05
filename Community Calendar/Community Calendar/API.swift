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
        eventImages {
          __typename
          url
        }
        creator {
          __typename
          id
          firstName
          lastName
        }
        locations {
          __typename
          name
          streetAddress
          streetAddress2
          city
          state
          zipcode
          longitude
          latitude
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
        GraphQLField("eventImages", type: .list(.nonNull(.object(EventImage.selections)))),
        GraphQLField("creator", type: .object(Creator.selections)),
        GraphQLField("locations", type: .list(.nonNull(.object(Location.selections)))),
      ]

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(id: GraphQLID, title: String, description: String, start: String, end: String, ticketPrice: Double, eventImages: [EventImage]? = nil, creator: Creator? = nil, locations: [Location]? = nil) {
        self.init(unsafeResultMap: ["__typename": "Event", "id": id, "title": title, "description": description, "start": start, "end": end, "ticketPrice": ticketPrice, "eventImages": eventImages.flatMap { (value: [EventImage]) -> [ResultMap] in value.map { (value: EventImage) -> ResultMap in value.resultMap } }, "creator": creator.flatMap { (value: Creator) -> ResultMap in value.resultMap }, "locations": locations.flatMap { (value: [Location]) -> [ResultMap] in value.map { (value: Location) -> ResultMap in value.resultMap } }])
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

      public var locations: [Location]? {
        get {
          return (resultMap["locations"] as? [ResultMap]).flatMap { (value: [ResultMap]) -> [Location] in value.map { (value: ResultMap) -> Location in Location(unsafeResultMap: value) } }
        }
        set {
          resultMap.updateValue(newValue.flatMap { (value: [Location]) -> [ResultMap] in value.map { (value: Location) -> ResultMap in value.resultMap } }, forKey: "locations")
        }
      }

      public struct EventImage: GraphQLSelectionSet {
        public static let possibleTypes: [String] = ["EventImage"]

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

      public struct Creator: GraphQLSelectionSet {
        public static let possibleTypes: [String] = ["User"]

        public static let selections: [GraphQLSelection] = [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("id", type: .nonNull(.scalar(GraphQLID.self))),
          GraphQLField("firstName", type: .scalar(String.self)),
          GraphQLField("lastName", type: .scalar(String.self)),
        ]

        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public init(id: GraphQLID, firstName: String? = nil, lastName: String? = nil) {
          self.init(unsafeResultMap: ["__typename": "User", "id": id, "firstName": firstName, "lastName": lastName])
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
      }

      public struct Location: GraphQLSelectionSet {
        public static let possibleTypes: [String] = ["Location"]

        public static let selections: [GraphQLSelection] = [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("name", type: .nonNull(.scalar(String.self))),
          GraphQLField("streetAddress", type: .nonNull(.scalar(String.self))),
          GraphQLField("streetAddress2", type: .scalar(String.self)),
          GraphQLField("city", type: .nonNull(.scalar(String.self))),
          GraphQLField("state", type: .nonNull(.scalar(String.self))),
          GraphQLField("zipcode", type: .nonNull(.scalar(Int.self))),
          GraphQLField("longitude", type: .scalar(Double.self)),
          GraphQLField("latitude", type: .scalar(Double.self)),
        ]

        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public init(name: String, streetAddress: String, streetAddress2: String? = nil, city: String, state: String, zipcode: Int, longitude: Double? = nil, latitude: Double? = nil) {
          self.init(unsafeResultMap: ["__typename": "Location", "name": name, "streetAddress": streetAddress, "streetAddress2": streetAddress2, "city": city, "state": state, "zipcode": zipcode, "longitude": longitude, "latitude": latitude])
        }

        public var __typename: String {
          get {
            return resultMap["__typename"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "__typename")
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
      }
    }
  }
}

public final class AddProfilePicMutation: GraphQLMutation {
  /// The raw GraphQL definition of this operation.
  public let operationDefinition: String =
    """
    mutation AddProfilePic($profileImage: String!, $id: ID) {
      updateUser(data: {profileImage: $profileImage}, where: {id: $id}) {
        __typename
        id
      }
    }
    """

  public let operationName: String = "AddProfilePic"

  public var profileImage: String
  public var id: GraphQLID?

  public init(profileImage: String, id: GraphQLID? = nil) {
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
      ]

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(id: GraphQLID) {
        self.init(unsafeResultMap: ["__typename": "User", "id": id])
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

public final class FetchUserIdQuery: GraphQLQuery {
  /// The raw GraphQL definition of this operation.
  public let operationDefinition: String =
    """
    query fetchUserID($oktaId: String) {
      user(where: {oktaId: $oktaId}) {
        __typename
        id
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
      ]

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(id: GraphQLID) {
        self.init(unsafeResultMap: ["__typename": "User", "id": id])
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

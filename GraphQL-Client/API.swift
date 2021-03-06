//  This file was automatically generated and should not be edited.

import Apollo

public struct HistoricalEventInput: GraphQLMapConvertible {
  public var graphQLMap: GraphQLMap

  public init(date: String, description: Optional<String?> = nil, id: Optional<String?> = nil, name: String, type: HistoricalEventType) {
    graphQLMap = ["date": date, "description": description, "id": id, "name": name, "type": type]
  }

  public var date: String {
    get {
      return graphQLMap["date"] as! String
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "date")
    }
  }

  public var description: Optional<String?> {
    get {
      return graphQLMap["description"] as! Optional<String?>
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "description")
    }
  }

  public var id: Optional<String?> {
    get {
      return graphQLMap["id"] as! Optional<String?>
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "id")
    }
  }

  public var name: String {
    get {
      return graphQLMap["name"] as! String
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "name")
    }
  }

  public var type: HistoricalEventType {
    get {
      return graphQLMap["type"] as! HistoricalEventType
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "type")
    }
  }
}

public enum HistoricalEventType: RawRepresentable, Equatable, Apollo.JSONDecodable, Apollo.JSONEncodable {
  public typealias RawValue = String
  case common
  case greatPerson
  case battle
  /// Auto generated constant for unknown enum values
  case unknown(RawValue)

  public init?(rawValue: RawValue) {
    switch rawValue {
      case "COMMON": self = .common
      case "GREAT_PERSON": self = .greatPerson
      case "BATTLE": self = .battle
      default: self = .unknown(rawValue)
    }
  }

  public var rawValue: RawValue {
    switch self {
      case .common: return "COMMON"
      case .greatPerson: return "GREAT_PERSON"
      case .battle: return "BATTLE"
      case .unknown(let value): return value
    }
  }

  public static func == (lhs: HistoricalEventType, rhs: HistoricalEventType) -> Bool {
    switch (lhs, rhs) {
      case (.common, .common): return true
      case (.greatPerson, .greatPerson): return true
      case (.battle, .battle): return true
      case (.unknown(let lhsValue), .unknown(let rhsValue)): return lhsValue == rhsValue
      default: return false
    }
  }
}

public final class GetEventsQuery: GraphQLQuery {
  public static let operationString =
    "query GetEvents($cursor: String) {\n  allEvents(cursor: $cursor, limit: 10) {\n    __typename\n    cursor\n    items {\n      __typename\n      ...BriefHistoricalEvent\n    }\n    totalCount\n  }\n}"

  public static var requestString: String { return operationString.appending(BriefHistoricalEvent.fragmentString) }

  public var cursor: String?

  public init(cursor: String? = nil) {
    self.cursor = cursor
  }

  public var variables: GraphQLMap? {
    return ["cursor": cursor]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes = ["Query"]

    public static let selections: [GraphQLSelection] = [
      GraphQLField("allEvents", arguments: ["cursor": GraphQLVariable("cursor"), "limit": 10], type: .nonNull(.object(AllEvent.selections))),
    ]

    public var snapshot: Snapshot

    public init(snapshot: Snapshot) {
      self.snapshot = snapshot
    }

    public init(allEvents: AllEvent) {
      self.init(snapshot: ["__typename": "Query", "allEvents": allEvents.snapshot])
    }

    public var allEvents: AllEvent {
      get {
        return AllEvent(snapshot: snapshot["allEvents"]! as! Snapshot)
      }
      set {
        snapshot.updateValue(newValue.snapshot, forKey: "allEvents")
      }
    }

    public struct AllEvent: GraphQLSelectionSet {
      public static let possibleTypes = ["Page"]

      public static let selections: [GraphQLSelection] = [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("cursor", type: .scalar(String.self)),
        GraphQLField("items", type: .nonNull(.list(.nonNull(.object(Item.selections))))),
        GraphQLField("totalCount", type: .nonNull(.scalar(Int.self))),
      ]

      public var snapshot: Snapshot

      public init(snapshot: Snapshot) {
        self.snapshot = snapshot
      }

      public init(cursor: String? = nil, items: [Item], totalCount: Int) {
        self.init(snapshot: ["__typename": "Page", "cursor": cursor, "items": items.map { $0.snapshot }, "totalCount": totalCount])
      }

      public var __typename: String {
        get {
          return snapshot["__typename"]! as! String
        }
        set {
          snapshot.updateValue(newValue, forKey: "__typename")
        }
      }

      public var cursor: String? {
        get {
          return snapshot["cursor"] as? String
        }
        set {
          snapshot.updateValue(newValue, forKey: "cursor")
        }
      }

      public var items: [Item] {
        get {
          return (snapshot["items"] as! [Snapshot]).map { Item(snapshot: $0) }
        }
        set {
          snapshot.updateValue(newValue.map { $0.snapshot }, forKey: "items")
        }
      }

      public var totalCount: Int {
        get {
          return snapshot["totalCount"]! as! Int
        }
        set {
          snapshot.updateValue(newValue, forKey: "totalCount")
        }
      }

      public struct Item: GraphQLSelectionSet {
        public static let possibleTypes = ["HistoricalEvent"]

        public static let selections: [GraphQLSelection] = [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("id", type: .nonNull(.scalar(String.self))),
          GraphQLField("name", type: .nonNull(.scalar(String.self))),
          GraphQLField("date", type: .nonNull(.scalar(String.self))),
          GraphQLField("type", type: .nonNull(.scalar(HistoricalEventType.self))),
        ]

        public var snapshot: Snapshot

        public init(snapshot: Snapshot) {
          self.snapshot = snapshot
        }

        public init(id: String, name: String, date: String, type: HistoricalEventType) {
          self.init(snapshot: ["__typename": "HistoricalEvent", "id": id, "name": name, "date": date, "type": type])
        }

        public var __typename: String {
          get {
            return snapshot["__typename"]! as! String
          }
          set {
            snapshot.updateValue(newValue, forKey: "__typename")
          }
        }

        public var id: String {
          get {
            return snapshot["id"]! as! String
          }
          set {
            snapshot.updateValue(newValue, forKey: "id")
          }
        }

        public var name: String {
          get {
            return snapshot["name"]! as! String
          }
          set {
            snapshot.updateValue(newValue, forKey: "name")
          }
        }

        public var date: String {
          get {
            return snapshot["date"]! as! String
          }
          set {
            snapshot.updateValue(newValue, forKey: "date")
          }
        }

        public var type: HistoricalEventType {
          get {
            return snapshot["type"]! as! HistoricalEventType
          }
          set {
            snapshot.updateValue(newValue, forKey: "type")
          }
        }

        public var fragments: Fragments {
          get {
            return Fragments(snapshot: snapshot)
          }
          set {
            snapshot += newValue.snapshot
          }
        }

        public struct Fragments {
          public var snapshot: Snapshot

          public var briefHistoricalEvent: BriefHistoricalEvent {
            get {
              return BriefHistoricalEvent(snapshot: snapshot)
            }
            set {
              snapshot += newValue.snapshot
            }
          }
        }
      }
    }
  }
}

public final class GetHistoricalEventQuery: GraphQLQuery {
  public static let operationString =
    "query GetHistoricalEvent($id: String!) {\n  historicalEvent(id: $id) {\n    __typename\n    ...FullHistoricalEvent\n  }\n}"

  public static var requestString: String { return operationString.appending(FullHistoricalEvent.fragmentString).appending(HistoricalEventContent.fragmentString) }

  public var id: String

  public init(id: String) {
    self.id = id
  }

  public var variables: GraphQLMap? {
    return ["id": id]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes = ["Query"]

    public static let selections: [GraphQLSelection] = [
      GraphQLField("historicalEvent", arguments: ["id": GraphQLVariable("id")], type: .object(HistoricalEvent.selections)),
    ]

    public var snapshot: Snapshot

    public init(snapshot: Snapshot) {
      self.snapshot = snapshot
    }

    public init(historicalEvent: HistoricalEvent? = nil) {
      self.init(snapshot: ["__typename": "Query", "historicalEvent": historicalEvent.flatMap { $0.snapshot }])
    }

    public var historicalEvent: HistoricalEvent? {
      get {
        return (snapshot["historicalEvent"] as? Snapshot).flatMap { HistoricalEvent(snapshot: $0) }
      }
      set {
        snapshot.updateValue(newValue?.snapshot, forKey: "historicalEvent")
      }
    }

    public struct HistoricalEvent: GraphQLSelectionSet {
      public static let possibleTypes = ["HistoricalEvent"]

      public static let selections: [GraphQLSelection] = [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("id", type: .nonNull(.scalar(String.self))),
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("name", type: .nonNull(.scalar(String.self))),
        GraphQLField("date", type: .nonNull(.scalar(String.self))),
        GraphQLField("type", type: .nonNull(.scalar(HistoricalEventType.self))),
        GraphQLField("description", type: .scalar(String.self)),
      ]

      public var snapshot: Snapshot

      public init(snapshot: Snapshot) {
        self.snapshot = snapshot
      }

      public init(id: String, name: String, date: String, type: HistoricalEventType, description: String? = nil) {
        self.init(snapshot: ["__typename": "HistoricalEvent", "id": id, "name": name, "date": date, "type": type, "description": description])
      }

      public var __typename: String {
        get {
          return snapshot["__typename"]! as! String
        }
        set {
          snapshot.updateValue(newValue, forKey: "__typename")
        }
      }

      public var id: String {
        get {
          return snapshot["id"]! as! String
        }
        set {
          snapshot.updateValue(newValue, forKey: "id")
        }
      }

      public var name: String {
        get {
          return snapshot["name"]! as! String
        }
        set {
          snapshot.updateValue(newValue, forKey: "name")
        }
      }

      public var date: String {
        get {
          return snapshot["date"]! as! String
        }
        set {
          snapshot.updateValue(newValue, forKey: "date")
        }
      }

      public var type: HistoricalEventType {
        get {
          return snapshot["type"]! as! HistoricalEventType
        }
        set {
          snapshot.updateValue(newValue, forKey: "type")
        }
      }

      public var description: String? {
        get {
          return snapshot["description"] as? String
        }
        set {
          snapshot.updateValue(newValue, forKey: "description")
        }
      }

      public var fragments: Fragments {
        get {
          return Fragments(snapshot: snapshot)
        }
        set {
          snapshot += newValue.snapshot
        }
      }

      public struct Fragments {
        public var snapshot: Snapshot

        public var fullHistoricalEvent: FullHistoricalEvent {
          get {
            return FullHistoricalEvent(snapshot: snapshot)
          }
          set {
            snapshot += newValue.snapshot
          }
        }

        public var historicalEventContent: HistoricalEventContent {
          get {
            return HistoricalEventContent(snapshot: snapshot)
          }
          set {
            snapshot += newValue.snapshot
          }
        }
      }
    }
  }
}

public final class CreateHistoricalEventMutation: GraphQLMutation {
  public static let operationString =
    "mutation CreateHistoricalEvent($event: HistoricalEventInput!) {\n  createEvent(input: $event) {\n    __typename\n    ...FullHistoricalEvent\n  }\n}"

  public static var requestString: String { return operationString.appending(FullHistoricalEvent.fragmentString).appending(HistoricalEventContent.fragmentString) }

  public var event: HistoricalEventInput

  public init(event: HistoricalEventInput) {
    self.event = event
  }

  public var variables: GraphQLMap? {
    return ["event": event]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes = ["Mutation"]

    public static let selections: [GraphQLSelection] = [
      GraphQLField("createEvent", arguments: ["input": GraphQLVariable("event")], type: .nonNull(.object(CreateEvent.selections))),
    ]

    public var snapshot: Snapshot

    public init(snapshot: Snapshot) {
      self.snapshot = snapshot
    }

    public init(createEvent: CreateEvent) {
      self.init(snapshot: ["__typename": "Mutation", "createEvent": createEvent.snapshot])
    }

    public var createEvent: CreateEvent {
      get {
        return CreateEvent(snapshot: snapshot["createEvent"]! as! Snapshot)
      }
      set {
        snapshot.updateValue(newValue.snapshot, forKey: "createEvent")
      }
    }

    public struct CreateEvent: GraphQLSelectionSet {
      public static let possibleTypes = ["HistoricalEvent"]

      public static let selections: [GraphQLSelection] = [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("id", type: .nonNull(.scalar(String.self))),
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("name", type: .nonNull(.scalar(String.self))),
        GraphQLField("date", type: .nonNull(.scalar(String.self))),
        GraphQLField("type", type: .nonNull(.scalar(HistoricalEventType.self))),
        GraphQLField("description", type: .scalar(String.self)),
      ]

      public var snapshot: Snapshot

      public init(snapshot: Snapshot) {
        self.snapshot = snapshot
      }

      public init(id: String, name: String, date: String, type: HistoricalEventType, description: String? = nil) {
        self.init(snapshot: ["__typename": "HistoricalEvent", "id": id, "name": name, "date": date, "type": type, "description": description])
      }

      public var __typename: String {
        get {
          return snapshot["__typename"]! as! String
        }
        set {
          snapshot.updateValue(newValue, forKey: "__typename")
        }
      }

      public var id: String {
        get {
          return snapshot["id"]! as! String
        }
        set {
          snapshot.updateValue(newValue, forKey: "id")
        }
      }

      public var name: String {
        get {
          return snapshot["name"]! as! String
        }
        set {
          snapshot.updateValue(newValue, forKey: "name")
        }
      }

      public var date: String {
        get {
          return snapshot["date"]! as! String
        }
        set {
          snapshot.updateValue(newValue, forKey: "date")
        }
      }

      public var type: HistoricalEventType {
        get {
          return snapshot["type"]! as! HistoricalEventType
        }
        set {
          snapshot.updateValue(newValue, forKey: "type")
        }
      }

      public var description: String? {
        get {
          return snapshot["description"] as? String
        }
        set {
          snapshot.updateValue(newValue, forKey: "description")
        }
      }

      public var fragments: Fragments {
        get {
          return Fragments(snapshot: snapshot)
        }
        set {
          snapshot += newValue.snapshot
        }
      }

      public struct Fragments {
        public var snapshot: Snapshot

        public var fullHistoricalEvent: FullHistoricalEvent {
          get {
            return FullHistoricalEvent(snapshot: snapshot)
          }
          set {
            snapshot += newValue.snapshot
          }
        }

        public var historicalEventContent: HistoricalEventContent {
          get {
            return HistoricalEventContent(snapshot: snapshot)
          }
          set {
            snapshot += newValue.snapshot
          }
        }
      }
    }
  }
}

public final class UpdateHistoricalEventMutation: GraphQLMutation {
  public static let operationString =
    "mutation UpdateHistoricalEvent($event: HistoricalEventInput!) {\n  updateEvent(input: $event) {\n    __typename\n    ...FullHistoricalEvent\n  }\n}"

  public static var requestString: String { return operationString.appending(FullHistoricalEvent.fragmentString).appending(HistoricalEventContent.fragmentString) }

  public var event: HistoricalEventInput

  public init(event: HistoricalEventInput) {
    self.event = event
  }

  public var variables: GraphQLMap? {
    return ["event": event]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes = ["Mutation"]

    public static let selections: [GraphQLSelection] = [
      GraphQLField("updateEvent", arguments: ["input": GraphQLVariable("event")], type: .nonNull(.object(UpdateEvent.selections))),
    ]

    public var snapshot: Snapshot

    public init(snapshot: Snapshot) {
      self.snapshot = snapshot
    }

    public init(updateEvent: UpdateEvent) {
      self.init(snapshot: ["__typename": "Mutation", "updateEvent": updateEvent.snapshot])
    }

    public var updateEvent: UpdateEvent {
      get {
        return UpdateEvent(snapshot: snapshot["updateEvent"]! as! Snapshot)
      }
      set {
        snapshot.updateValue(newValue.snapshot, forKey: "updateEvent")
      }
    }

    public struct UpdateEvent: GraphQLSelectionSet {
      public static let possibleTypes = ["HistoricalEvent"]

      public static let selections: [GraphQLSelection] = [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("id", type: .nonNull(.scalar(String.self))),
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("name", type: .nonNull(.scalar(String.self))),
        GraphQLField("date", type: .nonNull(.scalar(String.self))),
        GraphQLField("type", type: .nonNull(.scalar(HistoricalEventType.self))),
        GraphQLField("description", type: .scalar(String.self)),
      ]

      public var snapshot: Snapshot

      public init(snapshot: Snapshot) {
        self.snapshot = snapshot
      }

      public init(id: String, name: String, date: String, type: HistoricalEventType, description: String? = nil) {
        self.init(snapshot: ["__typename": "HistoricalEvent", "id": id, "name": name, "date": date, "type": type, "description": description])
      }

      public var __typename: String {
        get {
          return snapshot["__typename"]! as! String
        }
        set {
          snapshot.updateValue(newValue, forKey: "__typename")
        }
      }

      public var id: String {
        get {
          return snapshot["id"]! as! String
        }
        set {
          snapshot.updateValue(newValue, forKey: "id")
        }
      }

      public var name: String {
        get {
          return snapshot["name"]! as! String
        }
        set {
          snapshot.updateValue(newValue, forKey: "name")
        }
      }

      public var date: String {
        get {
          return snapshot["date"]! as! String
        }
        set {
          snapshot.updateValue(newValue, forKey: "date")
        }
      }

      public var type: HistoricalEventType {
        get {
          return snapshot["type"]! as! HistoricalEventType
        }
        set {
          snapshot.updateValue(newValue, forKey: "type")
        }
      }

      public var description: String? {
        get {
          return snapshot["description"] as? String
        }
        set {
          snapshot.updateValue(newValue, forKey: "description")
        }
      }

      public var fragments: Fragments {
        get {
          return Fragments(snapshot: snapshot)
        }
        set {
          snapshot += newValue.snapshot
        }
      }

      public struct Fragments {
        public var snapshot: Snapshot

        public var fullHistoricalEvent: FullHistoricalEvent {
          get {
            return FullHistoricalEvent(snapshot: snapshot)
          }
          set {
            snapshot += newValue.snapshot
          }
        }

        public var historicalEventContent: HistoricalEventContent {
          get {
            return HistoricalEventContent(snapshot: snapshot)
          }
          set {
            snapshot += newValue.snapshot
          }
        }
      }
    }
  }
}

public final class DeleteHistoricalEventMutation: GraphQLMutation {
  public static let operationString =
    "mutation DeleteHistoricalEvent($id: String!) {\n  deleteEvent(id: $id) {\n    __typename\n    id\n  }\n}"

  public var id: String

  public init(id: String) {
    self.id = id
  }

  public var variables: GraphQLMap? {
    return ["id": id]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes = ["Mutation"]

    public static let selections: [GraphQLSelection] = [
      GraphQLField("deleteEvent", arguments: ["id": GraphQLVariable("id")], type: .nonNull(.object(DeleteEvent.selections))),
    ]

    public var snapshot: Snapshot

    public init(snapshot: Snapshot) {
      self.snapshot = snapshot
    }

    public init(deleteEvent: DeleteEvent) {
      self.init(snapshot: ["__typename": "Mutation", "deleteEvent": deleteEvent.snapshot])
    }

    public var deleteEvent: DeleteEvent {
      get {
        return DeleteEvent(snapshot: snapshot["deleteEvent"]! as! Snapshot)
      }
      set {
        snapshot.updateValue(newValue.snapshot, forKey: "deleteEvent")
      }
    }

    public struct DeleteEvent: GraphQLSelectionSet {
      public static let possibleTypes = ["HistoricalEvent"]

      public static let selections: [GraphQLSelection] = [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("id", type: .nonNull(.scalar(String.self))),
      ]

      public var snapshot: Snapshot

      public init(snapshot: Snapshot) {
        self.snapshot = snapshot
      }

      public init(id: String) {
        self.init(snapshot: ["__typename": "HistoricalEvent", "id": id])
      }

      public var __typename: String {
        get {
          return snapshot["__typename"]! as! String
        }
        set {
          snapshot.updateValue(newValue, forKey: "__typename")
        }
      }

      public var id: String {
        get {
          return snapshot["id"]! as! String
        }
        set {
          snapshot.updateValue(newValue, forKey: "id")
        }
      }
    }
  }
}

public struct BriefHistoricalEvent: GraphQLFragment {
  public static let fragmentString =
    "fragment BriefHistoricalEvent on HistoricalEvent {\n  __typename\n  id\n  name\n  date\n  type\n}"

  public static let possibleTypes = ["HistoricalEvent"]

  public static let selections: [GraphQLSelection] = [
    GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
    GraphQLField("id", type: .nonNull(.scalar(String.self))),
    GraphQLField("name", type: .nonNull(.scalar(String.self))),
    GraphQLField("date", type: .nonNull(.scalar(String.self))),
    GraphQLField("type", type: .nonNull(.scalar(HistoricalEventType.self))),
  ]

  public var snapshot: Snapshot

  public init(snapshot: Snapshot) {
    self.snapshot = snapshot
  }

  public init(id: String, name: String, date: String, type: HistoricalEventType) {
    self.init(snapshot: ["__typename": "HistoricalEvent", "id": id, "name": name, "date": date, "type": type])
  }

  public var __typename: String {
    get {
      return snapshot["__typename"]! as! String
    }
    set {
      snapshot.updateValue(newValue, forKey: "__typename")
    }
  }

  public var id: String {
    get {
      return snapshot["id"]! as! String
    }
    set {
      snapshot.updateValue(newValue, forKey: "id")
    }
  }

  public var name: String {
    get {
      return snapshot["name"]! as! String
    }
    set {
      snapshot.updateValue(newValue, forKey: "name")
    }
  }

  public var date: String {
    get {
      return snapshot["date"]! as! String
    }
    set {
      snapshot.updateValue(newValue, forKey: "date")
    }
  }

  public var type: HistoricalEventType {
    get {
      return snapshot["type"]! as! HistoricalEventType
    }
    set {
      snapshot.updateValue(newValue, forKey: "type")
    }
  }
}

public struct HistoricalEventContent: GraphQLFragment {
  public static let fragmentString =
    "fragment HistoricalEventContent on HistoricalEvent {\n  __typename\n  name\n  date\n  type\n  description\n}"

  public static let possibleTypes = ["HistoricalEvent"]

  public static let selections: [GraphQLSelection] = [
    GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
    GraphQLField("name", type: .nonNull(.scalar(String.self))),
    GraphQLField("date", type: .nonNull(.scalar(String.self))),
    GraphQLField("type", type: .nonNull(.scalar(HistoricalEventType.self))),
    GraphQLField("description", type: .scalar(String.self)),
  ]

  public var snapshot: Snapshot

  public init(snapshot: Snapshot) {
    self.snapshot = snapshot
  }

  public init(name: String, date: String, type: HistoricalEventType, description: String? = nil) {
    self.init(snapshot: ["__typename": "HistoricalEvent", "name": name, "date": date, "type": type, "description": description])
  }

  public var __typename: String {
    get {
      return snapshot["__typename"]! as! String
    }
    set {
      snapshot.updateValue(newValue, forKey: "__typename")
    }
  }

  public var name: String {
    get {
      return snapshot["name"]! as! String
    }
    set {
      snapshot.updateValue(newValue, forKey: "name")
    }
  }

  public var date: String {
    get {
      return snapshot["date"]! as! String
    }
    set {
      snapshot.updateValue(newValue, forKey: "date")
    }
  }

  public var type: HistoricalEventType {
    get {
      return snapshot["type"]! as! HistoricalEventType
    }
    set {
      snapshot.updateValue(newValue, forKey: "type")
    }
  }

  public var description: String? {
    get {
      return snapshot["description"] as? String
    }
    set {
      snapshot.updateValue(newValue, forKey: "description")
    }
  }
}

public struct FullHistoricalEvent: GraphQLFragment {
  public static let fragmentString =
    "fragment FullHistoricalEvent on HistoricalEvent {\n  __typename\n  id\n  ...HistoricalEventContent\n}"

  public static let possibleTypes = ["HistoricalEvent"]

  public static let selections: [GraphQLSelection] = [
    GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
    GraphQLField("id", type: .nonNull(.scalar(String.self))),
    GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
    GraphQLField("name", type: .nonNull(.scalar(String.self))),
    GraphQLField("date", type: .nonNull(.scalar(String.self))),
    GraphQLField("type", type: .nonNull(.scalar(HistoricalEventType.self))),
    GraphQLField("description", type: .scalar(String.self)),
  ]

  public var snapshot: Snapshot

  public init(snapshot: Snapshot) {
    self.snapshot = snapshot
  }

  public init(id: String, name: String, date: String, type: HistoricalEventType, description: String? = nil) {
    self.init(snapshot: ["__typename": "HistoricalEvent", "id": id, "name": name, "date": date, "type": type, "description": description])
  }

  public var __typename: String {
    get {
      return snapshot["__typename"]! as! String
    }
    set {
      snapshot.updateValue(newValue, forKey: "__typename")
    }
  }

  public var id: String {
    get {
      return snapshot["id"]! as! String
    }
    set {
      snapshot.updateValue(newValue, forKey: "id")
    }
  }

  public var name: String {
    get {
      return snapshot["name"]! as! String
    }
    set {
      snapshot.updateValue(newValue, forKey: "name")
    }
  }

  public var date: String {
    get {
      return snapshot["date"]! as! String
    }
    set {
      snapshot.updateValue(newValue, forKey: "date")
    }
  }

  public var type: HistoricalEventType {
    get {
      return snapshot["type"]! as! HistoricalEventType
    }
    set {
      snapshot.updateValue(newValue, forKey: "type")
    }
  }

  public var description: String? {
    get {
      return snapshot["description"] as? String
    }
    set {
      snapshot.updateValue(newValue, forKey: "description")
    }
  }

  public var fragments: Fragments {
    get {
      return Fragments(snapshot: snapshot)
    }
    set {
      snapshot += newValue.snapshot
    }
  }

  public struct Fragments {
    public var snapshot: Snapshot

    public var historicalEventContent: HistoricalEventContent {
      get {
        return HistoricalEventContent(snapshot: snapshot)
      }
      set {
        snapshot += newValue.snapshot
      }
    }
  }
}
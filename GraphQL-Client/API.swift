//  This file was automatically generated and should not be edited.

import Apollo

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

public final class GetAllEventsQuery: GraphQLQuery {
  public static let operationString =
    "query GetAllEvents {\n  allEvents {\n    __typename\n    name\n    date\n    type\n  }\n}"

  public init() {
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes = ["Query"]

    public static let selections: [GraphQLSelection] = [
      GraphQLField("allEvents", type: .nonNull(.list(.nonNull(.object(AllEvent.selections))))),
    ]

    public var snapshot: Snapshot

    public init(snapshot: Snapshot) {
      self.snapshot = snapshot
    }

    public init(allEvents: [AllEvent]) {
      self.init(snapshot: ["__typename": "Query", "allEvents": allEvents.map { $0.snapshot }])
    }

    public var allEvents: [AllEvent] {
      get {
        return (snapshot["allEvents"] as! [Snapshot]).map { AllEvent(snapshot: $0) }
      }
      set {
        snapshot.updateValue(newValue.map { $0.snapshot }, forKey: "allEvents")
      }
    }

    public struct AllEvent: GraphQLSelectionSet {
      public static let possibleTypes = ["HistoricalEvent"]

      public static let selections: [GraphQLSelection] = [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("name", type: .nonNull(.scalar(String.self))),
        GraphQLField("date", type: .nonNull(.scalar(String.self))),
        GraphQLField("type", type: .nonNull(.scalar(HistoricalEventType.self))),
      ]

      public var snapshot: Snapshot

      public init(snapshot: Snapshot) {
        self.snapshot = snapshot
      }

      public init(name: String, date: String, type: HistoricalEventType) {
        self.init(snapshot: ["__typename": "HistoricalEvent", "name": name, "date": date, "type": type])
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
    }
  }
}
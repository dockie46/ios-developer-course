protocol EventType {
    var name: String { get }
}


protocol AnalyticEvent {
    associatedtype E: EventType
    var type: E { get }
    var parameters: [String: Any] { get }
}
//
extension AnalyticEvent {
    var name: String {
        return type.name
    }
}

struct ScreenViewEventType: EventType {
    var name: String
}

struct UserActionEventType: EventType {
    var name: String
}

struct ScreenViewEvent: AnalyticEvent {
    typealias E = ScreenViewEventType
    var type: E
    var parameters: [String: Any]
}

struct UserActionEvent: AnalyticEvent {
    typealias E = UserActionEventType
    var type: E
    var parameters: [String: Any]
}

protocol AnalyticsService {
    func logEvent<E: AnalyticEvent>(_ event: E)
}

class ConsoleAnalyticsService: AnalyticsService {
    var logs: [String] = []
    
    func logEvent<E: AnalyticEvent>(_ event: E) {
        
        let log = "Event: \(event.name), Parameters: \(event.parameters)"
        print(log)
        logs.append(log)
    }
}

let service = ConsoleAnalyticsService()
let screenViewEvent = ScreenViewEvent(type: ScreenViewEventType(name: "MainScreen"), parameters: ["Screen": "Main"])
let userActionEvent = UserActionEvent(type: UserActionEventType(name: "ButtonClicked"), parameters: ["Button": "Submit"])

service.logEvent(screenViewEvent)
service.logEvent(userActionEvent)

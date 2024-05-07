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
    
    var type: ScreenViewEventType
    var parameters: [String: Any]
}

struct UserActionEvent: AnalyticEvent {
    typealias E = UserActionEventType
    
    var type: UserActionEventType
    var parameters: [String: Any]
}

protocol AnalyticsService {
    func logEvent<E: AnalyticEvent>(_ event: E)
}

class ConsoleAnalyticsService: AnalyticsService {
    
    var logs: [any AnalyticEvent] = []
    
    func logEvent<E: AnalyticEvent>(_ event: E) {
        
        print("Event: \(event.name), Parameters: \(event.parameters)")
        logs.append(event)
    }
}

let service = ConsoleAnalyticsService()
let screenViewEvent = ScreenViewEvent(type: ScreenViewEventType(name: "MainScreen"), parameters: ["Screen": "Main"])
let userActionEvent = UserActionEvent(type: UserActionEventType(name: "ButtonClicked"), parameters: ["Button": "Submit"])

service.logEvent(screenViewEvent)
service.logEvent(userActionEvent)

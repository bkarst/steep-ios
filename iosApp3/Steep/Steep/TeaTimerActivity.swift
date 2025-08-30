import ActivityKit
import Foundation

struct TeaTimerActivityAttributes: ActivityAttributes {
    public typealias TeaTimerStatus = ContentState
    
    public struct ContentState: Codable, Hashable {
        var teaName: String
        var infusion: Int
        var remainingSeconds: Int
        var totalSeconds: Int
        var isComplete: Bool
        var endTime: Date
    }
    
    var teaName: String
    var infusion: Int
}
import Foundation
import AppIntents

// App Intent for when user stops the alarm
struct StopTeaTimerAlarmIntent: AppIntent {
    static var title: LocalizedStringResource = "Stop Tea Timer"
    
    func perform() async throws -> some IntentResult {
        // Handle stopping the alarm - could trigger app opening
        print("✅ Tea timer alarm stopped via AlarmKit")
        return .result()
    }
}

// App Intent for when user wants to open the app from alarm
struct OpenTeaTimerAppIntent: AppIntent {
    static var title: LocalizedStringResource = "Open Tea Timer App"
    
    func perform() async throws -> some IntentResult {
        // Handle opening the app
        print("📱 Opening tea timer app from alarm")
        return .result()
    }
}
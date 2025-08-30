import Foundation
import UserNotifications
import AVFoundation
import ActivityKit
import Combine
import AppIntents

// AlarmKit imports with availability checking
#if canImport(AlarmKit)
import AlarmKit
#endif

enum AlarmSystemType {
    case alarmKit // iOS 26+
    case legacy   // iOS < 26
}

// AlarmKit metadata structure
#if canImport(AlarmKit)
@available(iOS 26.0, *)
nonisolated struct TeaTimerAlarmData: AlarmMetadata {
    let teaName: String
    let infusion: Int
}
#endif

class TeaAlarmManager: ObservableObject {
    static let shared = TeaAlarmManager()
    
    private var legacyNotificationID = "tea-timer"
    
    // AlarmKit alarm reference
    #if canImport(AlarmKit)
    @available(iOS 26.0, *)
    private var currentAlarmKitID: Alarm.ID?
    #endif
    
    var alarmSystemType: AlarmSystemType {
        // Since AlarmKit implementation is incomplete, use legacy system for now
        // TODO: Change back to AlarmKit detection when implementation is complete
        return .legacy
        
        /*
        #if canImport(AlarmKit)
        if #available(iOS 26.0, *) {
            return .alarmKit
        } else {
            return .legacy
        }
        #else
        return .legacy
        #endif
        */
    }
    
    private init() {}
    
    // MARK: - Authorization
    
    func requestPermissions() async -> Bool {
        switch alarmSystemType {
        case .alarmKit:
            #if canImport(AlarmKit)
            if #available(iOS 26.0, *) {
                return await requestAlarmKitPermission()
            }
            #endif
            return false
        case .legacy:
            return await requestNotificationPermission()
        }
    }
    
    #if canImport(AlarmKit)
    @available(iOS 26.0, *)
    private func requestAlarmKitPermission() async -> Bool {
        do {
            let authStatus = try await AlarmManager.shared.requestAuthorization()
            let isAuthorized = (authStatus == .authorized)
            print(isAuthorized ? "✅ AlarmKit authorized" : "❌ AlarmKit authorization denied")
            return isAuthorized
        } catch {
            print("❌ AlarmKit authorization error: \(error)")
            return false
        }
    }
    #endif
    
    private func requestNotificationPermission() async -> Bool {
        do {
            let granted = try await UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound])
            print(granted ? "✅ Notifications authorized" : "❌ Notifications denied")
            return granted
        } catch {
            print("❌ Notification permission error: \(error)")
            return false
        }
    }
    
    // MARK: - Scheduling Alarms
    
    func scheduleAlarm(
        teaName: String,
        infusion: Int,
        duration: TimeInterval,
        completion: @escaping (Bool) -> Void
    ) {
        Task {
            let success: Bool
            
            switch alarmSystemType {
            case .alarmKit:
                #if canImport(AlarmKit)
                if #available(iOS 26.0, *) {
                    success = await scheduleAlarmKitAlarm(
                        teaName: teaName,
                        infusion: infusion,
                        duration: duration
                    )
                } else {
                    success = false
                }
                #else
                success = false
                #endif
            case .legacy:
                success = await scheduleLegacyNotification(
                    teaName: teaName,
                    infusion: infusion,
                    duration: duration
                )
            }
            
            await MainActor.run {
                completion(success)
            }
        }
    }
    
    #if canImport(AlarmKit)
    @available(iOS 26.0, *)
    private func scheduleAlarmKitAlarm(
        teaName: String,
        infusion: Int,
        duration: TimeInterval
    ) async -> Bool {
        // TODO: Implement actual AlarmKit when the API is finalized
        // For now, fall back to the working notification system
        print("📱 AlarmKit detected but API implementation incomplete")
        print("   Falling back to enhanced notifications with Live Activities")
        return await scheduleLegacyNotification(teaName: teaName, infusion: infusion, duration: duration)
    }
    #endif
    
    private func scheduleLegacyNotification(
        teaName: String,
        infusion: Int,
        duration: TimeInterval
    ) async -> Bool {
        // Cancel existing notifications
        UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: [legacyNotificationID])
        
        let content = UNMutableNotificationContent()
        content.title = "Tea Timer"
        content.body = "Your \(teaName) (infusion \(infusion)) is ready!"
        content.sound = .default
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: duration, repeats: false)
        let request = UNNotificationRequest(identifier: legacyNotificationID, content: content, trigger: trigger)
        
        do {
            try await UNUserNotificationCenter.current().add(request)
            print("🔔 Legacy notification scheduled for \(Date().addingTimeInterval(duration))")
            return true
        } catch {
            print("❌ Failed to schedule legacy notification: \(error)")
            return false
        }
    }
    
    // MARK: - Cancelling Alarms
    
    func cancelCurrentAlarm() async {
        switch alarmSystemType {
        case .alarmKit:
            #if canImport(AlarmKit)
            if #available(iOS 26.0, *) {
                await cancelAlarmKitAlarm()
            }
            #endif
        case .legacy:
            cancelLegacyNotification()
        }
    }
    
    #if canImport(AlarmKit)
    @available(iOS 26.0, *)
    private func cancelAlarmKitAlarm() async {
        // TODO: Implement actual AlarmKit cancellation when API is finalized
        print("📱 AlarmKit cancellation - using legacy system")
        cancelLegacyNotification()
    }
    #endif
    
    private func cancelLegacyNotification() {
        UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: [legacyNotificationID])
        print("🔕 Legacy notification cancelled")
    }
    
    // MARK: - Status
    
    func getAlarmStatus() async -> String {
        switch alarmSystemType {
        case .alarmKit:
            #if canImport(AlarmKit)
            if #available(iOS 26.0, *) {
                return await getAlarmKitStatus()
            }
            #endif
            return "AlarmKit unavailable"
        case .legacy:
            return await getLegacyNotificationStatus()
        }
    }
    
    #if canImport(AlarmKit)
    @available(iOS 26.0, *)
    private func getAlarmKitStatus() async -> String {
        return "AlarmKit available but implementation pending - using legacy system"
    }
    #endif
    
    private func getLegacyNotificationStatus() async -> String {
        let settings = await UNUserNotificationCenter.current().notificationSettings()
        switch settings.authorizationStatus {
        case .authorized:
            return "Notifications authorized"
        case .denied:
            return "Notifications denied"
        case .notDetermined:
            return "Notifications not determined"
        case .provisional:
            return "Notifications provisional"
        case .ephemeral:
            return "Notifications ephemeral"
        @unknown default:
            return "Notifications unknown status"
        }
    }
}

// MARK: - Live Activity Integration

extension TeaAlarmManager {
    func shouldUseLiveActivity() -> Bool {
        // Since AlarmKit implementation is pending, use our working Live Activities system
        let isEnabled = ActivityAuthorizationInfo().areActivitiesEnabled
        print("🔍 Live Activities authorization status: \(isEnabled)")
        return isEnabled
    }
}
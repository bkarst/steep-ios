import Foundation
import UserNotifications
import AVFoundation
import ActivityKit
import Combine

// AlarmKit imports with availability checking
#if canImport(AlarmKit)
import AlarmKit
#endif

enum AlarmSystemType {
    case alarmKit // iOS 26+
    case legacy   // iOS < 26
}

class TeaAlarmManager: ObservableObject {
    static let shared = TeaAlarmManager()
    
    private var currentAlarmID: String?
    private var legacyNotificationID = "tea-timer"
    
    var alarmSystemType: AlarmSystemType {
        #if canImport(AlarmKit)
        if #available(iOS 26.0, *) {
            return .alarmKit
        } else {
            return .legacy
        }
        #else
        return .legacy
        #endif
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
        // TODO: Update with actual AlarmKit API when available
        // For now, fall back to notifications
        print("📱 AlarmKit available but API needs implementation")
        return await requestNotificationPermission()
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
        // TODO: Implement actual AlarmKit scheduling when API is available
        // For now, fall back to enhanced notifications
        print("📱 AlarmKit scheduling - falling back to enhanced notifications")
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
        // TODO: Implement actual AlarmKit cancellation when API is available
        print("📱 AlarmKit cancellation - falling back to legacy")
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
        // TODO: Implement actual AlarmKit status when API is available
        let legacyStatus = await getLegacyNotificationStatus()
        return "AlarmKit available - using: \(legacyStatus)"
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
        // Since we're falling back to notifications for AlarmKit implementation,
        // we should still use our Live Activities for visual feedback
        let isEnabled = ActivityAuthorizationInfo().areActivitiesEnabled
        print("🔍 Live Activities authorization status: \(isEnabled)")
        return isEnabled
    }
}
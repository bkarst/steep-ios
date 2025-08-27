//
//  ContentView.swift
//  Steep
//
//  Created by Ben on 8/26/25.
//

import SwiftUI
import UserNotifications

struct ContentView: View {
    private let mainFont = "Georgia"
    
    @State private var steepNumbers: [Int] = [1, 2, 3, 4, 5]
    @State private var currentSteepIndex: Int = 1
    @State private var remainingTime: Int = 10 // 2 minutes in seconds
    @State private var isTimerRunning: Bool = false
    @State private var timer: Timer?
    
    private var formattedTime: String {
        let minutes = remainingTime / 60
        let seconds = remainingTime % 60
        return String(format: "%d:%02d", minutes, seconds)
    }
    
    private func requestNotificationPermission() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
            DispatchQueue.main.async {
                if let error = error {
                    print("Notification permission error: \(error)")
                } else if granted {
                    print("Notification permission granted")
                } else {
                    print("Notification permission denied")
                }
            }
        }
    }
    
    private func startTimer() {
        isTimerRunning = true
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { _ in
            if remainingTime > 0 {
                remainingTime -= 1
            } else {
                stopTimer()
                sendNotification()
            }
        }
    }
    
    private func stopTimer() {
        timer?.invalidate()
        timer = nil
        isTimerRunning = false
    }
    
    private func resetTimer() {
        stopTimer()
        remainingTime = 120
    }
    
    private func sendNotification() {
        let content = UNMutableNotificationContent()
        content.title = "🍵 Tea Ready!"
        content.body = "Your tea has finished steeping. Time to enjoy!"
        content.sound = UNNotificationSound.default
        content.badge = 1
        
        // Use immediate trigger for reliable delivery in simulator
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 0.1, repeats: false)
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request) { error in
            if let error = error {
                print("Notification error: \(error)")
            } else {
                print("Notification scheduled successfully")
            }
        }
    }
    
    var body: some View {
        Color(red: 0.96, green: 0.94, blue: 0.88)
            .ignoresSafeArea(.all)
            .overlay {
                VStack(spacing: 40) {
                    // Tea cup icon and title section
                    VStack(spacing: 16) {
                        // Tea cup icon placeholder (using SF Symbol as substitute)
                        Image(systemName: "cup.and.saucer.fill")
                            .font(.system(size: 40))
                            .foregroundColor(.brown.opacity(0.7))
                        
                        // Tea title
                        Text("Green (Jasmine)")
                            .font(.custom(mainFont, size: 32))
                            .foregroundColor(Color(red: 0.65, green: 0.35, blue: 0.15))
                    }
                    
                    // Circular timer display with swipable TabView
                    VStack(spacing: 20) {
                        TabView(selection: $currentSteepIndex) {
                            ForEach(Array(steepNumbers.enumerated()), id: \.offset) { index, number in
                                Text("\(number)")
                                    .font(.custom(mainFont, size: 120))
                                    .foregroundColor(Color(red: 0.65, green: 0.35, blue: 0.15))
                                    .tag(index)
                            }
                        }
                        .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
                        .frame(height: 140)
                        
                        // Step indicator dots
                        HStack(spacing: 12) {
                            ForEach(Array(steepNumbers.enumerated()), id: \.offset) { index, _ in
                                Circle()
                                    .fill(index == currentSteepIndex ? 
                                          Color(red: 0.65, green: 0.35, blue: 0.15) : 
                                          Color(red: 0.8, green: 0.6, blue: 0.4))
                                    .frame(width: 12, height: 12)
                            }
                        }
                    }
                    
                    // Countdown timer
                    Text(formattedTime)
                        .font(.custom(mainFont, size: 64))
                        .foregroundColor(Color(red: 0.65, green: 0.35, blue: 0.15))
                    
                    // Begin Steep button
                    Button(action: {
                        if isTimerRunning {
                            stopTimer()
                        } else {
                            if remainingTime <= 0 {
                                resetTimer()
                            }
                            startTimer()
                        }
                    }) {
                        Text(isTimerRunning ? "Stop Steep" : (remainingTime <= 0 ? "Reset Timer" : "Begin Steep"))
                            .font(.custom(mainFont, size: 24))
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .frame(height: 60)
                            .background(Color(red: 0.73, green: 0.45, blue: 0.25))
                            .cornerRadius(16)
                            .padding(.horizontal, 40)
                    }
                    
                    // Temperature range
                    Text("170-180 F")
                        .font(.custom("EBGaramond", size: 28))
                        .foregroundColor(Color(red: 0.65, green: 0.35, blue: 0.15))
                    
                    Spacer()
                }
                .padding(.top, 60)
            }
            .onAppear {
                requestNotificationPermission()
            }
    }
}

#Preview {
    ContentView()
}

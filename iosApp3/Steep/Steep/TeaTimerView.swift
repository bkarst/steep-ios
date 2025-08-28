//
//  TeaTimerView.swift
//  Steep
//
//  Created by Ben on 8/27/25.
//

import SwiftUI
import Foundation // For Timer
import UserNotifications
import AVFoundation
import AudioToolbox
import UIKit

// MARK: - Color Utilities
func rgbToAppleColor(red: Int, green: Int, blue: Int) -> Color {
    return Color(red: Double(red) / 255.0, green: Double(green) / 255.0, blue: Double(blue) / 255.0)
}

extension TeaVariety: Equatable {
    static func == (lhs: TeaVariety, rhs: TeaVariety) -> Bool {
        lhs.id == rhs.id
    }
}

extension TeaVariety {
    var name: String {
        return tea_name
    }
    
    var temperature: String {
        let temp = steep_instructions.first?.temperature
        return "\(Int(temp?.minimum ?? 0))-\(Int(temp?.maximum ?? 0))°F"
    }
    
    var dosage: String {
        let d = tsp_per_8_oz
        return d.minimum == d.maximum ? "\(d.minimum) tsp" : "\(d.minimum)-\(d.maximum) tsp"
    }
    
    var description: String {
        overall_tea_description
    }
    
    var backgroundImageName: String {
        switch main_tea_type {
        case "Green":
            return "green-tea"
        case "Black":
            return "black-tea"
        case "Oolong":
            return "oolong-tea"
        case "Pu-erh":
            return "puer-eh"
        case "Yellow":
            return "yellow-tea"
        case "White":
            return "white-tea"
        case "Herbal":
            return "herbal-tea"
        default:
            return "black-tea"
        }
    }
    
    func steepingTime(for infusion: Int) -> Int {
        let adjustedInfusion = max(1, infusion)
        if let instruction = steep_instructions.first(where: { $0.steep_number == adjustedInfusion }) {
            return Int(instruction.duration.minimum * 60)
        } else if let last = steep_instructions.last {
            // Use the last one if infusion exceeds
            return Int(last.duration.minimum * 60)
        } else {
            return 0
        }
    }
    
    func steepingDuration(for infusion: Int) -> ValueRange {
        let adjustedInfusion = max(1, infusion)
        if let instruction = steep_instructions.first(where: { $0.steep_number == adjustedInfusion }) {
            return instruction.duration
        } else if let last = steep_instructions.last {
            // Use the last one if infusion exceeds
            return last.duration
        } else {
            return ValueRange(minimum: 0, maximum: 0)
        }
    }
}

struct TeaTimerView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @State private var infusion = 1
    @State private var seconds = 0
    @State private var initialSeconds = 0
    @State private var paused = true
    @State private var isComplete = false
    @State private var showingTeaSelection = false
    @State private var showingTimeSelection = false
    @State private var selectedSeconds: Int = 0
    @State private var selectedTea = allTeas.first { $0.tea_name == "English Breakfast Tea" }!
    @State private var previousTea: TeaVariety?
    @State private var previousInfusion: Int?
    @State private var timer: Timer? = nil
    @State private var alarmTimer: Timer? = nil
    @State private var audioPlayer: AVAudioPlayer?
    @State private var timerStartTime: Date?
    @State private var backgroundTime: Date?
    
    struct TeaSelectionSheet: View {
        @Binding var selectedTea: TeaVariety
        @Environment(\.dismiss) private var dismiss
        @State private var searchText = ""  // New state for search input
        
        // Match the tea timer colors
        private let paper = Color(red: 1.00, green: 0.97, blue: 0.86)
        private let teaOrange = Color(red: 0.73, green: 0.37, blue: 0.09)
        private let creamInk = Color(red: 1.00, green: 0.94, blue: 0.80)
        
        var body: some View {
            NavigationView {
                ZStack {
                    paper.ignoresSafeArea()
                    
                    List {
                        ForEach(groupedTeas, id: \.0) { teaType, teas in
                            Section {
                                ForEach(teas) { tea in
                                    Button(action: {
                                        selectedTea = tea
                                        dismiss()
                                    }) {
                                        HStack {
                                            VStack(alignment: .leading, spacing: 4) {
                                                Text(tea.name)
                                                    .font(.system(size: 20, weight: .regular, design: .serif))
                                                    .foregroundColor(teaOrange)
                                                
                                                HStack {
                                                    Text(tea.temperature)
                                                        .font(.system(size: 16, weight: .regular, design: .serif))
                                                        .foregroundColor(teaOrange.opacity(0.75))
                                                    
                                                    Text("•")
                                                        .foregroundColor(teaOrange.opacity(0.5))
                                                    
                                                    Text("\(tea.dosage) per 8 oz")
                                                        .font(.system(size: 16, weight: .regular, design: .serif))
                                                        .foregroundColor(teaOrange.opacity(0.75))
                                                }
                                            }
                                            
                                            Spacer()
                                            
                                            if tea == selectedTea {
                                                Image(systemName: "checkmark")
                                                    .foregroundColor(teaOrange)
                                                    .font(.system(size: 18, weight: .semibold))
                                            }
                                        }
                                        .padding(.vertical, 8)
                                        .padding(.horizontal, 16)
                                        .contentShape(Rectangle())
                                    }
                                    .buttonStyle(.plain)
                                    .listRowBackground(Color.clear)
                                }
                            } header: {
                                Text(teaType)
                                    .font(.system(size: 18, weight: .semibold, design: .serif))
                                    .foregroundColor(teaOrange)
                                    .textCase(.uppercase)
                                    .padding(.top, 8)
                            }
                        }
                    }
                    .listStyle(.plain)
                    .scrollContentBackground(.hidden)
                }
                .searchable(text: $searchText)  // Adds the search bar
                .navigationTitle("Select Tea")
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button("Done") {
                            dismiss()
                        }
                        .foregroundColor(teaOrange)
                        .font(.system(size: 18, weight: .regular, design: .serif))
                    }
                }
            }
        }
        
        // Computed property to filter teas based on search text
        private var filteredTeas: [TeaVariety] {
            if searchText.isEmpty {
                return allTeas
            } else {
                return allTeas.filter { $0.name.lowercased().contains(searchText.lowercased()) }
            }
        }
        
        // Computed property to group filtered teas by main tea type
        private var groupedTeas: [(String, [TeaVariety])] {
            let grouped = Dictionary(grouping: filteredTeas) { $0.main_tea_type }
            let sortedKeys = ["Green", "Black", "Oolong", "Pu-erh", "Yellow", "Herbal"] // Custom order
            return sortedKeys.compactMap { key in
                guard let teas = grouped[key], !teas.isEmpty else { return nil }
                return (key, teas.sorted { $0.tea_name < $1.tea_name })
            }
        }
    }
    
    struct TimeSelectionSheet: View {
        @Binding var selectedSeconds: Int
        let minSeconds: Int
        let maxSeconds: Int
        @Environment(\.dismiss) private var dismiss
        @State private var localSeconds: Int
        
        // Match the tea timer colors
        private let paper = Color(red: 1.00, green: 0.97, blue: 0.86)
        private let teaOrange = Color(red: 0.73, green: 0.37, blue: 0.09)
        
        init(selectedSeconds: Binding<Int>, minSeconds: Int, maxSeconds: Int) {
            self._selectedSeconds = selectedSeconds
            self.minSeconds = minSeconds
            self.maxSeconds = maxSeconds
            self._localSeconds = State(initialValue: selectedSeconds.wrappedValue)
        }
        
        var body: some View {
            NavigationView {
                ZStack {
                    paper.ignoresSafeArea()
                    
                    Picker("Steep Time", selection: $localSeconds) {
                        ForEach(Array(stride(from: minSeconds, through: maxSeconds, by: 30)), id: \.self) { seconds in
                            let minutes = seconds / 60
                            let remainingSeconds = seconds % 60
                            if remainingSeconds == 0 {
                                Text("\(minutes) min").tag(seconds)
                            } else {
                                Text("\(minutes):\(String(format: "%02d", remainingSeconds))").tag(seconds)
                            }
                        }
                    }
                    .pickerStyle(.wheel)
                    .labelsHidden()
                }
                .navigationTitle("Select Time")
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        Button("Cancel") {
                            dismiss()
                        }
                        .foregroundColor(teaOrange)
                        .font(.system(size: 18, weight: .regular, design: .serif))
                    }
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button("Done") {
                            selectedSeconds = localSeconds
                            dismiss()
                        }
                        .foregroundColor(teaOrange)
                        .font(.system(size: 18, weight: .regular, design: .serif))
                    }
                }
            }
        }
    }
    
    // MARK: - Global Colors
    private let paper      = Color(red: 1.00, green: 0.97, blue: 0.86) // main background
    private let teaOrange  = Color(red: 0.73, green: 0.37, blue: 0.09)
    private let olive      = Color(red: 0.62, green: 0.62, blue: 0.46)
    private let creamInk   = Color(red: 1.00, green: 0.94, blue: 0.80)
    private let lightButtonBackground = Color(red: 0.98, green: 0.96, blue: 0.90)
//    private let darkForestGreen = Color(red: 0.0862, green: 0.364, blue: 0.1372)
    let myColor = rgbToAppleColor(red: 17, green: 69, blue: 27).opacity(0.7)
    private let darkForestGreen = rgbToAppleColor(red: 17, green: 69, blue: 27)
    private let darkForestGreenDisabled = Color(red: 0.73, green: 0.37, blue: 0.09).opacity(0.18)
    private let button_shadow_opacity: Double = 0.15
    
    // MARK: - Tea Name Button
    private let tea_name_max_text_size: CGFloat = 34
    private let tea_name_padding: CGFloat = 0
    private let tea_name_horizontal_padding: CGFloat = 30
    private let tea_name_button_background = Color(red: 0.73, green: 0.37, blue: 0.09).opacity(0.04)
    
    // MARK: - Timer Button
    private let timer_button_background_color =  Color(red: 0.73, green: 0.37, blue: 0.09)
    private let timer_text_size: CGFloat = 62
    private let timer_button_background = Color(red: 0.73, green: 0.37, blue: 0.09).opacity(0.04)
    private let timer_button_padding_vertical: CGFloat = 4
    
    // MARK: - Infusion Controls
    private let plus_minus_button_size: CGFloat = 80
    private let portion_text_size: CGFloat = 40
    private let infusion_text_size: CGFloat = 22
    private let infusion_text_to_controls_spacing: CGFloat = -0
    
    // MARK: - Control Buttons (Begin Steep, Reset, etc.)
    private let steep_button_text_size: CGFloat = 27
    private let steep_button_icon_size: CGFloat = 27
    private let steep_button_text_icon_spacing: CGFloat = 14
    private let button_text_padding_vertical: CGFloat = 28
    private let button_text_padding_horizontal: CGFloat = 38
    private let control_button_corner_radius: CGFloat = 16
    private let steep_timer_spacing: CGFloat = 16
    private let steep_button_bottom_spacing: CGFloat = 40
    
    // MARK: - Description Text
    private let description_text_size: CGFloat = 18
    private let description_gutter_size: CGFloat = 48
    private let description_top_padding: CGFloat = 28
    private let description_bottom_padding: CGFloat = 0
    
    // MARK: - Info Strip (Temperature & Dosage)
    private let infoStrip  = Color.white.opacity(0.55)
    
    // MARK: - Layout & Spacing
    private let title_strip_height: CGFloat = 70
    private let top_strip_top_spacing: CGFloat = 12
    private let light_button_corner_radius: CGFloat = 8
    
    // MARK: - Leaf Background Image
    private let leaf_image_top_offset: CGFloat = -90
    private let leaf_image_trailing_padding: CGFloat = 0
    private let leaf_image_size: CGFloat = 75
    
    
    var body: some View {
        ZStack(alignment: .top) {
            paper.ignoresSafeArea()
            
            ScrollView {
                VStack(spacing: 0) {
                    // Top spacing
                    Spacer()
                        .frame(height: top_strip_top_spacing)
                    
                    // Tea name button
                    Button(action: {
                        showingTeaSelection = true
                    }) {
                        Text(selectedTea.name)
                            .font(.system(size: tea_name_max_text_size, weight: .regular, design: .serif))
                            .kerning(1)
                            .foregroundColor(teaOrange)
                            .multilineTextAlignment(.center)
                            .minimumScaleFactor(0.5)
                            .lineLimit(1)
                            .padding(.vertical, button_text_padding_vertical)
                            .padding(.horizontal, button_text_padding_horizontal)
                            .background(
                                RoundedRectangle(cornerRadius: light_button_corner_radius, style: .continuous)
                                    .fill(tea_name_button_background)
                            )
                    }
                    .shadow(color: Color.black.opacity(button_shadow_opacity), radius: 2, x: 0, y: 1)
                    .padding(.horizontal, tea_name_horizontal_padding)
                    
                    // Content
                    VStack(spacing: 26) {
                        // Image at top-right (sample iOS icon)
                        HStack {
                            Spacer()
                        }
                        .padding(.top, 6)
                        
                        // Infusion picker
                        Text("infusion")
                            .font(.system(size: infusion_text_size, weight: .regular, design: .serif))
                            .foregroundColor(teaOrange.opacity(0.95))
                            .padding(.top, infusion_text_to_controls_spacing)
                        
                        ZStack {
                            // Background leaf image positioned higher and more to the right
                            HStack {
                                Spacer()
                                VStack {
                                    Image(selectedTea.backgroundImageName)
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: leaf_image_size, height: leaf_image_size)
                                        .opacity(1.0)
                                        .padding(.trailing, leaf_image_trailing_padding)
                                        .padding(.top, leaf_image_top_offset)
                                    Spacer()
                                }
                            }
                            
                            // Infusion controls in foreground
                            HStack(spacing: 34) {
                                RoundSymbolButton(symbol: "minus",
                                                  fill: infusion > 1 ? teaOrange : darkForestGreenDisabled,
                                                  symbolColor: creamInk,
                                                  size: plus_minus_button_size) {
                                    if infusion > 1 {
                                        infusion -= 1
                                    }
                                }
                                
                                Text("\(infusion)")
                                    .font(.system(size: portion_text_size, weight: .regular, design: .serif))
                                    .foregroundColor(teaOrange)
                                
                                RoundSymbolButton(symbol: "plus",
                                                  fill: infusion < Int(selectedTea.number_of_steeps.maximum) ? teaOrange : darkForestGreenDisabled,
                                                  symbolColor: creamInk,
                                                  size: plus_minus_button_size) {
                                    if infusion < Int(selectedTea.number_of_steeps.maximum) {
                                        infusion += 1
                                    }
                                }
                            }
                        }
                        .padding(.top, -6)
                        
                        // Timer
                        Button {
                            showingTimeSelection = true
                        } label: {
                            Text(String(format: "%d:%02d", seconds/60, seconds%60))
                                .font(.system(size: timer_text_size, weight: .regular, design: .serif))
                                .foregroundColor(teaOrange)
                                .multilineTextAlignment(.center)
                                .padding(.vertical, timer_button_padding_vertical)
                                .padding(.horizontal, button_text_padding_horizontal)
                                .background(
                                    RoundedRectangle(cornerRadius: light_button_corner_radius, style: .continuous)
                                        .fill(timer_button_background)
                                )
                        }
                        .shadow(color: Color.black.opacity(button_shadow_opacity), radius: 2, x: 0, y: 1)
                        .padding(.top, 10)
                        
                        if isComplete {
                            controlButton(title: "Reset") {
                                resetTimer()
                            }
                            .padding(.top, steep_timer_spacing)
                        } else if paused {
                            if seconds == initialSeconds {
                                controlButton(title: "Begin Steep") {
                                    startTimer()
                                }
                                .padding(.top, steep_timer_spacing)
                            } else {
                                HStack(spacing: 20) {
                                    controlButton(title: "Reset") {
                                        resetTimer()
                                    }
                                    
                                    controlButton(title: "Resume") {
                                        startTimer()
                                    }
                                }.padding(.top, steep_timer_spacing)
                            }
                        } else {
                            controlButton(title: "Pause") {
                                pauseTimer()
                            }
                            .padding(.top, steep_timer_spacing)
                        }
                    }
                    .padding(.bottom, steep_button_bottom_spacing)
                    
                    // Info strip (temperature & dosage)
                    ZStack {
                        infoStrip
                        HStack {
                            HStack {
                                Spacer()
                                Text(selectedTea.temperature)
                                    .font(.system(size: 24, weight: .regular, design: .serif))
                                    .foregroundColor(teaOrange)
                                Spacer()
                                    .frame(width: 30)
                            }
                            .frame(maxWidth: .infinity)
                            
                            HStack {
                                Spacer()
                                    .frame(width: 30)
                                VStack(alignment: .leading, spacing: 0) {
                                    Text(selectedTea.dosage)
                                        .font(.system(size: 28, weight: .regular, design: .serif))
                                        .foregroundColor(teaOrange)
                                    Text("per 8 oz")
                                        .font(.system(size: 16, weight: .regular, design: .serif))
                                        .foregroundColor(teaOrange.opacity(0.75))
                                        .padding(.top, 2)
                                }
                                Spacer()
                            }
                            .frame(maxWidth: .infinity)
                        }
                        .overlay(
                            Rectangle()
                                .fill(teaOrange.opacity(0.9))
                                .frame(width: 8, height: 8)
                                .rotationEffect(.degrees(45))
                        )
                        .padding(.horizontal, 28)
                    }
                    .frame(height: 86)
                    
                    // Body text
                    Text(selectedTea.description)
                        .font(.system(size: description_text_size, weight: .regular, design: .serif))
                        .foregroundColor(teaOrange)
                        .lineSpacing(6)
                        .padding(.horizontal, description_gutter_size)
                        .padding(.top, description_top_padding)
                        .padding(.bottom, description_bottom_padding)
                }
            }
        }
        .sheet(isPresented: $showingTeaSelection) {
            TeaSelectionSheet(selectedTea: $selectedTea)
                .presentationDetents([.medium, .large])
                .presentationDragIndicator(.visible)
        }
        .sheet(isPresented: $showingTimeSelection) {
            let duration = selectedTea.steepingDuration(for: infusion)
            TimeSelectionSheet(selectedSeconds: $selectedSeconds,
                               minSeconds: Int(duration.minimum * 60),
                               maxSeconds: Int(duration.maximum * 60))
                .presentationDetents([.height(300)])
                .presentationDragIndicator(.visible)
        }
        .onChange(of: selectedTea) { _ in
            // Save preferences for the previous tea before switching
            if let prevTea = previousTea, let prevInfusion = previousInfusion {
                savePreviousTeaPreferences(tea: prevTea, infusion: prevInfusion)
            }
            
            infusion = 1
            previousTea = selectedTea
            previousInfusion = infusion
            saveLastSelectedTea()
            resetTimer()
        }
        .onChange(of: infusion) { _ in
            // Save preferences for the previous infusion before switching
            if let prevTea = previousTea, let prevInfusion = previousInfusion {
                savePreviousTeaPreferences(tea: prevTea, infusion: prevInfusion)
            }
            
            previousInfusion = infusion
            resetTimer()
        }
        .onChange(of: selectedSeconds) { _ in
            seconds = selectedSeconds
            initialSeconds = seconds
            paused = true
            isComplete = false
            timer?.invalidate()
            timer = nil
            cancelNotification()
            saveCurrentPreferences()
        }
        .onAppear {
            requestNotificationPermission()
            loadLastSelectedTea()
            previousTea = selectedTea
            previousInfusion = infusion
            resetTimer()
        }
        .onReceive(NotificationCenter.default.publisher(for: UIApplication.willResignActiveNotification)) { _ in
            handleAppWillBackground()
        }
        .onReceive(NotificationCenter.default.publisher(for: UIApplication.didBecomeActiveNotification)) { _ in
            handleAppDidForeground()
        }
    }
    
    private func controlButton(title: String, action: @escaping () -> Void) -> some View {
        Button {
            // Stop alarm on any user action
            if isComplete {
                stopAlarmSound()
            }
            
            withAnimation(.bouncy(duration: 0.7)) {
                action()
            }
        } label: {
            HStack(spacing: steep_button_text_icon_spacing) {
                Text(title)
                    .font(.system(size: steep_button_text_size, weight: .regular, design: .serif))
                    .foregroundColor(creamInk)
                
                if title == "Begin Steep" {
                    Image(systemName: "leaf.fill")
                        .font(.system(size: steep_button_icon_size, weight: .regular))
                        .foregroundColor(creamInk)
                }
            }
            .padding(.vertical, button_text_padding_vertical)
            .padding(.horizontal, button_text_padding_horizontal)
            .background(
                RoundedRectangle(cornerRadius: control_button_corner_radius, style: .continuous)
                    .fill(title == "Begin Steep" ? teaOrange : teaOrange)
            )
        }
        .shadow(color: Color.black.opacity(0.4), radius: 2, x: 0, y: 1)
    }
    
    private func calculateDefaultSteepTime(duration: ValueRange) -> Int {
        let minSeconds = Int(duration.minimum * 60)
        let maxSeconds = Int(duration.maximum * 60)
        let averageSeconds = (minSeconds + maxSeconds) / 2
        
        // Round to nearest 30-second increment
        return Int(round(Double(averageSeconds) / 30.0) * 30)
    }
    
    private func resetTimer() {
        timer?.invalidate()
        timer = nil
        timerStartTime = nil
        cancelNotification()
        stopAlarmSound()
        
        // Try to load saved preference first
        if let savedPreference = PersistenceController.shared.getTeaPreference(
            teaID: selectedTea.id.uuidString,
            infusion: infusion,
            context: viewContext
        ) {
            selectedSeconds = Int(savedPreference.preferredTimeSeconds)
        } else {
            // Fall back to calculated default
            let duration = selectedTea.steepingDuration(for: infusion)
            selectedSeconds = calculateDefaultSteepTime(duration: duration)
        }
        
        seconds = selectedSeconds
        initialSeconds = seconds
        paused = true
        isComplete = false
    }
    
    private func saveCurrentPreferences() {
        print("💾 Saving current preferences for tea: \(selectedTea.name), infusion: \(infusion), time: \(selectedSeconds)s")
        
        // Save the current tea preference
        PersistenceController.shared.saveTeaPreference(
            teaID: selectedTea.id.uuidString,
            infusion: infusion,
            preferredTimeSeconds: selectedSeconds,
            context: viewContext
        )
    }
    
    private func savePreviousTeaPreferences(tea: TeaVariety, infusion: Int) {
        print("💾 Saving previous tea preferences for: \(tea.name), infusion: \(infusion), time: \(selectedSeconds)s")
        
        PersistenceController.shared.saveTeaPreference(
            teaID: tea.id.uuidString,
            infusion: infusion,
            preferredTimeSeconds: selectedSeconds,
            context: viewContext
        )
    }
    
    private func saveLastSelectedTea() {
        print("💾 Saving last selected tea: \(selectedTea.name)")
        
        PersistenceController.shared.saveLastSelectedTea(
            teaID: selectedTea.id.uuidString,
            context: viewContext
        )
    }
    
    private func loadLastSelectedTea() {
        print("🔍 Loading last selected tea on app launch...")
        if let lastTeaID = PersistenceController.shared.getLastSelectedTeaID(context: viewContext),
           let tea = allTeas.first(where: { $0.id.uuidString == lastTeaID }) {
            print("✅ Found and loaded last selected tea: \(tea.name)")
            selectedTea = tea
        } else {
            print("⚠️ No last selected tea found, using default")
        }
    }
    
    private func startTimer() {
        if seconds <= 0 {
            isComplete = true
            return
        }
        paused = false
        isComplete = false
        
        // Record when the timer starts
        timerStartTime = Date()
        
        scheduleNotification()
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { _ in
            updateTimerFromBackground()
        }
    }
    
    private func updateTimerFromBackground() {
        guard let startTime = timerStartTime, !paused else { return }
        
        let elapsed = Date().timeIntervalSince(startTime)
        let newSeconds = max(0, initialSeconds - Int(elapsed))
        
        if newSeconds != seconds {
            seconds = newSeconds
        }
        
        if seconds <= 0 {
            paused = true
            isComplete = true
            timer?.invalidate()
            timer = nil
            timerStartTime = nil
            playAlarmSound()
        }
    }
    
    private func pauseTimer() {
        // Update seconds based on elapsed time before pausing
        if let startTime = timerStartTime, !paused {
            let elapsed = Date().timeIntervalSince(startTime)
            seconds = max(0, initialSeconds - Int(elapsed))
        }
        
        paused = true
        timer?.invalidate()
        timer = nil
        timerStartTime = nil
        cancelNotification()
    }
    
    private func requestNotificationPermission() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound]) { granted, error in
            if let error = error {
                print("Notification permission error: \(error)")
            }
        }
    }
    
    private func scheduleNotification() {
        let content = UNMutableNotificationContent()
        content.title = "Tea Timer"
        content.body = "Your \(selectedTea.name) (infusion \(infusion)) is ready!"
        content.sound = .default
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: TimeInterval(seconds), repeats: false)
        let request = UNNotificationRequest(identifier: "tea-timer", content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request) { error in
            if let error = error {
                print("Error scheduling notification: \(error)")
            }
        }
    }
    
    private func cancelNotification() {
        UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: ["tea-timer"])
    }
    
    private func playAlarmSound() {
        print("🔔 Playing continuous alarm sound for timer completion")
        
        // Configure audio session for playback
        do {
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
            try AVAudioSession.sharedInstance().setActive(true)
        } catch {
            print("❌ Failed to set up audio session: \(error)")
        }
        
        // Use system alarm sound for continuous playback
        guard let soundURL = Bundle.main.url(forResource: "alarm", withExtension: "wav") else {
            // Fallback to continuous system sound if custom alarm file doesn't exist
            print("⚠️ Custom alarm sound not found, using continuous system sound")
            playSystemSoundContinuously()
            return
        }
        
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: soundURL)
            audioPlayer?.numberOfLoops = -1 // Play indefinitely until stopped
            audioPlayer?.volume = 1.0
            audioPlayer?.play()
            print("🔔 Alarm playing continuously - tap Reset to stop")
        } catch {
            print("❌ Failed to play custom alarm sound: \(error)")
            // Fallback to continuous system sound
            playSystemSoundContinuously()
        }
        
        // Add initial haptic feedback
        let impactFeedback = UIImpactFeedbackGenerator(style: .heavy)
        impactFeedback.prepare()
        impactFeedback.impactOccurred()
        
        // Continue vibration pattern every 2 seconds
        startContinuousVibration()
    }
    
    private func playSystemSoundContinuously() {
        // Play system sound and schedule it to repeat
        AudioServicesPlaySystemSound(1005)
        
        // Schedule repeated system sounds every 2 seconds
        alarmTimer = Timer.scheduledTimer(withTimeInterval: 2.0, repeats: true) { _ in
            AudioServicesPlaySystemSound(1005)
        }
    }
    
    private func startContinuousVibration() {
        // Create repeating vibration pattern every 2 seconds
        alarmTimer = Timer.scheduledTimer(withTimeInterval: 2.0, repeats: true) { _ in
            let impactFeedback = UIImpactFeedbackGenerator(style: .heavy)
            impactFeedback.prepare()
            impactFeedback.impactOccurred()
        }
    }
    
    private func stopAlarmSound() {
        print("🔕 Stopping alarm sound")
        
        // Stop audio player
        audioPlayer?.stop()
        audioPlayer = nil
        
        // Stop alarm timer (for system sounds or vibration)
        alarmTimer?.invalidate()
        alarmTimer = nil
    }
    
    private func handleAppWillBackground() {
        print("📱 App going to background - timer running: \(!paused)")
        backgroundTime = Date()
        
        // Don't invalidate the timer when going to background
        // Keep the start time so we can calculate elapsed time when returning
    }
    
    private func handleAppDidForeground() {
        print("📱 App returning to foreground")
        
        guard let backgroundStart = backgroundTime else { return }
        
        // Calculate how long we were in background
        let backgroundDuration = Date().timeIntervalSince(backgroundStart)
        print("📱 Was in background for \(backgroundDuration) seconds")
        
        // Update timer if it was running
        if !paused && !isComplete {
            updateTimerFromBackground()
        }
        
        backgroundTime = nil
    }
}

// Circular filled button with a symbol
struct RoundSymbolButton: View {
    var symbol: String
    var fill: Color
    var symbolColor: Color = .white
    var size: CGFloat = 100
    var action: () -> Void
    
    var body: some View {
        Button(action: action) {
            ZStack {
                Circle()
                    .fill(fill)
                    .frame(width: size, height: size)
                Image(systemName: symbol)
                    .font(.system(size: size * 0.42, weight: .bold))
                    .foregroundColor(symbolColor)
            }
        }
        .buttonStyle(.plain)
        .shadow(color: Color.black.opacity(0.4), radius: 2, x: 0, y: 1)
    }
}

struct TeaTimerView_Previews: PreviewProvider {
    static var previews: some View {
        TeaTimerView()
            .previewDevice("iPhone 15 Pro")
    }
}

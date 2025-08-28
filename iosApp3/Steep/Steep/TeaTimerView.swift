//
//  TeaTimerView.swift
//  Steep
//
//  Created by Ben on 8/27/25.
//

import SwiftUI
import Foundation // For Timer
import UserNotifications

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
    @State private var infusion = 1
    @State private var seconds = 0
    @State private var initialSeconds = 0
    @State private var paused = true
    @State private var isComplete = false
    @State private var showingTeaSelection = false
    @State private var showingTimeSelection = false
    @State private var selectedMinutes: Int = 0
    @State private var selectedTea = allTeas.first { $0.tea_name == "English Breakfast Tea" }!
    @State private var timer: Timer? = nil
    
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
                    
                    List(filteredTeas) { tea in
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
                        }
                        .buttonStyle(.plain)
                        .listRowBackground(Color.clear)
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
    }
    
    struct TimeSelectionSheet: View {
        @Binding var selectedMinutes: Int
        let minMinutes: Double
        let maxMinutes: Double
        @Environment(\.dismiss) private var dismiss
        @State private var localMinutes: Int
        
        // Match the tea timer colors
        private let paper = Color(red: 1.00, green: 0.97, blue: 0.86)
        private let teaOrange = Color(red: 0.73, green: 0.37, blue: 0.09)
        
        init(selectedMinutes: Binding<Int>, minMinutes: Double, maxMinutes: Double) {
            self._selectedMinutes = selectedMinutes
            self.minMinutes = minMinutes
            self.maxMinutes = maxMinutes
            self._localMinutes = State(initialValue: selectedMinutes.wrappedValue)
        }
        
        var body: some View {
            NavigationView {
                ZStack {
                    paper.ignoresSafeArea()
                    
                    Picker("Steep Time", selection: $localMinutes) {
                        ForEach(Int(minMinutes)...Int(maxMinutes), id: \.self) { minutes in
                            Text("\(minutes) minutes").tag(minutes)
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
                            selectedMinutes = localMinutes
                            dismiss()
                        }
                        .foregroundColor(teaOrange)
                        .font(.system(size: 18, weight: .regular, design: .serif))
                    }
                }
            }
        }
    }
    
    // Colors tuned to the screenshot
    private let paper      = Color(red: 1.00, green: 0.97, blue: 0.86) // main background
    private let titleStrip = Color(red: 0.97, green: 0.92, blue: 0.75) // behind "Green (Jasmine)"
    private let infoStrip  = Color(red: 0.98, green: 0.95, blue: 0.83) // behind temp/dosage row
    
    private let teaOrange  = Color(red: 0.73, green: 0.37, blue: 0.09)
    private let olive      = Color(red: 0.62, green: 0.62, blue: 0.46)
    private let creamInk   = Color(red: 1.00, green: 0.94, blue: 0.80)
    
    var body: some View {
        ZStack(alignment: .top) {
            paper.ignoresSafeArea()
            
            ScrollView {
                VStack(spacing: 0) {
                    // Title strip
                    titleStrip
                        .frame(height: 120)
                        .overlay(
                            Button(action: {
                                showingTeaSelection = true
                            }) {
                                Text(selectedTea.name)
                                    .font(.system(size: 42, weight: .regular, design: .serif))
                                    .kerning(1)
                                    .foregroundColor(teaOrange)
                                    .padding(.top, 12)
                            }
                            .buttonStyle(.plain)
                        )
                    
                    // Content
                    VStack(spacing: 26) {
                        // Image at top-right (sample iOS icon)
                        HStack {
                            Spacer()
                        }
                        .padding(.top, 6)
                        
                        // Infusion picker
                        Text("infusion")
                            .font(.system(size: 28, weight: .regular, design: .serif))
                            .foregroundColor(teaOrange.opacity(0.95))
                            .padding(.top, -10)
                        
                        HStack(spacing: 34) {
                            RoundSymbolButton(symbol: "minus",
                                              fill: teaOrange,
                                              symbolColor: creamInk,
                                              size: 112) {
                                if infusion > Int(selectedTea.number_of_steeps.minimum) {
                                    infusion -= 1
                                }
                            }
                            
                            Text("\(infusion)")
                                .font(.system(size: 56, weight: .regular, design: .serif))
                                .foregroundColor(teaOrange)
                            
                            RoundSymbolButton(symbol: "plus",
                                              fill: olive,
                                              symbolColor: creamInk,
                                              size: 112) {
                                if infusion < Int(selectedTea.number_of_steeps.maximum) {
                                    infusion += 1
                                }
                            }
                        }
                        .padding(.top, -6)
                        
                        // Timer
                        Button {
                            showingTimeSelection = true
                        } label: {
                            Text(String(format: "%d:%02d", seconds/60, seconds%60))
                                .font(.system(size: 70, weight: .regular, design: .serif))
                                .foregroundColor(teaOrange)
                        }
                        .buttonStyle(.plain)
                        .padding(.top, 10)
                        
                        if isComplete {
                            controlButton(title: "Reset") {
                                resetTimer()
                            }
                            .padding(.top, 6)
                        } else if paused {
                            if seconds == initialSeconds {
                                controlButton(title: "Begin Steep") {
                                    startTimer()
                                }
                                .padding(.top, 6)
                            } else {
                                HStack(spacing: 20) {
                                    controlButton(title: "Reset") {
                                        resetTimer()
                                    }
                                    
                                    controlButton(title: "Resume") {
                                        startTimer()
                                    }
                                }
                                .padding(.top, 6)
                            }
                        } else {
                            controlButton(title: "Pause") {
                                pauseTimer()
                            }
                            .padding(.top, 6)
                        }
                    }
                    .padding(.bottom, 18)
                    
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
                            Circle()
                                .fill(teaOrange.opacity(0.9))
                                .frame(width: 12, height: 12)
                        )
                        .padding(.horizontal, 28)
                    }
                    .frame(height: 86)
                    
                    // Body text
                    Text(selectedTea.description)
                        .font(.system(size: 24, weight: .regular, design: .serif))
                        .foregroundColor(teaOrange)
                        .lineSpacing(6)
                        .padding(.horizontal, 26)
                        .padding(.top, 18)
                        .padding(.bottom, 24)
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
            TimeSelectionSheet(selectedMinutes: $selectedMinutes,
                               minMinutes: duration.minimum,
                               maxMinutes: duration.maximum)
                .presentationDetents([.height(300)])
                .presentationDragIndicator(.visible)
        }
        .onChange(of: selectedTea) { _ in
            resetTimer()
        }
        .onChange(of: infusion) { _ in
            resetTimer()
        }
        .onChange(of: selectedMinutes) { _ in
            seconds = selectedMinutes * 60
            initialSeconds = seconds
            paused = true
            isComplete = false
            timer?.invalidate()
            timer = nil
            cancelNotification()
        }
        .onAppear {
            requestNotificationPermission()
            resetTimer()
        }
    }
    
    private func controlButton(title: String, action: @escaping () -> Void) -> some View {
        Button {
            action()
        } label: {
            Text(title)
                .font(.system(size: 36, weight: .regular, design: .serif))
                .foregroundColor(creamInk)
                .padding(.vertical, 14)
                .padding(.horizontal, 28)
                .background(
                    RoundedRectangle(cornerRadius: 26, style: .continuous)
                        .fill(teaOrange)
                )
        }
        .shadow(color: Color.black.opacity(0.18), radius: 8, x: 0, y: 6)
    }
    
    private func resetTimer() {
        timer?.invalidate()
        timer = nil
        cancelNotification()
        let duration = selectedTea.steepingDuration(for: infusion)
        selectedMinutes = Int(duration.minimum)
        seconds = selectedMinutes * 60
        initialSeconds = seconds
        paused = true
        isComplete = false
    }
    
    private func startTimer() {
        if seconds <= 0 {
            isComplete = true
            return
        }
        paused = false
        isComplete = false
        scheduleNotification()
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { _ in
            if seconds > 0 {
                seconds -= 1
            } else {
                paused = true
                isComplete = true
                timer?.invalidate()
                timer = nil
            }
        }
    }
    
    private func pauseTimer() {
        paused = true
        timer?.invalidate()
        timer = nil
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
        .shadow(color: Color.black.opacity(0.12), radius: 5, x: 0, y: 3)
    }
}

struct TeaTimerView_Previews: PreviewProvider {
    static var previews: some View {
        TeaTimerView()
            .previewDevice("iPhone 15 Pro")
    }
}

//
//  TeaTimerView.swift
//  Steep
//
//  Created by Ben on 8/27/25.
//

import SwiftUI
import Foundation // For Timer
import UserNotifications

struct TeaTimerView: View {
    @State private var infusion = 1
    @State private var seconds = 0
    @State private var initialSeconds = 0
    @State private var paused = true
    @State private var isComplete = false
    @State private var showingTeaSelection = false
    @State private var showingTimeSelection = false
    @State private var selectedMinutes: Int = 0
    @State private var selectedTea = Tea.greenJasmine
    @State private var timer: Timer? = nil
    
    struct MinMax<T: Codable & Equatable>: Codable, Equatable {
        let minimum: T
        let maximum: T
    }
    
    struct SteepInstruction: Codable, Equatable {
        let temperature: MinMax<Int>
        let duration: MinMax<Int> // in minutes
        let steep_number: Int
        let steep_taste_description: String
    }
    
    struct Tea: Identifiable, Equatable {
        let id: String
        let name: String
        let tea_name: String
        let tsp_per_8_oz: MinMax<Int>
        let region_of_origin: String
        let traditional_name: String
        let amount_of_caffiene: Int
        let main_tea_type: String
        let number_of_steeps: MinMax<Int>
        let steep_instructions: [SteepInstruction]
        let overall_taste_description: String
        let short_summary: String
        let overall_tea_description: String
        
        var temperature: String {
            let temp = steep_instructions.first?.temperature ?? MinMax(minimum: 0, maximum: 0)
            return "\(temp.minimum)-\(temp.maximum)°F"
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
                return instruction.duration.minimum * 60
            } else if let last = steep_instructions.last {
                // Use the last one if infusion exceeds
                return last.duration.minimum * 60
            } else {
                return 0
            }
        }
        
        func steepingDuration(for infusion: Int) -> MinMax<Int> {
            let adjustedInfusion = max(1, infusion)
            if let instruction = steep_instructions.first(where: { $0.steep_number == adjustedInfusion }) {
                return instruction.duration
            } else if let last = steep_instructions.last {
                // Use the last one if infusion exceeds
                return last.duration
            } else {
                return MinMax(minimum: 0, maximum: 0)
            }
        }
        
        static let greenJasmine = Tea(
            id: "greenJasmine",
            name: "Green (Jasmine)",
            tea_name: "Jasmine Green Tea",
            tsp_per_8_oz: MinMax(minimum: 1, maximum: 2),
            region_of_origin: "China (primarily Fujian province)",
            traditional_name: "Jasmine Green Tea",
            amount_of_caffiene: 2,
            main_tea_type: "Green",
            number_of_steeps: MinMax(minimum: 1, maximum: 2),
            steep_instructions: [
                SteepInstruction(
                    temperature: MinMax(minimum: 160, maximum: 180),
                    duration: MinMax(minimum: 2, maximum: 4),
                    steep_number: 1,
                    steep_taste_description: "Delicate, fragrant, floral, subtly sweet"
                ),
                SteepInstruction(
                    temperature: MinMax(minimum: 160, maximum: 180),
                    duration: MinMax(minimum: 3, maximum: 5),
                    steep_number: 2,
                    steep_taste_description: "Lighter floral notes, refreshing"
                )
            ],
            overall_taste_description: "A delicate and fragrant tea with a prominent floral aroma and taste from jasmine blossoms, balanced with the fresh, sometimes slightly grassy notes of green tea. Can be subtly sweet.",
            short_summary: "A popular scented green tea from China, infused with the aroma of jasmine blossoms, offering a delicate floral and refreshing taste.",
            overall_tea_description: "Jasmine green tea is a subtly sweet and highly fragrant tea, scented with the aroma of jasmine blossoms. It offers floral notes, a fresh grassy finish, and antioxidant benefits for health and relaxation."
        )
        
        static let blackEarlGrey = Tea(
            id: "blackEarlGrey",
            name: "Black (Earl Grey)",
            tea_name: "Earl Grey Black Tea",
            tsp_per_8_oz: MinMax(minimum: 1, maximum: 1),
            region_of_origin: "China / Sri Lanka",
            traditional_name: "Earl Grey",
            amount_of_caffiene: 3,
            main_tea_type: "Black",
            number_of_steeps: MinMax(minimum: 1, maximum: 2),
            steep_instructions: [
                SteepInstruction(
                    temperature: MinMax(minimum: 200, maximum: 212),
                    duration: MinMax(minimum: 3, maximum: 5),
                    steep_number: 1,
                    steep_taste_description: "Smooth, citrusy, aromatic with bergamot"
                ),
                SteepInstruction(
                    temperature: MinMax(minimum: 200, maximum: 212),
                    duration: MinMax(minimum: 4, maximum: 6),
                    steep_number: 2,
                    steep_taste_description: "Milder, subtle citrus notes"
                )
            ],
            overall_taste_description: "Smooth, citrusy, and slightly floral taste.",
            short_summary: "A quintessentially British black tea flavored with bergamot oil.",
            overall_tea_description: "Earl Grey is a black tea flavored with bergamot oil, offering a smooth, citrusy, and slightly floral taste. This quintessentially British tea may support heart health and provide a mild caffeine boost."
        )
        
        static let oolong = Tea(
            id: "oolong",
            name: "Oolong",
            tea_name: "Oolong Tea",
            tsp_per_8_oz: MinMax(minimum: 1, maximum: 2),
            region_of_origin: "China / Taiwan",
            traditional_name: "Oolong",
            amount_of_caffiene: 3,
            main_tea_type: "Oolong",
            number_of_steeps: MinMax(minimum: 1, maximum: 4),
            steep_instructions: [
                SteepInstruction(
                    temperature: MinMax(minimum: 185, maximum: 205),
                    duration: MinMax(minimum: 2, maximum: 3),
                    steep_number: 1,
                    steep_taste_description: "Floral and fruity"
                ),
                SteepInstruction(
                    temperature: MinMax(minimum: 185, maximum: 205),
                    duration: MinMax(minimum: 3, maximum: 4),
                    steep_number: 2,
                    steep_taste_description: "Balanced, with emerging woody notes"
                ),
                SteepInstruction(
                    temperature: MinMax(minimum: 185, maximum: 205),
                    duration: MinMax(minimum: 4, maximum: 5),
                    steep_number: 3,
                    steep_taste_description: "Roasted and mellow"
                ),
                SteepInstruction(
                    temperature: MinMax(minimum: 185, maximum: 205),
                    duration: MinMax(minimum: 5, maximum: 6),
                    steep_number: 4,
                    steep_taste_description: "Light and lingering"
                )
            ],
            overall_taste_description: "Flavors ranging from floral and fruity to woody and roasted.",
            short_summary: "A semi-oxidized tea with a wide range of flavors.",
            overall_tea_description: "Oolong is a semi-oxidized tea with flavors ranging from floral and fruity to woody and roasted. It aids metabolism, digestion, and offers a balanced caffeine level for sustained energy."
        )
        
        static let whiteSilverNeedle = Tea(
            id: "whiteSilverNeedle",
            name: "White (Silver Needle)",
            tea_name: "Silver Needle White Tea",
            tsp_per_8_oz: MinMax(minimum: 2, maximum: 3),
            region_of_origin: "China (Fujian province)",
            traditional_name: "Bai Hao Yin Zhen",
            amount_of_caffiene: 2,
            main_tea_type: "White",
            number_of_steeps: MinMax(minimum: 1, maximum: 3),
            steep_instructions: [
                SteepInstruction(
                    temperature: MinMax(minimum: 160, maximum: 175),
                    duration: MinMax(minimum: 2, maximum: 3),
                    steep_number: 1,
                    steep_taste_description: "Subtle sweet, light body"
                ),
                SteepInstruction(
                    temperature: MinMax(minimum: 160, maximum: 175),
                    duration: MinMax(minimum: 3, maximum: 4),
                    steep_number: 2,
                    steep_taste_description: "Mild honey notes"
                ),
                SteepInstruction(
                    temperature: MinMax(minimum: 160, maximum: 175),
                    duration: MinMax(minimum: 4, maximum: 5),
                    steep_number: 3,
                    steep_taste_description: "Light and refreshing"
                )
            ],
            overall_taste_description: "Subtle sweet flavor and light body.",
            short_summary: "A delicate white tea made from tender buds.",
            overall_tea_description: "Silver Needle white tea is a delicate brew made from tender buds, with a subtle sweet flavor and light body. High in antioxidants, it promotes relaxation and healthy aging."
        )
        
        static let puErh = Tea(
            id: "puErh",
            name: "Pu-erh",
            tea_name: "Pu-erh Tea",
            tsp_per_8_oz: MinMax(minimum: 1, maximum: 2),
            region_of_origin: "China (Yunnan province)",
            traditional_name: "Pu-erh",
            amount_of_caffiene: 3,
            main_tea_type: "Pu-erh",
            number_of_steeps: MinMax(minimum: 1, maximum: 5),
            steep_instructions: [
                SteepInstruction(
                    temperature: MinMax(minimum: 200, maximum: 212),
                    duration: MinMax(minimum: 1, maximum: 2),
                    steep_number: 1,
                    steep_taste_description: "Earthy and bold"
                ),
                SteepInstruction(
                    temperature: MinMax(minimum: 200, maximum: 212),
                    duration: MinMax(minimum: 1, maximum: 2),
                    steep_number: 2,
                    steep_taste_description: "Mellow earthy flavors"
                ),
                SteepInstruction(
                    temperature: MinMax(minimum: 200, maximum: 212),
                    duration: MinMax(minimum: 2, maximum: 3),
                    steep_number: 3,
                    steep_taste_description: "Smooth and deep"
                ),
                SteepInstruction(
                    temperature: MinMax(minimum: 200, maximum: 212),
                    duration: MinMax(minimum: 2, maximum: 3),
                    steep_number: 4,
                    steep_taste_description: "Subtle earthiness"
                ),
                SteepInstruction(
                    temperature: MinMax(minimum: 200, maximum: 212),
                    duration: MinMax(minimum: 3, maximum: 4),
                    steep_number: 5,
                    steep_taste_description: "Light and lingering"
                )
            ],
            overall_taste_description: "Earthy, mellow flavors that deepen with age.",
            short_summary: "A fermented tea with unique earthy taste.",
            overall_tea_description: "Pu-erh is a fermented tea with earthy, mellow flavors that deepen with age. It supports digestion, weight management, and provides a unique probiotic-like benefit."
        )
        
        static let rooibos = Tea(
            id: "rooibos",
            name: "Rooibos",
            tea_name: "Rooibos Tea",
            tsp_per_8_oz: MinMax(minimum: 1, maximum: 2),
            region_of_origin: "South Africa",
            traditional_name: "Rooibos",
            amount_of_caffiene: 0,
            main_tea_type: "Herbal",
            number_of_steeps: MinMax(minimum: 1, maximum: 1),
            steep_instructions: [
                SteepInstruction(
                    temperature: MinMax(minimum: 200, maximum: 212),
                    duration: MinMax(minimum: 5, maximum: 7),
                    steep_number: 1,
                    steep_taste_description: "Sweet, nutty, woody notes"
                )
            ],
            overall_taste_description: "Sweet, nutty taste and woody notes.",
            short_summary: "A caffeine-free herbal tea from South Africa.",
            overall_tea_description: "Rooibos is a caffeine-free herbal tea with a sweet, nutty taste and woody notes. Rich in antioxidants, it supports heart health and offers a soothing, hydrating alternative to traditional teas."
        )
        
        static let chamomile = Tea(
            id: "chamomile",
            name: "Chamomile",
            tea_name: "Chamomile Tea",
            tsp_per_8_oz: MinMax(minimum: 1, maximum: 2),
            region_of_origin: "Egypt / Europe",
            traditional_name: "Chamomile",
            amount_of_caffiene: 0,
            main_tea_type: "Herbal",
            number_of_steeps: MinMax(minimum: 1, maximum: 1),
            steep_instructions: [
                SteepInstruction(
                    temperature: MinMax(minimum: 200, maximum: 212),
                    duration: MinMax(minimum: 5, maximum: 7),
                    steep_number: 1,
                    steep_taste_description: "Floral with apple-like sweetness"
                )
            ],
            overall_taste_description: "Floral herbal tea with apple-like sweetness and calming properties.",
            short_summary: "A soothing herbal tea known for its calming effects.",
            overall_tea_description: "Chamomile is a floral herbal tea with apple-like sweetness and calming properties. It aids sleep, reduces anxiety, and soothes digestion for a relaxing experience."
        )
        
        static let matcha = Tea(
            id: "matcha",
            name: "Matcha",
            tea_name: "Matcha Tea",
            tsp_per_8_oz: MinMax(minimum: 1, maximum: 2),
            region_of_origin: "Japan",
            traditional_name: "Matcha",
            amount_of_caffiene: 4,
            main_tea_type: "Green",
            number_of_steeps: MinMax(minimum: 1, maximum: 1),
            steep_instructions: [
                SteepInstruction(
                    temperature: MinMax(minimum: 160, maximum: 180),
                    duration: MinMax(minimum: 1, maximum: 2),
                    steep_number: 1,
                    steep_taste_description: "Umami, grassy, frothy"
                )
            ],
            overall_taste_description: "Umami, grassy flavors and a frothy texture.",
            short_summary: "A powdered green tea with vibrant flavor.",
            overall_tea_description: "Matcha is a powdered green tea with umami, grassy flavors and a frothy texture. Packed with antioxidants, it boosts energy, focus, and metabolism without the crash of coffee."
        )
        
        static let allCases: [Tea] = [
            .greenJasmine,
            .blackEarlGrey,
            .oolong,
            .whiteSilverNeedle,
            .puErh,
            .rooibos,
            .chamomile,
            .matcha
        ]
    }
    
    struct TeaSelectionSheet: View {
        @Binding var selectedTea: Tea
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
        private var filteredTeas: [Tea] {
            if searchText.isEmpty {
                return Tea.allCases
            } else {
                return Tea.allCases.filter { $0.name.lowercased().contains(searchText.lowercased()) }
            }
        }
    }
    
    struct TimeSelectionSheet: View {
        @Binding var selectedMinutes: Int
        let minMinutes: Int
        let maxMinutes: Int
        @Environment(\.dismiss) private var dismiss
        @State private var localMinutes: Int
        
        // Match the tea timer colors
        private let paper = Color(red: 1.00, green: 0.97, blue: 0.86)
        private let teaOrange = Color(red: 0.73, green: 0.37, blue: 0.09)
        
        init(selectedMinutes: Binding<Int>, minMinutes: Int, maxMinutes: Int) {
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
                        ForEach(minMinutes...maxMinutes, id: \.self) { minutes in
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
                            Image(systemName: "cup.and.saucer.fill")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 130, height: 90)
                                .foregroundColor(Color(red: 0.88, green: 0.86, blue: 0.70))
                                .padding(10)
                                .background(Color.white.opacity(0.75))
                                .clipShape(RoundedRectangle(cornerRadius: 6, style: .continuous))
                                .padding(.trailing, 24)
                                .offset(y: 6)
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
                                if infusion > selectedTea.number_of_steeps.minimum {
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
                                if infusion < selectedTea.number_of_steeps.maximum {
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
                            Text(selectedTea.temperature)
                                .font(.system(size: 28, weight: .regular, design: .serif))
                                .foregroundColor(teaOrange)
                            
                            Spacer()
                            
                            Circle()
                                .fill(teaOrange.opacity(0.9))
                                .frame(width: 12, height: 12)
                            
                            Spacer()
                            
                            VStack(alignment: .leading, spacing: 0) {
                                Text(selectedTea.dosage)
                                    .font(.system(size: 28, weight: .regular, design: .serif))
                                    .foregroundColor(teaOrange)
                                Text("per 8 oz")
                                    .font(.system(size: 16, weight: .regular, design: .serif))
                                    .foregroundColor(teaOrange.opacity(0.75))
                                    .padding(.top, 2)
                            }
                        }
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
        selectedMinutes = duration.minimum
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

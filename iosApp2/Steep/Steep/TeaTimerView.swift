//
//  TeaTimerView.swift
//  Steep
//
//  Created by Ben on 8/27/25.
//


import SwiftUI
import Combine

struct TeaTimerView: View {
    @State private var infusion: Int = 2
    @State private var timeRemaining: Int = 34
    @State private var timerRunning = true
    @State private var timer: AnyCancellable?

    var body: some View {
        VStack(spacing: 20) {
            
            // Tea Name
            Text("Green (Jasmine)")
                .font(.title)
                .fontWeight(.medium)
                .foregroundColor(Color.brown)
                .padding(.top, 40)
            
            Spacer()
            
            // Infusion controls
            HStack(spacing: 40) {
                Button(action: {
                    if infusion > 1 { infusion -= 1 }
                }) {
                    Circle()
                        .fill(Color.brown)
                        .frame(width: 60, height: 60)
                        .overlay(
                            Image(systemName: "minus")
                                .foregroundColor(.white)
                                .font(.title2)
                        )
                }
                
                VStack {
                    Text("infusion")
                        .font(.subheadline)
                        .foregroundColor(.brown)
                    Text("\(infusion)")
                        .font(.largeTitle)
                        .foregroundColor(.brown)
                }
                
                Button(action: {
                    infusion += 1
                }) {
                    Circle()
                        .fill(Color.gray.opacity(0.5))
                        .frame(width: 60, height: 60)
                        .overlay(
                            Image(systemName: "plus")
                                .foregroundColor(.white)
                                .font(.title2)
                        )
                }
            }
            
            // Timer
            Text(timeString(from: timeRemaining))
                .font(.largeTitle)
                .foregroundColor(.brown)
                .onAppear(perform: startTimer)
            
            // Pause Button
            Button(action: toggleTimer) {
                Text(timerRunning ? "Pause" : "Resume")
                    .font(.title3)
                    .padding()
                    .frame(width: 150)
                    .background(Color.brown)
                    .foregroundColor(.white)
                    .cornerRadius(12)
            }
            
            Spacer()
            
            // Temperature + teaspoons info
            HStack {
                Text("170-180 F")
                Circle()
                    .frame(width: 5, height: 5)
                    .foregroundColor(.brown)
                Text("1-2 tsp")
                    .foregroundColor(.brown)
                Text("per 8 oz")
                    .font(.footnote)
                    .foregroundColor(.gray)
            }
            .foregroundColor(.brown)
            .padding(.bottom, 10)
            
            // Placeholder description text
            Text("""
                 infusion infusion infusion infusion
                 lorem ipsum filler text goes here
                 """)
                .multilineTextAlignment(.center)
                .foregroundColor(.brown)
                .padding(.horizontal)
            
            Spacer()
        }
        .padding()
        .background(Color(red: 1.0, green: 0.98, blue: 0.9)) // light cream bg
        .edgesIgnoringSafeArea(.all)
    }
    
    private func startTimer() {
        timer = Timer.publish(every: 1, on: .main, in: .common)
            .autoconnect()
            .sink { _ in
                if timerRunning && timeRemaining > 0 {
                    timeRemaining -= 1
                }
            }
    }
    
    private func toggleTimer() {
        timerRunning.toggle()
    }
    
    private func timeString(from seconds: Int) -> String {
        String(format: "%d:%02d", seconds / 60, seconds % 60)
    }
}

struct TeaTimerView_Previews: PreviewProvider {
    static var previews: some View {
        TeaTimerView()
    }
}

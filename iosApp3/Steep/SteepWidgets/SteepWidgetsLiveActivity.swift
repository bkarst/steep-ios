//
//  SteepWidgetsLiveActivity.swift
//  SteepWidgets
//
//  Created by Ben on 8/30/25.
//

import ActivityKit
import WidgetKit
import SwiftUI

// TeaTimerActivityAttributes - shared between main app and widget extension
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

struct SteepWidgetsLiveActivity: Widget {
    // Tea timer colors matching the main app
    private let teaOrange = Color(red: 0.73, green: 0.37, blue: 0.09)
    private let paper = Color(red: 1.00, green: 0.97, blue: 0.86)
    private let darkForestGreen = Color(red: 0.0862, green: 0.364, blue: 0.1372)
    
    var body: some WidgetConfiguration {
        ActivityConfiguration(for: TeaTimerActivityAttributes.self) { context in
            // Lock screen/banner UI goes here
            TeaTimerLockScreenView(context: context, teaOrange: teaOrange, paper: paper)
        } dynamicIsland: { context in
            DynamicIsland {
                // Expanded UI goes here
                DynamicIslandExpandedRegion(.leading) {
                    VStack(alignment: .leading, spacing: 2) {
                        Text(context.attributes.teaName)
                            .font(.caption)
                            .fontWeight(.medium)
                            .foregroundColor(teaOrange)
                        Text("Infusion \(context.attributes.infusion)")
                            .font(.caption2)
                            .foregroundColor(teaOrange.opacity(0.7))
                    }
                }
                DynamicIslandExpandedRegion(.trailing) {
                    VStack(alignment: .trailing) {
                        if context.state.isComplete {
                            Text("Ready!")
                                .font(.caption)
                                .fontWeight(.bold)
                                .foregroundColor(darkForestGreen)
                        } else {
                            Text(timeString(from: context.state.remainingSeconds))
                                .font(.caption)
                                .fontWeight(.bold)
                                .foregroundColor(teaOrange)
                        }
                    }
                }
                DynamicIslandExpandedRegion(.bottom) {
                    HStack {
                        if !context.state.isComplete {
                            ProgressView(value: Double(context.state.totalSeconds - context.state.remainingSeconds), 
                                       total: Double(context.state.totalSeconds))
                                .progressViewStyle(LinearProgressViewStyle(tint: teaOrange))
                        } else {
                            Text("🍵 Your tea is ready!")
                                .font(.caption)
                                .foregroundColor(darkForestGreen)
                        }
                    }
                }
            } compactLeading: {
                Text("🍵")
            } compactTrailing: {
                if context.state.isComplete {
                    Text("Done")
                        .foregroundColor(darkForestGreen)
                        .font(.caption2)
                        .fontWeight(.medium)
                } else {
                    Text(timeString(from: context.state.remainingSeconds))
                        .foregroundColor(teaOrange)
                        .font(.caption2)
                        .fontWeight(.medium)
                }
            } minimal: {
                if context.state.isComplete {
                    Text("✅")
                } else {
                    Text("🍵")
                }
            }
            .keylineTint(teaOrange)
        }
    }
    
    private func timeString(from seconds: Int) -> String {
        let minutes = seconds / 60
        let remainingSeconds = seconds % 60
        return String(format: "%d:%02d", minutes, remainingSeconds)
    }
}

struct TeaTimerLockScreenView: View {
    let context: ActivityViewContext<TeaTimerActivityAttributes>
    let teaOrange: Color
    let paper: Color
    
    var body: some View {
        VStack(spacing: 12) {
            HStack {
                VStack(alignment: .leading, spacing: 4) {
                    Text(context.attributes.teaName)
                        .font(.headline)
                        .fontWeight(.medium)
                        .foregroundColor(teaOrange)
                    Text("Infusion \(context.attributes.infusion)")
                        .font(.subheadline)
                        .foregroundColor(teaOrange.opacity(0.8))
                }
                
                Spacer()
                
                VStack(alignment: .trailing) {
                    if context.state.isComplete {
                        Text("Ready!")
                            .font(.title2)
                            .fontWeight(.bold)
                            .foregroundColor(.green)
                        Text("🍵")
                            .font(.title)
                    } else {
                        Text(timeString(from: context.state.remainingSeconds))
                            .font(.title)
                            .fontWeight(.bold)
                            .foregroundColor(teaOrange)
                            .monospacedDigit()
                    }
                }
            }
            
            if !context.state.isComplete {
                ProgressView(value: Double(context.state.totalSeconds - context.state.remainingSeconds), 
                           total: Double(context.state.totalSeconds))
                    .progressViewStyle(LinearProgressViewStyle(tint: teaOrange))
                    .scaleEffect(x: 1, y: 1.5)
            } else {
                HStack {
                    Image(systemName: "checkmark.circle.fill")
                        .foregroundColor(.green)
                    Text("Your tea is perfectly steeped!")
                        .font(.subheadline)
                        .foregroundColor(.green)
                }
            }
        }
        .padding(16)
        .activityBackgroundTint(paper)
        .activitySystemActionForegroundColor(teaOrange)
    }
    
    private func timeString(from seconds: Int) -> String {
        let minutes = seconds / 60
        let remainingSeconds = seconds % 60
        return String(format: "%d:%02d", minutes, remainingSeconds)
    }
}

extension TeaTimerActivityAttributes {
    fileprivate static var preview: TeaTimerActivityAttributes {
        TeaTimerActivityAttributes(teaName: "Earl Grey", infusion: 1)
    }
}

extension TeaTimerActivityAttributes.ContentState {
    fileprivate static var brewing: TeaTimerActivityAttributes.ContentState {
        TeaTimerActivityAttributes.ContentState(
            teaName: "Earl Grey",
            infusion: 1,
            remainingSeconds: 180,
            totalSeconds: 300,
            isComplete: false,
            endTime: Date().addingTimeInterval(180)
        )
    }
    
    fileprivate static var ready: TeaTimerActivityAttributes.ContentState {
        TeaTimerActivityAttributes.ContentState(
            teaName: "Earl Grey",
            infusion: 1,
            remainingSeconds: 0,
            totalSeconds: 300,
            isComplete: true,
            endTime: Date()
        )
    }
}

#Preview("Notification", as: .content, using: TeaTimerActivityAttributes.preview) {
   SteepWidgetsLiveActivity()
} contentStates: {
    TeaTimerActivityAttributes.ContentState.brewing
    TeaTimerActivityAttributes.ContentState.ready
}

//
//  SteepApp.swift
//  Steep
//
//  Created by Ben on 8/27/25.
//

import SwiftUI
import CoreData

@main
struct SteepApp: App {
    let persistenceController = PersistenceController.shared
    @State private var showingLoadingScreen = true

    var body: some Scene {
        WindowGroup {
            ZStack {
                // Main view always present
                TeaTimerView()
                    .environment(\.managedObjectContext, persistenceController.container.viewContext)
                
                // Loading screen overlays on top
                if showingLoadingScreen {
                    LoadingScreenView()
                        .onAppear {
                            // Show loading screen for 1.4 seconds (0.5s scale + 0.3s hold + 0.6s fade)
                            DispatchQueue.main.asyncAfter(deadline: .now() + 1.4) {
                                withAnimation(.easeInOut(duration: 0.1)) {
                                    showingLoadingScreen = false
                                }
                            }
                        }
                        .transition(.opacity)
                }
            }
        }
    }
}

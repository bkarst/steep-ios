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

    var body: some Scene {
        WindowGroup {
            TeaTimerView()
//            ContentView()
//                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}

//
//  Persistence.swift
//  Steep
//
//  Created by Ben on 8/27/25.
//

import CoreData

struct PersistenceController {
    static let shared = PersistenceController()

    @MainActor
    static let preview: PersistenceController = {
        let result = PersistenceController(inMemory: true)
        let viewContext = result.container.viewContext
        for _ in 0..<10 {
            let newItem = Item(context: viewContext)
            newItem.timestamp = Date()
        }
        do {
            try viewContext.save()
        } catch {
            // Replace this implementation with code to handle the error appropriately.
            // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
        return result
    }()
    
    // MARK: - Tea Preferences Management
    
    func saveTeaPreference(teaID: String, infusion: Int, preferredTimeSeconds: Int, context: NSManagedObjectContext) {
        let request: NSFetchRequest<TeaPreference> = TeaPreference.fetchRequest()
        request.predicate = NSPredicate(format: "teaID == %@ AND infusionNumber == %d", teaID, infusion)
        
        do {
            let results = try context.fetch(request)
            let preference = results.first ?? TeaPreference(context: context)
            
            preference.teaID = teaID
            preference.infusionNumber = Int16(infusion)
            preference.preferredTimeSeconds = Int32(preferredTimeSeconds)
            preference.lastSelected = Date()
            
            try context.save()
        } catch {
            print("Failed to save tea preference: \(error)")
        }
    }
    
    func getTeaPreference(teaID: String, infusion: Int, context: NSManagedObjectContext) -> TeaPreference? {
        let request: NSFetchRequest<TeaPreference> = TeaPreference.fetchRequest()
        request.predicate = NSPredicate(format: "teaID == %@ AND infusionNumber == %d", teaID, infusion)
        request.fetchLimit = 1
        
        do {
            return try context.fetch(request).first
        } catch {
            print("Failed to fetch tea preference: \(error)")
            return nil
        }
    }
    
    func saveLastSelectedTea(teaID: String, context: NSManagedObjectContext) {
        print("💾 Saving last selected tea: \(teaID)")
        let request: NSFetchRequest<UserPreferences> = UserPreferences.fetchRequest()
        request.fetchLimit = 1
        
        do {
            let results = try context.fetch(request)
            let userPrefs = results.first ?? UserPreferences(context: context)
            
            userPrefs.lastSelectedTeaID = teaID
            userPrefs.lastUpdated = Date()
            
            try context.save()
            print("✅ Successfully saved last selected tea: \(teaID)")
        } catch {
            print("❌ Failed to save last selected tea: \(error)")
        }
    }
    
    func getLastSelectedTeaID(context: NSManagedObjectContext) -> String? {
        let request: NSFetchRequest<UserPreferences> = UserPreferences.fetchRequest()
        request.fetchLimit = 1
        
        do {
            let result = try context.fetch(request).first?.lastSelectedTeaID
            print("🔍 Loading last selected tea from CoreData: \(result ?? "none")")
            return result
        } catch {
            print("❌ Failed to fetch last selected tea: \(error)")
            return nil
        }
    }

    let container: NSPersistentContainer

    init(inMemory: Bool = false) {
        container = NSPersistentContainer(name: "Steep")
        if inMemory {
            container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
        }
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.

                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        container.viewContext.automaticallyMergesChangesFromParent = true
    }
}

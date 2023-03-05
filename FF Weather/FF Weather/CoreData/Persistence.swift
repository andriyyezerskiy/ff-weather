//
//  Persistence.swift
//  FF Weather
//
//  Created by Andriy Yezerskiy on 24/02/2023.
//

import CoreData

struct Persistence {
	
	// MARK: - Shared
	static let shared = Persistence()
	
	// MARK: - Properties
	let persistentContainer: NSPersistentContainer
	
	// MARK: - Init
	init(inMemory: Bool = false) {
		persistentContainer = NSPersistentContainer(name: "FF_Weather")
		if inMemory {
			persistentContainer.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
		}
		persistentContainer.loadPersistentStores { description, error in
			if let error = error {
				print("⚠️ Core Data failed to load: \(error.localizedDescription)")
			}
		}
		persistentContainer.viewContext.automaticallyMergesChangesFromParent = true
	}
	
	// MARK: - Helpers
	func saveContext() {
		if persistentContainer.viewContext.hasChanges {
			do {
				try persistentContainer.viewContext.save()
			} catch {
				print("⚠️ Failed to save view context! \(error)")
			}
		}
	}
}

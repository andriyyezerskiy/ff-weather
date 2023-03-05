//
//  AirportStorage.swift
//  FF Weather
//
//  Created by Andriy Yezerskiy on 03/03/2023.
//

import CoreData
import SwiftUI

@MainActor
final class AirportStorage: ObservableObject {
	
	// MARK: - Shared
	static let shared = AirportStorage()
	
	// MARK: - Properties
	private let persistence: Persistence = .shared
	
	@Published var persistentAirports: [PersistentAirport] = []
	
	// MARK: - Init
	init() {
		Task {
			await fetch()
		}
	}
	
	// MARK: - Operations
	func fetch() async {
		let request = NSFetchRequest<PersistentAirport>(entityName: "PersistentAirport")
		
		do {
			persistentAirports = try persistence.persistentContainer.viewContext.fetch(request)
		} catch {
			print("⚠️ Failed to fetch records! \(error)")
		}
	}
	
	// Ran low on time so saving data instead of mapped entities and attributes for each model
	func add(id: String, report: Data) async {
		if let existingObject = persistentAirports.first(where: {$0.id == id}) {
			existingObject.report = report
		} else {
			let persistentAirport = PersistentAirport(context: persistence.persistentContainer.viewContext)
			persistentAirport.id = id
			persistentAirport.report = report
		}
		
		await syncChanges()
	}
	
	func delete(with id: String) async {
		guard let objectToDelete = persistentAirports.first(where: {$0.id == id}) else { return }
		persistence.persistentContainer.viewContext.delete(objectToDelete)
		await syncChanges()
	}
	
	// MARK: - Helpers
	private func syncChanges() async {
		persistence.saveContext()
		await fetch()
	}
}

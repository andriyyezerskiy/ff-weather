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
	private let persistence: Persistence
	
	@Published var persistentAirports: [PersistentAirport] = []
	
	// MARK: - Init
	init(isPreview: Bool = false) {
		if isPreview {
			self.persistence = Persistence.preview
		} else {
			self.persistence = Persistence.shared
		}
		
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
	
	func add(airport: Airport) async {
		let persistentAirport = PersistentAirport(context: persistence.persistentContainer.viewContext)
		persistentAirport.id = airport.id
		
		await syncChanges()
	}
	
	func delete(with id: String) async {
		await syncChanges()
	}
	
	// MARK: - Helpers
	private func syncChanges() async {
		persistence.saveContext()
		await fetch()
	}
}

//
//  AirportListViewModel.swift
//  FF Weather
//
//  Created by Andriy Yezerskiy on 26/02/2023.
//

import Foundation
import Combine

@MainActor
class AirportListViewModel: ObservableObject {
	
	// MARK: - Constants
	let initialAirports: [String] = ["kpwm", "kaus"]
	
	// MARK: - Properties
	@Published var path: [Airport] = []
	@Published var airports: [Airport] = []
	@Published var inputText: String = ""
	@Published var errorMessage: String?
	
	@Published var persistentAirports: [PersistentAirport] = [] {
		didSet {
			Task { @MainActor in
				let airports: [Airport] = persistentAirports.map { persistentAirport in
					guard let reportData = persistentAirport.report else { return nil }
					
					do {
						let decoder = JSONDecoder()
						decoder.dateDecodingStrategy = .iso8601
						
						let report = try decoder.decode(Report.self, from: reportData)
						return Airport(report: report)
					} catch {
						print(error)
						return nil
					}
				}.compactMap { $0 }
				airports.forEach { addOrReplace(airport: $0) }
			}
		}
	}
	
	let airportStorage: AirportStorage = .shared
	
	private var cancellables = Set<AnyCancellable>()
	
	// MARK: - Init
	init() {
		getInitial()
		subscribeToItemStorage()
	}
	
	// MARK: - Actions
	func deleteItem(at offsets: IndexSet) {
		let idsToDelete = offsets.map { self.airports[$0].id }
		
		airports.remove(atOffsets: offsets)
		
		idsToDelete.forEach { id in
			Task {
				await airportStorage.delete(with: id)
			}
		}
	}
	
	// MARK: - Helpers
	func addOrReplace(airport: Airport) {
		if let index = airports.firstIndex(where: { $0.id == airport.id }) {
			airports[index] = airport
		} else {
			airports.append(airport)
		}
	}
	
	func getInitial() {
		initialAirports.forEach { airport in
			Task {
				do {
					let airport = try await getAirportReport(with: airport)
					addOrReplace(airport: airport)
				} catch {
					handle(error: error)
				}
			}
		}
	}
	
	func refetchExisting() async {
		airports.forEach { airport in
			Task {
				do {
					let airport = try await getAirportReport(with: airport.id)
					addOrReplace(airport: airport)
				} catch {
					handle(error: error)
				}
			}
		}
	}
	
	// Assuming all identifiers consist of letters and max 4 characters
	func sanitizeAndFormat(identifier: String) {
		let maxLenght = 4
		let allowedCharacterSet: CharacterSet = .letters
		
		inputText = String(identifier.unicodeScalars.filter { allowedCharacterSet.contains($0)}).prefix(maxLenght).uppercased()
	}
	
	func handle(error: Error) {
		if let apiError = (error as? ApiError) {
			switch apiError {
			case .requestFailed(let error):
				if let error {
					errorMessage = error.error
				} else {
					errorMessage = "Request Failed"
				}
			case .invalidURL:
				errorMessage = "Invalid URL"
			case .decodingFailed:
				errorMessage = "Decoding Failed"
			}
		} else {
			print(error.localizedDescription)
		}
	}
	
	func nullifyError() {
		errorMessage = nil
	}
	
	// MARK: - API
	func getAirportReportFromInput() async {
		do {
			let airport = try await getAirportReport(with: inputText)
			addOrReplace(airport: airport)
			path.append(airport)
		} catch {
			handle(error: error)
		}
	}
	
	func getAirportReport(with identifier: String) async throws -> Airport {
		guard let url = URL(string: "https://qa.foreflight.com/weather/report/\(identifier)") else { throw ApiError.invalidURL }
		var urlRequest = URLRequest(url: url)
		urlRequest.addValue("1", forHTTPHeaderField: "ff-coding-exercise")
		
		do {
			let (data, response) = try await URLSession.shared.data(for: urlRequest)
			let decoder = JSONDecoder()
			decoder.dateDecodingStrategy = .iso8601
			
			guard (response as? HTTPURLResponse)?.statusCode == 200 else {
				do {
					let error = try decoder.decode(ErrorDTO.self, from: data)
					throw ApiError.requestFailed(error: error)
				} catch {
					throw ApiError.decodingFailed(description: error.localizedDescription)
				}
			}
			do {
				let report = try decoder.decode(Report.self, from: data)
				await airportStorage.add(id: report.conditions.ident, report: data)
				
				return Airport(report: report)
			} catch {
				throw ApiError.decodingFailed(description: error.localizedDescription)
			}
		} catch {
			throw ApiError.requestFailed(error: nil)
		}
	}
	
	func subscribeToItemStorage() {
		airportStorage.$persistentAirports
			.receive(on: DispatchQueue.main)
			.sink(receiveValue: { [weak self] persistentAirport in
				guard let self = self else { return }
				self.persistentAirports = persistentAirport
			})
			.store(in: &cancellables)
	}
}

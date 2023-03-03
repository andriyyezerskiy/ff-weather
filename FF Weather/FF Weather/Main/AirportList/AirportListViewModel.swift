//
//  AirportListViewModel.swift
//  FF Weather
//
//  Created by Andriy Yezerskiy on 26/02/2023.
//

import Foundation

class AirportListViewModel: ObservableObject {
	
	// MARK: - Properties
	
	@Published var airports: [Airport] = [Airport(id: "kpwm"), Airport(id: "kaus")]
	@Published var inputText: String = ""
	
	// MARK: - Init
	
	// MARK: - Actions
	func deleteItem(at offsets: IndexSet) {
		airports.remove(atOffsets: offsets)
	}
	
	// MARK: - Helpers
	
	@MainActor func getAirport() async {
		guard let url = URL(string: "https://qa.foreflight.com/weather/report/\(inputText)") else { fatalError("URL failed, identifier: \(inputText)") }
		var urlRequest = URLRequest(url: url)
		urlRequest.addValue("1", forHTTPHeaderField: "ff-coding-exercise")
		
		do {
			let (data, response) = try await URLSession.shared.data(for: urlRequest)
			let decoder = JSONDecoder()
			decoder.dateDecodingStrategy = .iso8601
			let decoded = try decoder.decode(ReportDTO.self, from: data)
			print(response)
			print(decoded)
			let airport = Airport(report: decoded)
			airports.append(airport)
		} catch {
			print(error)
		}
	}
}

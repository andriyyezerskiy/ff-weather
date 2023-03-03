//
//  AirportListViewModel.swift
//  FF Weather
//
//  Created by Andriy Yezerskiy on 26/02/2023.
//

import Foundation

class AirportListViewModel: ObservableObject {
	
	// MARK: - Properties
	
	@Published var airports: [Airport] = [.preview]
	@Published var selection: Set<UUID> = .init()
	
	// MARK: - Init
	
	// MARK: - Helpers
	@MainActor func getAirport() async {
		guard let url = URL(string: "https://qa.foreflight.com/weather/report/kpwm") else { fatalError("URL failed") }
		var urlRequest = URLRequest(url: url)
		urlRequest.addValue("1", forHTTPHeaderField: "ff-coding-exercise")
		
		do {
			let (data, response) = try await URLSession.shared.data(for: urlRequest)
			let decoder = JSONDecoder()
			decoder.dateDecodingStrategy = .iso8601
			let decoded = try decoder.decode(ReportDTO.self, from: data)
			print(response)
			print(decoded)
		} catch {
			print(error)
		}
	}
}

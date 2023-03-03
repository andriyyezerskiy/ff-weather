//
//  Airport.swift
//  FF Weather
//
//  Created by Andriy Yezerskiy on 26/02/2023.
//

import Foundation

struct Airport: Identifiable, Hashable {
	
	// MARK: - Properties
	let id: String
	let dateIssued: Date
	let dateCached: Date
	let latitude: Double
	let longitude: Double
	let temperatureCelsius: Double
	let dewpointCelcius: Double
	var weather: [String]
	
	// MARK: - Init
	init(id: String, dateIssued: Date, dateCached: Date, latitude: Double, longitude: Double, temperatureCelsius: Double, dewpointCelcius: Double, weather: [String]) {
		self.id = id
		self.dateIssued = dateIssued
		self.dateCached = dateCached
		self.latitude = latitude
		self.longitude = longitude
		self.temperatureCelsius = temperatureCelsius
		self.dewpointCelcius = dewpointCelcius
		self.weather = weather
	}
	
	init(report: ReportDTO) {
		self.id = report.conditions.ident
		self.dateCached = Date()
		self.dateIssued = report.conditions.dateIssued
		self.latitude = report.conditions.lat
		self.longitude = report.conditions.lon
		self.temperatureCelsius = report.conditions.tempC
		self.dewpointCelcius = report.conditions.dewpointC
		self.weather = report.conditions.weather
	}

	// MARK: - Computed Properties
}

extension Airport {
	static let preview: Airport = Airport(
		id: "ekch",
		dateIssued: Date(),
		dateCached: Date(),
		latitude: 55.61791704449433,
		longitude: 12.655972010124776,
		temperatureCelsius: 3.0,
		dewpointCelcius: 1.0,
		weather: ["rainy", "windy"]
	)
}

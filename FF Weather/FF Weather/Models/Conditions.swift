//
//  Conditions.swift
//  FF Weather
//
//  Created by Andriy Yezerskiy on 26/02/2023.
//

import Foundation

struct Conditions: Decodable, Hashable {
	let text: String
	let ident: String
	let dateIssued: Date
	let lat: Double
	let lon: Double
	let elevationFt: Double
	let tempC: Int
	let dewpointC: Int
	let pressureHg: Double
	let pressureHpa: Double
	let reportedAsHpa: Bool
	let densityAltitudeFt: Double
	let relativeHumidity: Double
	let flightRules: String
	let visibility: Visibility
	let wind: Wind?
	let weather: [String]
}

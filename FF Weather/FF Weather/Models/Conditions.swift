//
//  Conditions.swift
//  FF Weather
//
//  Created by Andriy Yezerskiy on 26/02/2023.
//

import Foundation

struct Conditions: Decodable {
	let text: String
	let ident: String
	let dateIssued: Date
	let lat: Double
	let lon: Double
	let elevationFt: Double
	let tempC: Double
	let dewpointC: Double
	let pressureHg: Double
	let pressureHpa: Double
	let reportAsHpa: Bool
	let densityAltitudeFt: Double
	let relativeHumidity: Double
	let flightRules: String
	let cloudLayersV2: [CloudLayer]
	let visibility: Visibility
	let wind: Wind
}

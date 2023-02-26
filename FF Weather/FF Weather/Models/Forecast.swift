//
//  Forecast.swift
//  FF Weather
//
//  Created by Andriy Yezerskiy on 26/02/2023.
//

import Foundation

struct Forecast: Decodable {
	let text: String
	let ident: String
	let dateIssued: Date
	let period: Period
	let lat: Double
	let lon: Double
	let elevationFt: Double
	let conditions: [Conditions]
	
	struct Conditions: Decodable {
		let text: String
		let dateIssued: Date
		let lat: Double
		let lon: Double
		let elevationFt: Double
		let relativeHumidity: Double
		let flightRules: String
		let cloudLayersV2: [CloudLayer]
		let visibility: Visibility
		let wind: Wind
		let period: Period
	}
}

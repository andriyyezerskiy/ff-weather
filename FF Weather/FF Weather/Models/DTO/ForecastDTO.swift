//
//  ForecastDTO.swift
//  FF Weather
//
//  Created by Andriy Yezerskiy on 26/02/2023.
//

import Foundation

struct ForecastDTO: Decodable {
	let text: String
	let ident: String
	let dateIssued: Date
	let period: PeriodDTO
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
		let cloudLayersV2: [CloudLayersDTO]
		let visibility: VisibilityDTO
		let wind: WindDTO
		let period: PeriodDTO
		let weather: [String]
	}
}

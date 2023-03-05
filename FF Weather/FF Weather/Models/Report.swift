//
//  Report.swift
//  FF Weather
//
//  Created by Andriy Yezerskiy on 26/02/2023.
//

import Foundation

struct Report: Decodable, Hashable {
	
	// MARK: - Properties
	let conditions: Conditions
	let forecast: Forecast
	
	// MARK: - Coding Keys
	enum CodingKeys: CodingKey {
		case report
	}
	
	enum ReportKeys: CodingKey {
		case conditions
		case forecast
	}
	
	// MARK: - Init
	init(from decoder: Decoder) throws {
		// Decode report to avoid unnecessary wrapper model
		let container = try decoder.container(keyedBy: CodingKeys.self)

		let report = try container.nestedContainer(keyedBy: ReportKeys.self, forKey: .report)
		
		self.conditions = try report.decode(Conditions.self, forKey: .conditions)
		self.forecast = try report.decode(Forecast.self, forKey: .forecast)
	}
	
	init(conditions: Conditions, forecast: Forecast) {
		self.conditions = conditions
		self.forecast = forecast
	}
}

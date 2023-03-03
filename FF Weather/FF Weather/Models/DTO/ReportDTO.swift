//
//  ReportDTO.swift
//  FF Weather
//
//  Created by Andriy Yezerskiy on 26/02/2023.
//

import Foundation

struct ReportDTO: Decodable {
	// MARK: - Properties
	let conditions: ConditionsDTO
	let forecast: ForecastDTO
	
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
		
		self.conditions = try report.decode(ConditionsDTO.self, forKey: .conditions)
		self.forecast = try report.decode(ForecastDTO.self, forKey: .forecast)
	}
}

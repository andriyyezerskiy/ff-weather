//
//  AirportDetailsViewModel.swift
//  FF Weather
//
//  Created by Andriy Yezerskiy on 04/03/2023.
//

import Foundation

// Refactor from computing properties to mapping functions
// Generalise approach between forecast and conditions

class AirportDetailsViewModel: ObservableObject {
	
	// MARK: - Properties
	let airport: Airport
	
	@Published var selectedSegment: AirportDetailsSegment = .conditions
	
	// MARK: - Init
	init(airport: Airport) {
		self.airport = airport
	}
	
	// MARK: - Computer properties
	var title: String {
		airport.id.uppercased()
	}
	
	var sections: [Section] {
		[
			.init(type: .general, fields: generalSectionFields),
			.init(type: .visibility, fields: visibilitySectionFields),
			.init(type: .wind, fields: windSectionFields)
		]
	}
	
	var generalSectionFields: [SectionField] {
		[
			.init(type: .dateIssued, value: dateIssuedFormatted),
			.init(type: .temperature, value: temperatureFormatted),
			.init(type: .dewpoint, value: dewpointFormatted),
			.init(type: .elevation, value: elevetaionFormatted),
			.init(type: .weather, value: weatherFormatted),
			.init(type: .pressureHg, value: pressureHgFormatted),
			.init(type: .pressureHpa, value: pressureHpaFormatted),
			.init(type: .densityAltitudeFt, value: densityAltitudeFormatted),
			.init(type: .relativeHumidity, value: relativeHumidityFormatted),
			.init(type: .flightRules, value: airport.report.conditions.flightRules)
		]
	}
	
	var visibilitySectionFields: [SectionField] {
		[
			.init(type: .visibilityDistanceSm, value: visibilityDistanceSmFormatted),
			.init(type: .visibilityDistanceQualifier, value: visibilityDistanceQualifierFormatted),
			.init(type: .visibilityPrevailingVisSm, value: visibilityPrevailingVisSmFormatted),
			.init(type: .visibilityPrevailingVisDistanceQualifier, value: visibilityPrevailingVisDistanceQualifierFormatted)
		]
	}
	
	var windSectionFields: [SectionField] {
		[
			.init(type: .speedKts, value: windSpeedFormatted),
			.init(type: .direction, value: windDirection),
			.init(type: .from, value: windFromFormatted),
			.init(type: .variable, value: windVariableFormatted)
		]
	}
	
	var dateIssuedFormatted: String {
		airport.report.conditions.dateIssued.formatted()
	}
	
	var temperatureFormatted: String {
		"\(airport.report.conditions.tempC) °C"
	}
	
	var dewpointFormatted: String {
		"\(airport.report.conditions.dewpointC) °C"
	}
	
	var weatherFormatted: String {
		if airport.report.conditions.weather.isEmpty {
			return "N/A"
		} else {
			return airport.report.conditions.weather
				.map({ $0.capitalized })
				.joined(separator:", ")
		}
	}
	
	var elevetaionFormatted: String {
		"\(airport.report.conditions.elevationFt) ft"
	}
	
	var pressureHgFormatted: String {
		"\(airport.report.conditions.pressureHg) Hg"
	}
	
	var pressureHpaFormatted: String {
		"\(airport.report.conditions.pressureHpa) hPa"
	}
	
	var densityAltitudeFormatted: String {
		"\(airport.report.conditions.densityAltitudeFt) ft"
	}
	
	var relativeHumidityFormatted: String {
		"\(airport.report.conditions.relativeHumidity) %"
	}
	
	var visibilityDistanceSmFormatted: String {
		"\(airport.report.conditions.visibility.distanceSm) SM"
	}
	
	var visibilityDistanceQualifierFormatted: String {
		if let distanceQualifier = airport.report.conditions.visibility.distanceQualifier {
			return "\(distanceQualifier)"
		} else {
			return "N/A"
		}
	}
	
	var visibilityPrevailingVisSmFormatted: String {
		"\(airport.report.conditions.visibility.prevailingVisSm) SM"
	}
	
	var visibilityPrevailingVisDistanceQualifierFormatted: String {
		if let prevailingDistanceQualifier = airport.report.conditions.visibility.prevailingVisDistanceQualifier {
			return "\(prevailingDistanceQualifier)"
		} else {
			return "N/A"
		}
	}
	
	var windSpeedFormatted: String {
		if let windSpeed = airport.report.conditions.wind?.speedKts {
			return "\(windSpeed)"
		} else {
			return "N/A"
		}
	}
	
	var windDirection: String {
		if let windDirection = airport.report.conditions.wind?.direction {
			return "\(windDirection)"
		} else {
			return "N/A"
		}
	}
	
	var windFromFormatted: String {
		if let windFrom = airport.report.conditions.wind?.from {
			return "\(windFrom)"
		} else {
			return "N/A"
		}
	}
	
	var windVariableFormatted: String {
		if let windVariable = airport.report.conditions.wind?.variable {
			return windVariable ? "Yes" : "No"
		} else {
			return "N/A"
		}
	}
	
	var forecastPeriod: String {
		"\(airport.report.forecast.period.dateStart.formatted()) - \(airport.report.forecast.period.dateEnd.formatted())"
	}
}

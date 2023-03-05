//
//  Section.swift
//  FF Weather
//
//  Created by Andriy Yezerskiy on 05/03/2023.
//

import Foundation

struct Section: Identifiable {
	let type: SectionType
	let fields: [SectionField]
	
	var id: Int { self.type.rawValue }
	
	enum SectionType: Int, CaseIterable {
		case general
		case visibility
		case wind
		
		var title: String {
			switch self {
			case .general:
				return "General"
			case .visibility:
				return "Visibility"
			case .wind:
				return "Wind"
			}
		}
	}
}

struct SectionField: Identifiable {
	let type: SectionFieldType
	let value: String
	
	var id: Int { self.type.rawValue }
	
	enum SectionFieldType: Int {
		case dateIssued
		case temperature
		case dewpoint
		case elevation
		case weather
		case pressureHg
		case pressureHpa
		case densityAltitudeFt
		case relativeHumidity
		case flightRules
		case visibilityDistanceSm
		case visibilityDistanceQualifier
		case visibilityPrevailingVisSm
		case visibilityPrevailingVisDistanceQualifier
		case speedKts
		case direction
		case from
		case variable
		
		var title: String {
			switch self {
			case .dateIssued:
				return "Date Issued"
			case .temperature:
				return "Temperature"
			case .dewpoint:
				return "Dewpoint"
			case .elevation:
				return "Elevation"
			case .weather:
				return "Weather"
			case .pressureHg:
				return "Pressure (Hg)"
			case .pressureHpa:
				return "Pressure (hPa)"
			case .densityAltitudeFt:
				return "Altitude Density"
			case .relativeHumidity:
				return "Relative Humidity"
			case .flightRules:
				return "Flight Rules"
			case .visibilityDistanceSm:
				return "Distance"
			case .visibilityDistanceQualifier:
				return "Distance Qualifier"
			case .visibilityPrevailingVisSm:
				return "Prevailing Visibility"
			case .visibilityPrevailingVisDistanceQualifier:
				return "Prevailing Visibility Distance"
			case .speedKts:
				return "Speed"
			case .direction:
				return "Direction"
			case .from:
				return "From"
			case .variable:
				return "Variable"
			}
		}
	}
}

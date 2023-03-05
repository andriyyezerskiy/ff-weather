//
//  AirportDetailsSegment.swift
//  FF Weather
//
//  Created by Andriy Yezerskiy on 05/03/2023.
//

import Foundation

enum AirportDetailsSegment: Int, Identifiable, CaseIterable {
	case conditions
	case forecast
	
	var id: Int { self.rawValue }
	
	var title: String {
		switch self {
		case .conditions:
			return "Conditions"
		case .forecast:
			return "Forecast"
		}
	}
}

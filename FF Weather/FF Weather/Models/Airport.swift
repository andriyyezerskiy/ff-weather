//
//  Airport.swift
//  FF Weather
//
//  Created by Andriy Yezerskiy on 26/02/2023.
//

import Foundation

struct Airport: Decodable {
	
	// MARK: - Properties
	let report: Report
	
	// MARK: - Computed Properties
	var identifierCode: String { report.conditions.ident }
}

extension Airport: Identifiable {
	var id: String { report.conditions.ident }
}

extension Airport {
	static let preview: Airport = Airport(
		report: Report(
			conditions: Conditions(
				text: "METAR EKCH 242020Z 32006KT 9999 BKN012 03/01 Q0991 TEMPO BKN009",
				ident: "ekch",
				dateIssued: Date(),
				lat: 55.61791704449433,
				lon: 12.655972010124776,
				elevationFt: 17.0,
				tempC: 3.0,
				dewpointC: 1.0,
				pressureHg: 29.26,
				pressureHpa: 991.0,
				reportAsHpa: true,
				densityAltitudeFt: -567,
				relativeHumidity: 87,
				flightRules: "mvfr",
				cloudLayersV2: [
					CloudLayer(
						coverage: "bkn",
						altitudeFt: 1200.0,
						ceiling: true
					)
				],
				visibility: Visibility(
					distanceSm: 6.21,
					distanceQualifier: 1,
					prevailingVisSm: 6.21,
					prevailingVisDistanceQualifier: 1
				),
				wind: Wind(
					speedKts: 6.0,
					direction: 320,
					from: 320,
					variable: false
				)
			),
			forecast: Forecast(
				text: "TAF EKCH 241711Z 2418/2518 28010KT 9999 BKN020 TEMPO 2418/2423 BKN006 BECMG 2421/2423 35020G30KT TEMPO 2423/2505 35020KT 4000 -SN BKN012 TEMPO 2505/2518 35020KT",
				ident: "ekch",
				dateIssued: Date(),
				period: Period(
					dateStart: Date(),
					dateEnd: Date()
				),
				lat: 55.61791704449433,
				lon: 12.655972010124776,
				elevationFt: 17.0,
				conditions: [
					Forecast.Conditions(
						text: "241711Z 2418/2518 28010KT 9999 BKN020",
						dateIssued: Date(),
						lat: 55.61791704449433,
						lon: 12.655972010124776,
						elevationFt: 17.0,
						relativeHumidity: 100,
						flightRules: "mvfr",
						cloudLayersV2: [
							CloudLayer(
								coverage: "bkn",
								altitudeFt: 2000.0,
								ceiling: true
							)
						],
						visibility: Visibility(
							distanceSm: 6.21,
							distanceQualifier: 1,
							prevailingVisSm: 6.21,
							prevailingVisDistanceQualifier: 1
						),
						wind: Wind(
							speedKts: 10.0,
							direction: 280,
							from: 280,
							variable: false
						),
						period: Period(
							dateStart: Date(),
							dateEnd: Date()
						)
					)
				]
			)
		)
	)
}

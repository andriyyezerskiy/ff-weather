//
//  Report.swift
//  FF Weather
//
//  Created by Andriy Yezerskiy on 26/02/2023.
//

import Foundation

struct Report: Decodable {
	let conditions: Conditions
	let forecast: Forecast
}

//
//  CloudLayers.swift
//  FF Weather
//
//  Created by Andriy Yezerskiy on 26/02/2023.
//

import Foundation

struct CloudLayer: Decodable {
	let coverage: String
	let altitudeFt: Double
	let ceiling: Bool
}

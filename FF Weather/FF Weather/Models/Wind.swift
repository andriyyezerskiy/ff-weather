//
//  Wind.swift
//  FF Weather
//
//  Created by Andriy Yezerskiy on 26/02/2023.
//

import Foundation

struct Wind: Decodable {
	let speedKts: Double
	let direction: Double
	let from: Double
	let variable: Bool
}

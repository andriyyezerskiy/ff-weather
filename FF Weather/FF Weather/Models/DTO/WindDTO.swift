//
//  WindDTO.swift
//  FF Weather
//
//  Created by Andriy Yezerskiy on 26/02/2023.
//

import Foundation

struct WindDTO: Decodable {
	let speedKts: Double
	let direction: Double
	let from: Double
	let variable: Bool
}

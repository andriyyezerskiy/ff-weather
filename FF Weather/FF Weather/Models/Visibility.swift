//
//  Visibility.swift
//  FF Weather
//
//  Created by Andriy Yezerskiy on 26/02/2023.
//

import Foundation

struct Visibility: Decodable, Hashable {
	let distanceSm: Double
	let distanceQualifier: Int?
	let prevailingVisSm: Double
	let prevailingVisDistanceQualifier: Int?
}

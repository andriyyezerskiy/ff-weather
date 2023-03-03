//
//  VisibilityDTO.swift
//  FF Weather
//
//  Created by Andriy Yezerskiy on 26/02/2023.
//

import Foundation

struct VisibilityDTO: Decodable {
	let distanceSm: Double
	let distanceQualifier: Int?
	let prevailingVisSm: Double
	let prevailingVisDistanceQualifier: Int?
}

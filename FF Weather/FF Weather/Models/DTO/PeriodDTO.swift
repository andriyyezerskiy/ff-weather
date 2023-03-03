//
//  PeriodDTO.swift
//  FF Weather
//
//  Created by Andriy Yezerskiy on 26/02/2023.
//

import Foundation

struct PeriodDTO: Decodable {
	let dateStart: Date
	let dateEnd: Date
}

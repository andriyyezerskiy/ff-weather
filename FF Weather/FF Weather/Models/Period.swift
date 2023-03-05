//
//  Period.swift
//  FF Weather
//
//  Created by Andriy Yezerskiy on 26/02/2023.
//

import Foundation

struct Period: Decodable, Hashable {
	let dateStart: Date
	let dateEnd: Date
}

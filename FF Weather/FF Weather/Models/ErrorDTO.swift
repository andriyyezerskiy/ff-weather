//
//  ErrorDTO.swift
//  FF Weather
//
//  Created by Andriy Yezerskiy on 03/03/2023.
//

import Foundation

struct ErrorDTO: Decodable {
	let timestamp: Int
	let status: Int
	let error: String
	let path: String
}

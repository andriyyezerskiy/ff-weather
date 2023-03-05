//
//  APIError.swift
//  FF Weather
//
//  Created by Andriy Yezerskiy on 04/03/2023.
//

import Foundation

enum ApiError: Error {
	case requestFailed(error: ErrorDTO?)
	case invalidURL
	case decodingFailed(description: String)
}

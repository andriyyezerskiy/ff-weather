//
//  AirportListViewModel.swift
//  FF Weather
//
//  Created by Andriy Yezerskiy on 26/02/2023.
//

import Foundation

class AirportListViewModel: ObservableObject {
	
	// MARK: - Properties
	
	@Published var airports: [Airport] = [.preview]
	@Published var selection: Set<UUID> = .init()
	
	// MARK: - Init
	
	// MARK: - Helpers
}

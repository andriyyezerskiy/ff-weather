//
//  AirportListView.swift
//  FF Weather
//
//  Created by Andriy Yezerskiy on 26/02/2023.
//

import SwiftUI
import CoreData

struct AirportListView: View {
	
	@StateObject var viewModel: AirportListViewModel = .init()
	
	@State private var presentedAirports: [Airport] = []

    var body: some View {
		NavigationStack {
			List(viewModel.airports, selection: $viewModel.selection) { airport in
				VStack(alignment: .leading) {
					Text(airport.id.uppercased())
										
					Text("Last updated: \(airport.dateIssued.formatted(date: .abbreviated, time: .shortened))")
				}
			}
			.navigationTitle("Airports")
		}.task {
			await viewModel.getAirport()
		}
    }
}

struct AirportListView_Previews: PreviewProvider {
    static var previews: some View {
		AirportListView()
    }
}

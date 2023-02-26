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

    var body: some View {
		NavigationStack {
			List(viewModel.airports, selection: $viewModel.selection) { location in
				Text(location.identifierCode.uppercased())
			}
			.navigationTitle("Airports")
		}
    }
}

struct AirportListView_Previews: PreviewProvider {
    static var previews: some View {
		AirportListView()
    }
}

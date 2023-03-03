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
			List {
				ForEach($viewModel.airports) { airport in
					AirportItemView(airport: airport)
				}
				.onDelete(perform: viewModel.deleteItem)
			}
			.safeAreaInset(edge: .bottom, spacing: 0) {
				AirportInputView(viewModel: viewModel)
			}
			.navigationTitle("Airports")
			.toolbar {
				EditButton()
			}
		}
    }
}

struct AirportListView_Previews: PreviewProvider {
    static var previews: some View {
		AirportListView()
    }
}

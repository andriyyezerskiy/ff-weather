//
//  AirportListView.swift
//  FF Weather
//
//  Created by Andriy Yezerskiy on 26/02/2023.
//

import SwiftUI

struct AirportListView: View {
	
	@StateObject var viewModel: AirportListViewModel = .init()
	
	// Timer with 15 minute interval
	let timer = Timer.publish(every: 900, on: .main, in: .common).autoconnect()
	
    var body: some View {
		NavigationStack(path: $viewModel.path) {
			List {
				ForEach(viewModel.airports) { airport in
					NavigationLink(value: airport) {
						AirportItemView(airport: airport)
					}
				}
				.onDelete(perform: { offset in
					viewModel.deleteItem(at: offset)
				})
				.onReceive(timer) { _ in
					Task {
						await viewModel.refetchExisting()
					}
				}
			}
			.safeAreaInset(edge: .bottom, spacing: 0) {
				AirportInputView(viewModel: viewModel)
			}
			.toolbar {
				EditButton()
			}
			
			.navigationTitle("Airports")
			.navigationDestination(for: Airport.self) { airport in
				let viewModel = AirportDetailsViewModel(airport: airport)
				AirportDetailsView(viewModel: viewModel)
			}
			.onChange(of: viewModel.path) { _ in
				// Dirty fix to prevent safe area inset view from retaining offset y position when keyboard is displayed and navigation link is presented.
				// Possibly a SwiftUI bug
				// Could be improved with FocusState implementation for TextField
				UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
			}
		}
    }
}

struct AirportListView_Previews: PreviewProvider {
    static var previews: some View {
		AirportListView()
    }
}

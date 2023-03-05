//
//  AirportDetailsView.swift
//  FF Weather
//
//  Created by Andriy Yezerskiy on 04/03/2023.
//

import SwiftUI
import MapKit

struct AirportDetailsView: View {
		
	@ObservedObject var viewModel: AirportDetailsViewModel
	
    var body: some View {
		ScrollView {
			VStack(spacing: 16) {
				Picker("", selection: $viewModel.selectedSegment) {
					ForEach(AirportDetailsSegment.allCases) { segment in
						Text(segment.title)
							.tag(segment)
					}
				}
				.pickerStyle(SegmentedPickerStyle())
				
				switch viewModel.selectedSegment {
				case .conditions:
					VStack(alignment: .leading) {
						ForEach(viewModel.sections) { section in
							Text(section.type.title)
								.fontWeight(.semibold)
								.padding(.leading)
							
							VStack(alignment: .leading, spacing: 6) {
								ForEach(section.fields) { field in
									DetailsSectionField(title: field.type.title, value: field.value)
								}
							}.materialContainer()
						}
					}
					
					VStack(alignment: .leading) {
						Text("Location")
							.fontWeight(.semibold)
							.padding(.leading)
						
						AirportMapView(coordinateRegion: MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: viewModel.airport.report.conditions.lat, longitude: viewModel.airport.report.conditions.lon), span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)))
					}
			
				case .forecast:
					VStack(alignment: .leading) {
						Text(viewModel.forecastPeriod)
							.fontWeight(.semibold)
						
						
					}
				}
			}
			.padding()
			.navigationTitle(viewModel.title)
		}
    }
}

struct AirportDetailsView_Previews: PreviewProvider {
    static var previews: some View {
		AirportDetailsView(viewModel: .init(airport: .preview))
    }
}

struct DetailsSectionField: View {
	
	let title: String
	let value: String
	
	var body: some View {
		HStack {
			Text(title)
				.fontWeight(.medium)

			Spacer()
			
			Text(value)
				.multilineTextAlignment(.trailing)
		}
	}
}

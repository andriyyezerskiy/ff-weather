//
//  AirportMapView.swift
//  FF Weather
//
//  Created by Andriy Yezerskiy on 04/03/2023.
//

import SwiftUI
import MapKit

struct AirportMapView: View {
	
	@State var coordinateRegion: MKCoordinateRegion
	
    var body: some View {
		Map(coordinateRegion: $coordinateRegion)
			.frame(height: 300)
			.cornerRadius(16)
    }
}

struct AirportMapView_Previews: PreviewProvider {
    static var previews: some View {
		AirportMapView(coordinateRegion: MKCoordinateRegion())
    }
}

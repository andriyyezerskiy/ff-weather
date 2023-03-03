//
//  AirportItemView.swift
//  FF Weather
//
//  Created by Andriy Yezerskiy on 03/03/2023.
//

import SwiftUI

struct AirportItemView: View {
	
	@Binding var airport: Airport
	
	var body: some View {
		VStack(alignment: .leading) {
			Text(airport.id.uppercased())
		}
	}
}

struct AirportItemView_Previews: PreviewProvider {
    static var previews: some View {
		AirportItemView(airport: .constant(.preview))
    }
}

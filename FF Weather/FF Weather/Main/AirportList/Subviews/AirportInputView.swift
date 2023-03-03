//
//  AirportInputView.swift
//  FF Weather
//
//  Created by Andriy Yezerskiy on 03/03/2023.
//

import SwiftUI

struct AirportInputView: View {
	
	@ObservedObject var viewModel: AirportListViewModel
	
	var body: some View {
		HStack {
			AppTextField(placeholder: "Airport Identifier ex: KPWM", inputText: $viewModel.inputText)
				.onChange(of: viewModel.inputText) { newValue in
					sanitizeAndFormat(identifier: newValue)
				}
			
			Button("Add") {
				Task {
					await viewModel.getAirport()
				}
			}
			.buttonStyle(.borderedProminent)
		}
		.padding(.all)
		.background(Color.white)
	}
	
	// Assuming all identifiers consist of letters and max 4 characters
	private func sanitizeAndFormat(identifier: String) {
		let maxLenght = 4
		let allowedCharacterSet: CharacterSet = .letters
		
		viewModel.inputText = String(identifier.unicodeScalars.filter { allowedCharacterSet.contains($0)}).prefix(maxLenght).uppercased()
	}
}

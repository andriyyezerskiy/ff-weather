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
		VStack(alignment: .leading) {
			HStack {
				AppTextField(placeholder: "Airport Identifier ex: KPWM", inputText: $viewModel.inputText)
					.onChange(of: viewModel.inputText) { newValue in
						viewModel.sanitizeAndFormat(identifier: newValue)
						viewModel.nullifyError()
					}
				
				Button("Add") {
					Task {
						await viewModel.getAirportReportFromInput()
					}
				}
				.buttonStyle(.borderedProminent)
			}
			.animation(.easeInOut, value: viewModel.inputText)
			
			if let errorMessage = viewModel.errorMessage {
				Text(errorMessage)
					.font(.caption)
					.foregroundColor(.red)
			}
		}
		.padding(.all)
		.background(Color.white)
		.animation(.easeInOut, value: viewModel.errorMessage)
	}
	
	
}

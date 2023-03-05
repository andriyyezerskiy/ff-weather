//
//  AppTextField.swift
//  FF Weather
//
//  Created by Andriy Yezerskiy on 03/03/2023.
//

import SwiftUI

struct AppTextField: View {
	let placeholder: String
	@Binding var inputText: String
	
	var body: some View {
		HStack {
			TextField(placeholder, text: $inputText)
				.keyboardType(.alphabet)
				.textInputAutocapitalization(.characters)
				.disableAutocorrection(true)
			
			if !inputText.isEmpty {
				Button {
					inputText = ""
				} label: {
					Image(systemName: "xmark.circle.fill")
						.tint(.gray)
				}
			}
		}
		.padding(.vertical, 7)
		.padding(.horizontal, 12)
		.background(Material.ultraThick, in: RoundedRectangle(cornerRadius: 8))
	}
}

struct AppTextField_Previews: PreviewProvider {
    static var previews: some View {
		AppTextField(placeholder: "Placeholder text", inputText: .constant(""))
    }
}

//
//  ContainerModifier.swift
//  FF Weather
//
//  Created by Andriy Yezerskiy on 04/03/2023.
//

import SwiftUI

struct Container: ViewModifier {
	func body(content: Content) -> some View {
		content
			.frame(maxWidth: .infinity)
			.padding()
			.background(Material.ultraThick)
			.cornerRadius(16)
	}
}

extension View {
	func materialContainer() -> some View {
		modifier(Container())
	}
}

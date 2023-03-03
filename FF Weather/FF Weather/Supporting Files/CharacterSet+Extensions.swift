//
//  CharacterSet+Extensions.swift
//  FF Weather
//
//  Created by Andriy Yezerskiy on 03/03/2023.
//

import Foundation

extension CharacterSet {
	// Stolen from https://stackoverflow.com/a/42895178
	func codePoints() -> [Int] {
		var result: [Int] = []
		var plane = 0
		for (i, w) in bitmapRepresentation.enumerated() {
			let k = i % 8193
			if k == 8192 {
				plane = Int(w) << 13
				continue
			}
			let base = (plane + k) << 3
			for j in 0 ..< 8 where w & 1 << j != 0 {
				result.append(base + j)
			}
		}
		return result
	}
	
	func characters() -> [Character] {
		return codePoints().compactMap { UnicodeScalar($0) }.map { Character($0) }
	}
	
	func randomString(length: Int) -> String {
		let charArray = characters()
		let charArrayCount = UInt32(charArray.count)
		var randomString = ""
		for _ in 0 ..< length {
			randomString += String(charArray[Int(arc4random_uniform(charArrayCount))])
		}
		return randomString
	}
}

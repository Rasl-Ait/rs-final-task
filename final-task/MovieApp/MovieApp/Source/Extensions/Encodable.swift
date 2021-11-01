//
//  Encodable.swift
//  1Kvik
//
//  Created by rasul on 10/14/20.
//

import UIKit

extension Encodable {
	func data(using encoder: JSONEncoder = JSONEncoder()) throws -> Data { try encoder.encode(self) }
	func string(using encoder: JSONEncoder = JSONEncoder()) throws -> String { try data(using: encoder).string() }
	
	func jsonData() throws -> Data {
		let encoder = JSONEncoder()
		encoder.outputFormatting = [.sortedKeys, .prettyPrinted]
		encoder.dateEncodingStrategy = .iso8601
		return try encoder.encode(self)
	}
	
	func toData<T: Encodable>(object: T) throws -> Data {
		let encoder = JSONEncoder()
		encoder.outputFormatting = .sortedKeys
		return try encoder.encode(object)
	}
}

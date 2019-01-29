//
//  URLSession-Decoder.swift
//  Ripple
//
//  Created by Jordan Dumlao on 1/29/19.
//  Copyright © 2019 Jordan Dumlao. All rights reserved.
//

import Foundation

extension URLSession {
	static func decode <T: Codable>(_ type: T.Type, fromURL url: URL, completion: @escaping (T) -> Void) {
		let session = URLSession.shared.dataTask(with: url) { (data, response, error) in
			guard let data = data else { return }
			let decoder = JSONDecoder()
			do {
				let newData = try decoder.decode(T.self, from: data)
				completion(newData)
			} catch {
				print(error)
			}
			
		}
		session.resume()
	}
}

//
//  Photo.swift
//  Ripple
//
//  Created by Jordan Dumlao on 1/28/19.
//  Copyright © 2019 Jordan Dumlao. All rights reserved.
//

import Foundation

struct Photo: Codable {
	let id: String
	let width: Int
	let height: Int
	let color: String
	let downloads: Int
	let urls: [String: String]

	func photoURL(ofSize size: PhotoSize) -> String {
		let urlString = self.urls[size.rawValue]!
		return urlString
	}
	
	enum PhotoSize: String {
		case thumb
		case raw
		case full
		case regular
		case small
	}
}

class Unsplasher {
	
	private let accessKey = "37e5157585105c69309f92586416c32a29df22cf819c4f402639c81e93bcd714"
	private let accessKey2 = "f190ce92df46583ec08483d28e58e13a3ffae8de25efe2bded47f2fdfa05fbee"
	private var clientID: URLQueryItem { return URLQueryItem(name: "client_id", value: accessKey2) }
	
	private var urlComponents: URLComponents = {
		var urlC = URLComponents()
		urlC.scheme = "https"
		urlC.host = "api.unsplash.com"
		urlC.path = "/photos/random/"
		return urlC
	}()
	
	func getRandomPhoto(forOrientation orientation: Orientation? = nil, completion: @escaping (Photo) -> Void) {
		resetQueries()
		if let orientation = orientation {
			let orientationQuery = URLQueryItem(name: "orientation", value: orientation.rawValue)
			urlComponents.queryItems?.append(orientationQuery)
		}
		URLSession.decode(Photo.self, fromURL: urlComponents.url!, completion: { photo in
			completion(photo)
		})
	}
	
	private func resetQueries() {
		urlComponents.queryItems = [clientID]
	}
	
	enum Orientation: String {
		case landscape
		case portrait
		case squarish
	}
}

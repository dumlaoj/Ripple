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
	let downloads: Int
	let likes: Int
	let urls: [String: String]
	let user: User?
	let location: Location?
	
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
	
	init() {
		self.id = ""
		self.downloads = 0
		self.likes = 0
		self.urls = [:]
		self.user = nil
		self.location = nil
	}
}

struct User: Codable {
	let id: String
	let username: String
	let name: String
}

struct Location: Codable {
	let city: String?
	let country: String?
}

class Unsplasher {
	
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
		print(urlComponents.url ?? "Cannot print URL")
		print("\n")
		URLSession.decode(Photo.self, fromURL: urlComponents.url!, completion: { photo in
			completion(photo)
		})
	}
	
	private func resetQueries() {
		/* 	HOW TO QUERY A COLLECTION TYPE	*/
//		let collectionQueryItem = URLQueryItem(name: "collection", value: "nature")
		
		urlComponents.queryItems = [clientID]
		
	}
	
	enum Orientation: String {
		case landscape
		case portrait
		case squarish
	}
}

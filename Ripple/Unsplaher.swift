//
//  Unsplaher.swift
//  Ripple
//
//  Created by Jordan Dumlao on 1/30/19.
//  Copyright © 2019 Jordan Dumlao. All rights reserved.
//

import Foundation

class Unsplasher {
	
	let accessKey = "PLACE ACCESS CODE HERE"
	//	AFTER PLACING ACCESS KEY IN THE VAR ABOVE. CHANGE THE VAR OF VALUE BELOW TO 'accessKey'
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

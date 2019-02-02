//
//  Unsplaher.swift
//  Ripple
//
//  Created by Jordan Dumlao on 1/30/19.
//  Copyright © 2019 Jordan Dumlao. All rights reserved.
//

import Foundation

class Unsplasher {
	
	//	let accessKey = "PLACE ACCESS CODE HERE"
	//	AFTER PLACING ACCESS KEY IN THE VAR ABOVE. CHANGE THE VAR OF VALUE BELOW TO 'accessKey'
	private var clientID: URLQueryItem { return URLQueryItem(name: "client_id", value: accessKey) }
	
	private var urlComponents: URLComponents = {
		var urlC = URLComponents()
		urlC.scheme = "https"
		urlC.host = "api.unsplash.com"
		return urlC
	}()
	
	func getRandomPhoto(forOrientation orientation: Orientation? = nil, completion: @escaping (Photo) -> Void) {
		resetQueries()
		urlComponents.path = Path.randomPhoto.pathString
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
	
	func getUserProfile(forUsername username: String, completion: @escaping (UserProfile) -> Void) {
		resetQueries()
		urlComponents.path = Path.user(username).pathString
		print(urlComponents.url ?? "Cannot print URL")

		URLSession.decode(UserProfile.self, fromURL: urlComponents.url!, completion: { userProfile in
			completion(userProfile)
		})
	}
	
	private func resetQueries() {
		urlComponents.queryItems = [clientID]
	}
	
	enum Path {
		case randomPhoto
		case user(String?)
		
		var pathString: String {
			switch self {
			case .randomPhoto:
				return "/photos/random/"
			case .user(let username):
				return "/users/\(username ?? "")"
			}
		}
	}
	
	enum Orientation: String {
		case landscape
		case portrait
		case squarish
	}
}

/* 	HOW TO QUERY A COLLECTION TYPE	*/
//		let collectionQueryItem = URLQueryItem(name: "collection", value: "nature")

/* HOW TO QUERY FEATURED  */
//		let featuredQueryItem = URLQueryItem(name: "featured", value: nil)

//	let randomQuery = URLQueryItem(name: "random", value: nil)
//	possible way to query a random photo



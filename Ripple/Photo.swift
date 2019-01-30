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

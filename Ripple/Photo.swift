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
	let description: String?
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
		self.description = ""
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

struct UserProfile: Codable {
	let id: String
	let username: String
	let firstName: String
	let lastName: String
	let profileImage: [String: String]
	let followersCount: Int
	let followingCount: Int
	let location: String?
	let links: [String: String]
	let bio: String?
	
	enum CodingKeys: String, CodingKey {
		case id
		case username
		case firstName = "first_name"
		case lastName = "last_name"
		case profileImage = "profile_image"
		case followersCount = "followers_count"
		case followingCount = "following_count"
		case location
		case links
		case bio
		
	}
	
	func photoURL(ofSize size: PhotoSize) -> String {
		let urlString = self.profileImage[size.rawValue]!
		return urlString
	}
	
	enum PhotoSize: String {
		case large
		case medium
		case small
	}
}

//
//		"id": "pXhwzz1JtQU",
//		"updated_at": "2016-07-10T11:00:01-05:00",
//		"username": "jimmyexample",
//		"name": "James Example",
//		"first_name": "James",
//		"last_name": "Example",
//		"instagram_username": "instantgrammer",
//		"twitter_username": "jimmy",
//		"portfolio_url": null,
//		"bio": "The user's bio",
//		"location": "Montreal, Qc",
//		"total_likes": 20,
//		"total_photos": 10,
//		"total_collections": 5,
//		"followed_by_user": false,
//		"followers_count": 300,
//		"following_count": 25,
//		"downloads": 225974,
//		"profile_image": {
//			"small": "https://images.unsplash.com/face-springmorning.jpg?q=80&fm=jpg&crop=faces&fit=crop&h=32&w=32",
//			"medium": "https://images.unsplash.com/face-springmorning.jpg?q=80&fm=jpg&crop=faces&fit=crop&h=64&w=64",
//			"large": "https://images.unsplash.com/face-springmorning.jpg?q=80&fm=jpg&crop=faces&fit=crop&h=128&w=128"
//		},
//		"badge": {
//			"title": "Book contributor",
//			"primary": true,
//			"slug": "book-contributor",
//			"link": "https://book.unsplash.com"
//		},
//		"links": {
//			"self": "https://api.unsplash.com/users/jimmyexample",
//			"html": "https://unsplash.com/jimmyexample",
//			"photos": "https://api.unsplash.com/users/jimmyexample/photos",
//			"likes": "https://api.unsplash.com/users/jimmyexample/likes",
//			"portfolio": "https://api.unsplash.com/users/jimmyexample/portfolio"
//		}
//		}

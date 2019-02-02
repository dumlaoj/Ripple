//
//  MainCoordinator.swift
//  Ripple
//
//  Created by Jordan Dumlao on 1/31/19.
//  Copyright © 2019 Jordan Dumlao. All rights reserved.
//

import UIKit

class AppCoordinator: Coordinator, PhotoCoordinatorDelegate {
	
	var childCoordinators = [CoordinatorDictionary.RawValue: Coordinator]()
	var photoCoordinator: PhotoCoordinator?
	var userProfileCoordinator: UserProfileCoordinator?
	var navigationController: UINavigationController
	
	enum CoordinatorDictionary: String {
		case photo
		case user
	}
	
	init(_ navigationController: UINavigationController) {
		self.navigationController = navigationController
	}
	
	func start() {
		showPhoto()
	}
	
	func showPhoto() {
		photoCoordinator = PhotoCoordinator(navigationController)
		photoCoordinator?.delegate = self
		photoCoordinator?.start()
//		childCoordinators[CoordinatorDictionary.photo.rawValue] = photoCoordinator
	}
	
}

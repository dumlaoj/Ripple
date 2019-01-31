//
//  MainCoordinator.swift
//  Ripple
//
//  Created by Jordan Dumlao on 1/31/19.
//  Copyright © 2019 Jordan Dumlao. All rights reserved.
//

import UIKit

class AppCoordinator: Coordinator {
	
	var childCoordinators = [String: Coordinator]()
	var photoCoordinator: PhotoCoordinator?
	var navigationController: UINavigationController
	
	func start() {
		showPhoto()
	}
	
	func showPhoto() {
		photoCoordinator = PhotoCoordinator(navigationController)
		photoCoordinator?.delegate = self
		photoCoordinator?.start()
		childCoordinators["phot"] = photoCoordinator

	}
	
	init(_ navigationController: UINavigationController) {
		self.navigationController = navigationController
	}
}

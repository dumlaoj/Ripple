//
//  PhotoCoordinator.swift
//  Ripple
//
//  Created by Jordan Dumlao on 1/31/19.
//  Copyright © 2019 Jordan Dumlao. All rights reserved.
//


import UIKit

protocol PhotoCoordinatorDelegate: class {
}

class PhotoCoordinator: Coordinator {
	
	weak var delegate: PhotoCoordinatorDelegate?
	
	var childCoordinators = [String: Coordinator]()
	var navigationController: UINavigationController
	var photoViewController: PhotoViewController
	var photoInfoViewController: PhotoInfoViewController
	var cardViewController: CardViewController
	
	var userProfileCoordinator: UserProfileCoordinator?
	
	func start() {
		photoViewController.coordinator = self
		photoInfoViewController.coordinator = self
		navigationController.navigationBar.isHidden = true
		addCardView()
		navigationController.pushViewController(photoViewController, animated: false)
	}
	
	init(_ navigationController: UINavigationController) {
		self.navigationController = navigationController
		self.photoViewController = PhotoViewController()
		self.photoInfoViewController = PhotoInfoViewController(Photo())
		self.cardViewController = CardViewController()
	}
	
	private func addCardView() {
		let mainScreenBounds = UIScreen.main.bounds
		//	CONFIGURE SETTINGS FOR CARD VC
		cardViewController.maxHeight = mainScreenBounds.height * (1/3)
		cardViewController.minHeight = 40
		cardViewController.initialAnimationDurationConstant = 1
		cardViewController.cancelAnimationDurationConstant = 0.6
		cardViewController.animationDurationForTapConstant = 0.4
		//	ADD THE VC TO THIS VIEW
		photoViewController.addChild(cardViewController)
		photoViewController.view.addSubview(cardViewController.view)
		cardViewController.didMove(toParent: photoViewController)
		cardViewController.add(photoInfoViewController)
	}
}

extension PhotoCoordinator: UserProfileCoordinatorDelegate {
	func userProfileCoordinator(_ userProfileCoordinator: UserProfileCoordinator, didFinishShowingUser user: User) {
		navigationController.navigationBar.isHidden = true
		navigationController.popViewController(animated: true)
		self.userProfileCoordinator = nil
	}
}

extension PhotoCoordinator: PhotoInfoCoordinator {
	
	func photoInfoViewController(_ photoInfoViewController: PhotoInfoViewController, didTapUserProfileButton user: User) {
		showUserProfile(forUser: user)
	}
	
	func showUserProfile(forUser user: User) {
		userProfileCoordinator = UserProfileCoordinator(navigationController: navigationController, user: user)
		userProfileCoordinator?.delegate = self
		userProfileCoordinator?.start()
		//		childCoordinators[CoordinatorDictionary.user.rawValue] = userProfileCoordinator
	}
}

extension PhotoCoordinator: PhotoViewControllerCoordinator {
	func photoViewController(_ photoViewController: PhotoViewController, didUpdateWithPhoto photo: Photo) {
		photoInfoViewController.photo = photo
	}
}

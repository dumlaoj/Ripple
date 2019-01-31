//
//  PhotoCoordinator.swift
//  Ripple
//
//  Created by Jordan Dumlao on 1/31/19.
//  Copyright © 2019 Jordan Dumlao. All rights reserved.
//


import UIKit

class PhotoCoordinator: Coordinator, PhotoInfoCoordinator {
	
	weak var delegate: Coordinator?
	
	var childCoordinators = [String: Coordinator]()
	var navigationController: UINavigationController
	var photoViewController: PhotoViewController
	var photoInfoViewController: PhotoInfoViewController
	var cardViewController: CardViewController
	
	func start() {
		photoViewController.coordinator = self
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
	
	func photoViewController(_ photoViewController: PhotoViewController, didUpdateWithPhoto photo: Photo) {
		photoInfoViewController.photo = photo
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

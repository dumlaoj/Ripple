//
//  UserProfileCoordinator.swift
//  Ripple
//
//  Created by Jordan Dumlao on 1/31/19.
//  Copyright © 2019 Jordan Dumlao. All rights reserved.
//

import UIKit

protocol UserProfileCoordinatorDelegate: class {
	func userProfileCoordinator(_ userProfileCoordinator: UserProfileCoordinator, didFinishShowingUser user: User)
}

class UserProfileCoordinator: Coordinator {
	
	var user: User
	weak var delegate: UserProfileCoordinatorDelegate?
	var childCoordinators: [String : Coordinator] = [:]
	
	var navigationController: UINavigationController
	
	func start() {
		let userProfileViewController = UserProfileViewController(user)
		configureCustomBackBarItem(forViewController: userProfileViewController)
		navigationController.pushViewController(userProfileViewController, animated: true)
	}
	
	init(navigationController: UINavigationController, user: User) {
		self.navigationController = navigationController
		self.user = user
	}
	
	private func configureCustomBackBarItem(forViewController viewController: UserProfileViewController) {
		navigationController.navigationBar.isHidden = false
		navigationController.navigationBar.setBackgroundImage(UIImage(), for: .default)
		navigationController.navigationBar.shadowImage = UIImage()
		viewController.navigationItem.hidesBackButton = true
		viewController.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "back2"), style: .plain, target: self, action: #selector(handleBackBarTap))
		viewController.navigationItem.leftBarButtonItem?.tintColor = .white
	}
	
	@objc private func handleBackBarTap() {
		delegate?.userProfileCoordinator(self, didFinishShowingUser: user)
	}
}

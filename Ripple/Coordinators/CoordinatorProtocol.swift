//
//  Coordinator.swift
//  Ripple
//
//  Created by Jordan Dumlao on 1/31/19.
//  Copyright © 2019 Jordan Dumlao. All rights reserved.
//

import UIKit

protocol Coordinator: class {
	var childCoordinators: [String: Coordinator] { get set }
	var navigationController: UINavigationController { get set }
	func start()
}

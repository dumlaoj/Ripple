//
//  UserProfileViewController.swift
//  Ripple
//
//  Created by Jordan Dumlao on 2/1/19.
//  Copyright © 2019 Jordan Dumlao. All rights reserved.
//

import UIKit

class UserProfileViewController: UIViewController {

	var user: User
	
	
	init(_ user: User) {
		self.user = user
		super.init(nibName: nil, bundle: nil)
	}
	
	required init?(coder aDecoder: NSCoder) { fatalError("init(coder:) has not been implemented") }
}

extension UserProfileViewController {
	override func viewDidLoad() {
		super.viewDidLoad()
		
		view.backgroundColor = .blue
	}
	
	override func viewDidAppear(_ animated: Bool) {
		super.viewDidAppear(animated)
	}
}

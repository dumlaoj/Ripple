//
//  PhotoInfoViewController.swift
//  Ripple
//
//  Created by Jordan Dumlao on 1/29/19.
//  Copyright © 2019 Jordan Dumlao. All rights reserved.
//

import UIKit

class PhotoInfoViewController: UIViewController {
	
	var photoInfoView: PhotoInfoView { return view as! PhotoInfoView }
	
	var photo: Photo {
		didSet {
			self.user = photo.user
			updateUI()
		}
	}
	var user: User?
	
	override func loadView() {
		super.loadView()
		let photoInfoView = PhotoInfoView(frame: view.frame)
		view = photoInfoView
	}
	
    override func viewDidLoad() {
        super.viewDidLoad()
		updateUI()
    }
	
	init(_ photo: Photo) {
		self.photo = photo
		self.user = photo.user
		super.init(nibName: nil, bundle: nil)
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	private func updateUI() {
		guard let user = self.user else { return }
		let name = user.name
		let username = user.username
		let likes = photo.likes
		let downloads = photo.downloads
		
		photoInfoView.nameLabel.text = name
		photoInfoView.usernameLabel.text = "@\(username)"
		photoInfoView.likesQuantityLabel.text = "❤️: \(likes)"
		photoInfoView.downloadsQuantityLabel.text = "⬇️: \(downloads)"
	}
}

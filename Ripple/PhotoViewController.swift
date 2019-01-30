//
//  ViewController.swift
//  Ripple
//
//  Created by Jordan Dumlao on 1/28/19.
//  Copyright © 2019 Jordan Dumlao. All rights reserved.
//

import UIKit

class PhotoViewController: UIViewController {

	let cardViewController = CardViewController()
	
	var piViewController = PhotoInfoViewController(Photo())
	
	var photoView: PhotoView { return view as! PhotoView }

	var photo: Photo? {
		didSet {
			guard let photo = self.photo else { return }
			photoString = photo.photoURL(ofSize: .small)
			piViewController.photo = photo
		}
	}
	
	var photoString: String   { didSet { fetchImage(from: photoString) } }
	
	init() {
		self.photoString = String()
		super.init(nibName: nil, bundle: nil)
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}

//	VIEW LIFECYCLE
extension PhotoViewController {
	
	override func loadView() {
		super.loadView()
		let pv = PhotoView(frame: UIScreen.main.bounds)
		view = pv
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		configureButtons()
		addCardView()
//		getNewRandomImage()
	}
}

extension PhotoViewController {
	private func fetchImage(from urlString: String) {
		guard let url = URL(string: urlString), let data = try? Data(contentsOf: url) else { return }
		DispatchQueue.global().async {
			guard let image = UIImage(data: data) else { return }
			DispatchQueue.main.async {
				UIView.animate(withDuration: 1, animations: {
					self.photoView.blurredView.effect = nil
					self.photoView.image = image

				})
			}
		}
	}
	
	private func configureButtons() {
		photoView.refreshButton.addTarget(self, action: #selector(getNewRandomImage), for: .touchUpInside)
	}
	
	@objc private func getNewRandomImage() {
		photoView.blurredView.effect = UIBlurEffect(style: .light)
		Unsplasher().getRandomPhoto(forOrientation: .portrait, completion: { photo in
			DispatchQueue.main.async {
				self.photo = photo
			}
		})
	}
}

//	HANDLE CHILD CARD VIEW CONTROLLER
extension PhotoViewController {
	func addCardView() {
		//	CONFIGURE SETTINGS FOR CARD VC
		cardViewController.maxHeight = view.frame.height * (1/3)
		cardViewController.minHeight = 40
		cardViewController.initialAnimationDurationConstant = 1
		cardViewController.cancelAnimationDurationConstant = 0.6
		cardViewController.animationDurationForTapConstant = 0.6
		//	ADD THE VC TO THIS VIEW
		addChild(cardViewController)
		view.addSubview(cardViewController.view)
		cardViewController.didMove(toParent: self)
		cardViewController.add(piViewController)
	}
}

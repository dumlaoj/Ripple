//
//  ViewController.swift
//  Ripple
//
//  Created by Jordan Dumlao on 1/28/19.
//  Copyright © 2019 Jordan Dumlao. All rights reserved.
//

import UIKit

class PhotoViewController: UIViewController {
	
	weak var coordinator: PhotoCoordinator?
	let cardViewController = CardViewController()
	var piViewController = PhotoInfoViewController(Photo())
	var photoView: PhotoView { return view as! PhotoView }
	var photo: Photo? {
		didSet {
			guard let photo = self.photo else { return }
			photoString = photo.photoURL(ofSize: .small)
			coordinator?.photoViewController(self, didUpdateWithPhoto: photo)
		}
	}
	
	var photoString: String   {
		didSet {
			UIImage.fetchImage(fromURL: photoString, completion: {image in
				UIView.animate(withDuration: 1, animations: {
					self.photoView.blurredView.effect = nil
					self.photoView.image = image
				})
			})
		}
	}
	
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
		getNewRandomImage()
	}
}

extension PhotoViewController {
	
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

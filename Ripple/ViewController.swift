//
//  ViewController.swift
//  Ripple
//
//  Created by Jordan Dumlao on 1/28/19.
//  Copyright © 2019 Jordan Dumlao. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

	var photoView: PhotoView { return view as! PhotoView }

	var photo: Photo? {
		didSet {
			guard let photo = self.photo else { return }
			photoString = photo.photoURL(ofSize: .small)
		}
	}
	
	var photoString: String = "" { didSet { fetchImage(from: photoString) } }
	
}

//	VIEW LIFECYCLE
extension ViewController {
	
	override func loadView() {
		super.loadView()
		let pv = PhotoView(frame: UIScreen.main.bounds)
		view = pv
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		configureButtons()
//		Unsplasher().getRandomPhoto(forOrientation: .portrait, completion: { photo in
//			self.photo = photo
//		})
	}
}

extension ViewController {
	private func fetchImage(from urlString: String) {
		guard let url = URL(string: urlString), let data = try? Data(contentsOf: url) else { return }
		DispatchQueue.global().async {
			guard let image = UIImage(data: data) else { return }
			DispatchQueue.main.async {
				self.photoView.image = image
			}
		}
	}
	
	private func configureButtons() {
		photoView.refreshButton.addTarget(self, action: #selector(getNewRandomImage), for: .touchUpInside)
	}
	
	@objc private func getNewRandomImage() {
		Unsplasher().getRandomPhoto(forOrientation: .portrait, completion: { photo in
			self.photo = photo
		})
	}
}

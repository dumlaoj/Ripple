//
//  PhotoView.swift
//  Ripple
//
//  Created by Jordan Dumlao on 1/28/19.
//  Copyright © 2019 Jordan Dumlao. All rights reserved.
//

import UIKit

class PhotoView: UIView {

	let imageView: UIImageView = {
		let iv = UIImageView(backgroundColor: .lightGray)
		iv.contentMode = .scaleAspectFill
		return iv
	}()
	
	let refreshButton: UIButton = {
		let button = UIButton(backgroundColor: .clear, cornerRadius: nil)
		button.setImage(UIImage(named: "reload-3"), for: .normal)
		button.imageView?.contentMode = .scaleAspectFit
		button.alpha = 1
		button.clipsToBounds = true
		return button
	}()
	
	var image: UIImage? {
		get {
			return imageView.image
		}
		set {
			imageView.image = newValue
		}
	}
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		configureViews()
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	private func configureViews() {
		addSubview(imageView)
		imageView.fillSuperview()
		
		addSubview(refreshButton)
		refreshButton.constrain(toLeading: nil, top: topAnchor, trailing: trailingAnchor, bottom: nil, withPadding: UIEdgeInsets(top: 30, left: 0, bottom: 0, right: 10))
		let sizeConstant: CGFloat = 30
		refreshButton.constrain(withSize: .init(width: sizeConstant, height: sizeConstant))
		refreshButton.layer.cornerRadius = sizeConstant / 2
		
	}
}

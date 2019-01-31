//
//  PhotoInfoView.swift
//  Ripple
//
//  Created by Jordan Dumlao on 1/29/19.
//  Copyright © 2019 Jordan Dumlao. All rights reserved.
//

import UIKit

class PhotoInfoView: UIView {

	let nameLabel: UILabel = {
		let label = UILabel(backgroundColor: .clear, textLabel: "Name")
		label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
		return label
	}()
	
	let usernameLabel: UILabel = {
		let label = UILabel(backgroundColor: .clear, textLabel: "@username")
		label.font = UIFont.systemFont(ofSize: 13, weight: .light)
		return label
	}()
	
	let likesQuantityLabel: UILabel = {
		let label = UILabel(backgroundColor: .clear, textLabel: "❤️ 100")
//		label.textAlignment = .right
		return label
	}()
	
	
	let downloadsQuantityLabel: UILabel = {
		let label = UILabel(backgroundColor: .clear, textLabel: "⬇️ 1000")
//		label.textAlignment = .right
		return label
	}()
	
	var firstStackView: UIStackView = {
		let stackView = UIStackView()
		stackView.axis = .vertical
//		stackView.distribution = .fillEqually
		stackView.spacing = 1
		return stackView
	}()
	
	var secondStackView: UIStackView = {
		let stackView = UIStackView()
		stackView.axis = .horizontal
//		stackView.distribution = .equalSpacing
		stackView.spacing = 5
		return stackView
	}()
	
	var thirdStackView: UIStackView = {
		let stackView = UIStackView()
		stackView.axis = .horizontal
		//		stackView.distribution = .equalSpacing
		stackView.spacing = 5
		return stackView
	}()
	
	
	let profileImageView: UIImageView = {
		let imageView = UIImageView()
		imageView.clipsToBounds = true
		imageView.contentMode = .scaleAspectFit
		return imageView
	}()
	
	let downloadsImage: UIImageView = {
		let imageView = UIImageView()
		imageView.image = UIImage(named: "downloads")
		imageView.clipsToBounds = true
		imageView.contentMode = .scaleAspectFit
		return imageView
	}()
	
	let heartImage: UIImageView = {
		let imageView = UIImageView()
		imageView.image = UIImage(named: "heart")
		imageView.clipsToBounds = true
		imageView.contentMode = .scaleAspectFit
		return imageView
	}()
	
	
	private func renderViews() {
		
		addSubview(firstStackView)
		firstStackView.addArrangedSubview(nameLabel)
		firstStackView.addArrangedSubview(usernameLabel)
		
		addSubview(profileImageView)
		let profileImageSize: CGFloat = 75
		profileImageView.constrain(withSize: .init(width: profileImageSize, height: profileImageSize))
		profileImageView.layer.cornerRadius = profileImageSize / 2
		
		profileImageView.constrain(toLeading: leadingAnchor, top: topAnchor, trailing: nil, bottom: nil, withPadding: UIEdgeInsets(top: 10, left: 10, bottom: 0, right: 0))
		
		firstStackView.constrain(toLeading: profileImageView.trailingAnchor, top: profileImageView.topAnchor, trailing: nil, bottom: nil, withPadding: UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 0))
		let iconsImageSize: CGFloat = 30

		addSubview(thirdStackView)
		downloadsImage.constrain(withSize: .init(width: iconsImageSize, height: iconsImageSize))
		downloadsImage.layer.cornerRadius = iconsImageSize / 2
		thirdStackView.addArrangedSubview(downloadsImage)
		thirdStackView.addArrangedSubview(downloadsQuantityLabel)
		thirdStackView.constrain(toLeading: profileImageView.leadingAnchor, top: profileImageView.bottomAnchor, trailing: nil, bottom: nil, withPadding: UIEdgeInsets(top: 20, left: 0, bottom: 0, right: 0))
		
		addSubview(secondStackView)
		heartImage.constrain(withSize: .init(width: iconsImageSize, height: iconsImageSize))
		heartImage.layer.cornerRadius = iconsImageSize / 2
		secondStackView.addArrangedSubview(heartImage)
		secondStackView.addArrangedSubview(likesQuantityLabel)
		secondStackView.constrain(toLeading: profileImageView.leadingAnchor, top: thirdStackView.bottomAnchor, trailing: nil, bottom: nil, withPadding: UIEdgeInsets(top: 5, left: 0, bottom: 0, right: 0))
	
//		secondStackView.addArrangedSubview(downloadsQuantityLabel)
//
		
		
		
	}
	
	override init(frame: CGRect) {
		super.init(frame: frame)
//
//		self.layer.borderColor = UIColor.black.cgColor
//		self.layer.borderWidth = 1
		
		renderViews()
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}

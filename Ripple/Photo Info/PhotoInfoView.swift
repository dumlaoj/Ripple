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
		return label
	}()
	
	let usernameLabel: UILabel = {
		let label = UILabel(backgroundColor: .clear, textLabel: "@username")
		return label
	}()
	
	let likesQuantityLabel: UILabel = {
		let label = UILabel(backgroundColor: .clear, textLabel: "Likes")
		return label
	}()
	
	
	let downloadsQuantityLabel: UILabel = {
		let label = UILabel(backgroundColor: .clear, textLabel: "Downloads")
		return label
	}()
	
	var mainStackView: UIStackView = {
		let stackView = UIStackView(backgroundColor: .red)
		stackView.axis = .vertical
		stackView.distribution = .fillEqually
		return stackView
	}()
	
	private func renderViews() {
		addSubview(mainStackView)
		mainStackView.addArrangedSubview(nameLabel)
		mainStackView.addArrangedSubview(usernameLabel)
		mainStackView.addArrangedSubview(likesQuantityLabel)
		mainStackView.addArrangedSubview(downloadsQuantityLabel)
		
		mainStackView.fillSuperView(withPadding: UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20))
	}
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		
		renderViews()
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}

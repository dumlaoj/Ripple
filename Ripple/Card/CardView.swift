//
//  CardView.swift
//  Ripple
//
//  Created by Jordan Dumlao on 1/29/19.
//  Copyright © 2019 Jordan Dumlao. All rights reserved.
//

import UIKit

class CardView: UIView {
	
	var handleView: UIView = {
		let view = UIView(backgroundColor: .white, cornerRadius: nil)
		return view
	}()
	
	let handleBarView: UIView = {
		let view = UIView(backgroundColor: .gray, cornerRadius: 3)
		return view
	}()
	
	private var heightForHandleView: CGFloat = 40
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		backgroundColor = .white
		renderViews()
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	private func renderViews() {
		addSubview(handleView)
		handleView.constrain(toLeading: leadingAnchor, top: topAnchor, trailing: trailingAnchor, bottom: nil, withPadding: UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0))
		handleView.constrain(withHeight: heightForHandleView)
		handleView.addSubview(handleBarView)
		handleBarView.constrain(withSize: CGSize(width: 60, height: 7))
		handleBarView.centerInSuperView()
		layer.cornerRadius = 10.0
		layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
		clipsToBounds = true
	}
}

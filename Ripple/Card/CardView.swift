//
//  CardView.swift
//  Ripple
//
//  Created by Jordan Dumlao on 1/29/19.
//  Copyright © 2019 Jordan Dumlao. All rights reserved.
//

import UIKit

class CardView: UIView {

	var heightForHandleView: NSLayoutConstraint?
	
	var handleView: UIView = {
		let view = UIView(backgroundColor: .white, cornerRadius: nil)
		return view
	}()
	
	let handleBarView: UIView = {
		let view = UIView(backgroundColor: .gray, cornerRadius: 3)
		return view
	}()
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		backgroundColor = .white
		renderViews()
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	//	CONSTRAIN HEIGHT AND FRAME OF VIEW IN HERE
	override func didMoveToSuperview() {
		super.didMoveToSuperview()
		guard let superview = self.superview else { return }
		self.frame = CGRect(x: superview.frame.origin.x, y: superview.frame.maxY - (heightForHandleView?.constant ?? 0), width: superview.frame.width, height: superview.frame.height)
	}
	
	private func renderViews() {
		addSubview(handleView)
		handleView.constrain(toLeading: leadingAnchor, top: topAnchor, trailing: trailingAnchor, bottom: nil, withPadding: UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0))
		heightForHandleView = handleView.heightAnchor.constraint(equalToConstant: 40)
		heightForHandleView?.isActive = true
		
		handleView.addSubview(handleBarView)
		handleBarView.constrain(withSize: CGSize(width: 60, height: 7))
		handleBarView.centerInSuperView()
		
		layer.cornerRadius = 10.0
		layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
		clipsToBounds = true
	}
}

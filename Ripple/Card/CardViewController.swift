//
//  CardViewController.swift
//  Ripple
//
//  Created by Jordan Dumlao on 1/29/19.
//  Copyright © 2019 Jordan Dumlao. All rights reserved.
//

import UIKit

class CardViewController: UIViewController {
	
	var cardView: CardView { return view as! CardView }
	
	//	FULL HEIGHT OF CARD VIEW WILL BE 3/4 OF IPHONE HEIGHT
	var heightForCardView: CGFloat { return UIScreen.main.bounds.height * (1/3) }
	var heightForHandleView: CGFloat { return cardView.heightForHandleView?.constant ?? 0 }
	var halfOfHeightForHandleView: CGFloat { return heightForHandleView / 2 }
	let mainScreenBounds: CGRect = UIScreen.main.bounds
	
	enum CardState {
		case expanded
		case collapsed
	}
	
	var isVisible: Bool = false
	
	var nextState: CardState { return isVisible ? .collapsed : .expanded }
	
	var animationProgressWhenInterrupted: CGFloat = 0
	
	var runningAnimations = [UIViewPropertyAnimator]()
	
}

extension CardViewController {
	
	override func loadView() {
		super.loadView()
		let cardView = CardView()
		view = cardView
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		addGestures()
	}
	
	override func viewDidAppear(_ animated: Bool) {
		super.viewDidAppear(animated)
	}
}

extension CardViewController {
	private func addGestures() {
		let pan = UIPanGestureRecognizer(target: self, action: #selector(handlePan(_:)))
		cardView.handleView.addGestureRecognizer(pan)
		let tap = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
		cardView.handleView.addGestureRecognizer(tap)
	}
	
	@objc private func handleTap(_ recognizer: UITapGestureRecognizer) {
		switch recognizer.state {
		case .ended:
			animateIfNeeded(forState: nextState, duration: 1.0)
		default:
			break
		}
	}
	
	@objc private func handlePan(_ recognizer: UIPanGestureRecognizer) {
//		let translation = recognizer.translation(in: cardView.handleView)
//		let totalFractionComplete = (translation.y / heightForCardView) + animationProgressWhenInterrupted
		let translation = recognizer.translation(in: cardView.handleView)
		var fractionComplete = translation.y / heightForCardView
		fractionComplete = isVisible ? fractionComplete : -fractionComplete
		let totalFractionComplete = fractionComplete + animationProgressWhenInterrupted
		
		switch recognizer.state {
		case .began:
			beginInteractiveTransitions(forState: nextState, duration: 1.0)
		case .changed:
//			guard (isVisible && translation.y > 0) || (!isVisible && translation.y < 0) else {
//				print("do not proceed \(translation.y) \(isVisible)")
//				return
//			}
//			switch isVisible {
//			case true:
//				guard translation.y > 0 else { return }
//
//			case false:
//				guard translation.y < 0 else { return }
//			}
			updateInteractiveTransition(totalFractionComplete)
		case .ended:
//			guard (isVisible && translation.y > 0) || (!isVisible && translation.y < 0) else { continueAnimation(0.1); return }
			continueAnimation(totalFractionComplete)
		default: break
		}
	}
	
	private func animateIfNeeded(forState nextState: CardState, duration: TimeInterval) {
		guard runningAnimations.isEmpty else { return }
		let frameAnimator = UIViewPropertyAnimator(duration: duration, curve: .easeOut, animations: {
			self.cardView.frame.origin.y = nextState == .expanded ? self.mainScreenBounds.maxY - self.heightForCardView : self.mainScreenBounds.maxY - self.heightForHandleView
		})

		frameAnimator.addCompletion {
			_ in self.runningAnimations.removeAll(); self.isVisible.toggle()

		}
		frameAnimator.startAnimation()
		runningAnimations.append(frameAnimator)
		
	}
	
	private func beginInteractiveTransitions(forState nextState: CardState, duration: TimeInterval) {
		if runningAnimations.isEmpty {
			animateIfNeeded(forState: nextState, duration: duration)
		}
		
		runningAnimations.forEach {
			$0.pauseAnimation()
			self.animationProgressWhenInterrupted = $0.fractionComplete
		}
	}
	
	private func updateInteractiveTransition(_ fractionComplete: CGFloat) {
		runningAnimations.forEach { $0.fractionComplete = fractionComplete }
	}
	
	private func continueAnimation(_ fractionComplete: CGFloat) {
		if fractionComplete > 0.5 {
			runningAnimations.forEach { $0.continueAnimation(withTimingParameters: nil, durationFactor: 0) }
		} else {
			isVisible.toggle()
			runningAnimations.forEach { $0.stopAnimation(true)}
			runningAnimations.removeAll()
			animateIfNeeded(forState: nextState, duration: 0.6)
		}
	}
}

//	ADD VIEW CONTROLLER
extension CardViewController {
	
	func add(_ viewController: PhotoInfoViewController) {
		addChild(viewController)
		view.addSubview(viewController.view)
		viewController.didMove(toParent: self)
		viewController.view.constrain(toLeading: view.leadingAnchor, top: cardView.handleView.bottomAnchor, trailing: view.trailingAnchor, bottom: nil, withPadding: .zero)
		viewController.view.constrain(withHeight: heightForCardView - heightForHandleView)
	}
}


//			runningAnimations.forEach { $0.stopAnimation(true)}
//			runningAnimations.removeAll()
//			let frameAnimator = UIViewPropertyAnimator(duration: 1, dampingRatio: 0.8, animations: {
//				self.cardView.frame.origin.y = self.nextState == .collapsed ? self.mainScreenBounds.maxY - self.heightForCardView : self.mainScreenBounds.maxY - self.heightForHandleView
//			})
//			frameAnimator.startAnimation()

//
//  CardViewController.swift
//  Ripple
//
//  Created by Jordan Dumlao on 1/29/19.
//  Copyright © 2019 Jordan Dumlao. All rights reserved.
//

import UIKit

class CardViewController: UIViewController {
	
	private var cardView: CardView { return view as! CardView }
	
	private var heightForCardView: CGFloat = UIScreen.main.bounds.height * (1/3)
	private var heightForHandleView: CGFloat = 40
	private let mainScreenBounds: CGRect = UIScreen.main.bounds
	private enum CardState {
		case expanded
		case collapsed
	}
	private var isVisible: Bool = false
	private var nextState: CardState { return isVisible ? .collapsed : .expanded }
	private var animationProgressWhenInterrupted: CGFloat = 0
	private var runningAnimations = [UIViewPropertyAnimator]()
	
	
	//MARK :- PUBLIC VARIABLES
	
	//	MAX HEIGHT FOR THE CARD VIEW TO EXPAND TO
	var maxHeight: CGFloat {
		get {
			return heightForCardView
		}
		set {
			heightForCardView = newValue
		}
	}
	//	MIN HEIGHT FOR THE CARD TO BE COLLAPSED TO
	var minHeight: CGFloat {
		get {
			return heightForHandleView
		}
		set {
			heightForHandleView = newValue
		}
	}
	//	DURATION FOR CARD TO BE FULLY EXPANDED OR COLLAPSED
	var initialAnimationDurationConstant: TimeInterval = 1.0
	//	DURATION IF ANIMATION IS CANCELS AND REVERTS TO PREVIOUS POSITION
	var cancelAnimationDurationConstant: TimeInterval = 0.6
	var animationDurationForTapConstant: TimeInterval = 0.6
	
	init(maxHeight: CGFloat, minHeight: CGFloat, initialAnimationDuration: TimeInterval, cancelAnimationDuration: TimeInterval, tapAnimationDuration: TimeInterval) {
		self.heightForCardView = maxHeight
		self.heightForHandleView = minHeight
		self.initialAnimationDurationConstant = initialAnimationDuration
		self.cancelAnimationDurationConstant = cancelAnimationDuration
		self.animationDurationForTapConstant = tapAnimationDuration
		super.init(nibName: nil, bundle: nil)
	}
	
	init() {
		self.heightForCardView = 0
		self.heightForHandleView = 0
		self.initialAnimationDurationConstant = 0
		self.cancelAnimationDurationConstant = 0
		super.init(nibName: nil, bundle: nil)
	}
	
	required init?(coder aDecoder: NSCoder) { fatalError("init(coder:) has not been implemented") }
}

extension CardViewController {
	
	override func loadView() {
		super.loadView()
		let cardView = CardView()
		view = cardView
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
//		view.frame = CGRect(x: superview.frame.origin.x, y: superview.frame.maxY - heightForHandleView, width: superview.frame.width, height: superview.frame.height)
		view.frame = CGRect(x: mainScreenBounds.origin.x, y: mainScreenBounds.maxY - heightForHandleView, width: mainScreenBounds.width, height: mainScreenBounds.height)
		addGestures()
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
			animateIfNeeded(forState: nextState, duration: animationDurationForTapConstant)
		default:
			break
		}
	}
	
	@objc private func handlePan(_ recognizer: UIPanGestureRecognizer) {

		let translation = recognizer.translation(in: cardView.handleView)
		var fractionComplete = translation.y / heightForCardView
		fractionComplete = isVisible ? fractionComplete : -fractionComplete
		let totalFractionComplete = fractionComplete + animationProgressWhenInterrupted
		
		switch recognizer.state {
		case .began:
			beginInteractiveTransitions(forState: nextState, duration: initialAnimationDurationConstant)
		case .changed:

			updateInteractiveTransition(totalFractionComplete)
		case .ended:
			continueAnimation(totalFractionComplete)
		default: break
		}
	}
	
	private func animateIfNeeded(forState nextState: CardState, duration: TimeInterval) {
		guard runningAnimations.isEmpty else { return }
		let frameAnimator = UIViewPropertyAnimator(duration: duration, curve: .easeOut, animations: {
			self.cardView.frame.origin.y = nextState == .expanded ? self.mainScreenBounds.maxY - self.heightForCardView : self.mainScreenBounds.maxY - self.heightForHandleView
		})

		frameAnimator.addCompletion { _ in self.runningAnimations.removeAll(); self.isVisible.toggle() }
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
			animateIfNeeded(forState: nextState, duration: cancelAnimationDurationConstant)
		}
	}
}

//	ADD VIEW CONTROLLER
extension CardViewController {
	
	//	ADDS THE MAIN VIEW CONTROLLER TO BE DISPLAYED BY CARD VIEW
	func add(_ viewController: UIViewController) {
		guard children.isEmpty else { fatalError("A view controller already exists!") }
		addChild(viewController)
		view.addSubview(viewController.view)
		viewController.didMove(toParent: self)
		viewController.view.constrain(toLeading: view.leadingAnchor, top: cardView.handleView.bottomAnchor, trailing: view.trailingAnchor, bottom: nil, withPadding: .zero)
		viewController.view.constrain(withHeight: heightForCardView - heightForHandleView)
	}
	
	//	REMOVES THE VIEW CONTROLLER BEING PRESENTED BY THIS CARD VC
	//	WILL RETURN IMMEDIATELY IF THE TARGET VC IS NOT A CHILD OF THIS VC
	func remove(_ viewController: UIViewController) {
		guard children.contains(viewController) else { fatalError("This View Controller does not exist here")}
		viewController.willMove(toParent: nil)
		viewController.removeFromParent()
		viewController.view.removeFromSuperview()
	}
}


/*			RECOGNIZER.STATE SWITCH
//		let translation = recognizer.translation(in: cardView.handleView)
//		let totalFractionComplete = (translation.y / heightForCardView) + animationProgressWhenInterrupted
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
//			guard (isVisible && translation.y > 0) || (!isVisible && translation.y < 0) else { continueAnimation(0.1); return }
*/

//			runningAnimations.forEach { $0.stopAnimation(true)}
//			runningAnimations.removeAll()
//			let frameAnimator = UIViewPropertyAnimator(duration: 1, dampingRatio: 0.8, animations: {
//				self.cardView.frame.origin.y = self.nextState == .collapsed ? self.mainScreenBounds.maxY - self.heightForCardView : self.mainScreenBounds.maxY - self.heightForHandleView
//			})
//			frameAnimator.startAnimation()

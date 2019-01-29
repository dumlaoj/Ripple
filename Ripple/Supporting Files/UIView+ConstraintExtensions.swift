//
//  UIView+ConstraintExtension.swift
//
//  Created by Jordan Dumlao on 1/7/19.
//  Edited on 1/22/19
//  Copyright © 2019 Jordan Dumlao. All rights reserved.
//
//  Extensions to easily add common cases of constraints
//  This can help reduce bloated code required to programmatically
//  Constrain views
//
import UIKit

extension UIView {
  
  func constrain(toLeading leading: NSLayoutXAxisAnchor?, top: NSLayoutYAxisAnchor?, trailing: NSLayoutXAxisAnchor?, bottom: NSLayoutYAxisAnchor?, withPadding padding: UIEdgeInsets) {
    if self.translatesAutoresizingMaskIntoConstraints { self.translatesAutoresizingMaskIntoConstraints = false }
    if let lead = leading { self.leadingAnchor.constraint(equalTo: lead, constant: padding.left).isActive = true }
    if let top = top { self.topAnchor.constraint(equalTo: top, constant: padding.top).isActive = true }
    if let trail = trailing { self.trailingAnchor.constraint(equalTo: trail, constant: -padding.right).isActive = true }
    if let bot = bottom { self.bottomAnchor.constraint(equalTo: bot, constant: -padding.bottom).isActive = true }
  }
  
  func constrain(to view: UIView, withPadding padding: UIEdgeInsets) {
    constrain(toLeading: view.leadingAnchor, top: view.topAnchor, trailing: view.trailingAnchor, bottom: view.bottomAnchor, withPadding: padding)
  }
  
  func fillSuperview() {
    guard let sView = self.superview else { return }
    constrain(to: sView, withPadding: .zero)
  }
  
  func fillSuperView(withPadding padding: UIEdgeInsets) {
    guard let sView = self.superview else { return }
    constrain(to: sView, withPadding: padding)
  }
  
  func constrain(bottomToTopOf topView: UIView, withPadding padding: CGFloat) {
    guard self.superview == topView.superview else { fatalError("Both views must be in the same superview")}
    if translatesAutoresizingMaskIntoConstraints { translatesAutoresizingMaskIntoConstraints = false }
    self.bottomAnchor.constraint(equalTo: topView.topAnchor, constant: padding).isActive = true
  }
  
  func constrain(topToBottomOf botView: UIView, withPadding padding: CGFloat) {
    guard self.superview == botView.superview else { fatalError("Both views must be in the same superview")}
    if translatesAutoresizingMaskIntoConstraints { translatesAutoresizingMaskIntoConstraints = false }
    self.bottomAnchor.constraint(equalTo: botView.topAnchor, constant: padding).isActive = true
  }
  
  func constrain(leadingToTrailingOf traillingView: UIView, withPadding padding: CGFloat) {
    guard self.superview == traillingView.superview else { fatalError("Both views must be in the same superview")}
    if translatesAutoresizingMaskIntoConstraints { translatesAutoresizingMaskIntoConstraints = false }
    self.bottomAnchor.constraint(equalTo: traillingView.topAnchor, constant: padding).isActive = true
  }
  
  func constrain(trailingToLeadingOf leadingView: UIView, withPadding padding: CGFloat) {
    guard self.superview == leadingView.superview else { fatalError("Both views must be in the same superview")}
    if translatesAutoresizingMaskIntoConstraints { translatesAutoresizingMaskIntoConstraints = false }
    self.bottomAnchor.constraint(equalTo: leadingView.topAnchor, constant: padding).isActive = true
  }
  
  func constrain(withSize size: CGSize) {
    self.constrain(withHeight: size.height)
    self.constrain(withWidth: size.width)
  }
  
  func constrain(withHeight height: CGFloat) {
    if translatesAutoresizingMaskIntoConstraints { translatesAutoresizingMaskIntoConstraints = false }
    self.heightAnchor.constraint(equalToConstant: height).isActive = true
  }
  
  func constrain(withWidth width: CGFloat) {
    if translatesAutoresizingMaskIntoConstraints { translatesAutoresizingMaskIntoConstraints = false }
    self.widthAnchor.constraint(equalToConstant: width).isActive = true
  }
  
  func allignVertically(to view: UIView, _ constant: CGFloat) {
    if translatesAutoresizingMaskIntoConstraints { translatesAutoresizingMaskIntoConstraints = false }
    self.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: constant).isActive = true
  }
  
  func allignHorizontally(to view: UIView, _ constant: CGFloat) {
    if translatesAutoresizingMaskIntoConstraints { translatesAutoresizingMaskIntoConstraints = false }
    self.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: constant).isActive = true
  }
  
  func centerInSuperView() {
    guard let sView = superview else { fatalError("No Superview") }
    allignHorizontally(to: sView, 0)
    allignVertically(to: sView, 0)
  }
  
  func removeAllConstraints() {
    self.removeConstraints(self.constraints)
  }
  
  public convenience init(backgroundColor: UIColor, cornerRadius: CGFloat? = nil) {
    self.init()
    self.backgroundColor = backgroundColor
    if let radius = cornerRadius {
      self.clipsToBounds = true
      self.layer.cornerRadius = radius
    }
  }
}

extension UILabel {
  public convenience init(backgroundColor: UIColor, textLabel: String, cornerRadius: CGFloat? = nil) {
    self.init()
    self.text = textLabel
    self.backgroundColor = backgroundColor
    if let radius = cornerRadius {
      self.clipsToBounds = true
      self.layer.cornerRadius = radius
    }
  }
}


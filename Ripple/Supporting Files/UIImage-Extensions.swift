//
//  UIImage-Extensions.swift
//  Ripple
//
//  Created by Jordan Dumlao on 1/30/19.
//  Copyright © 2019 Jordan Dumlao. All rights reserved.
//

import UIKit

extension UIImage {
	static func fetchImage(fromURL urlString: String, completion: @escaping (UIImage) -> Void) {
		guard let url = URL(string: urlString), let data = try? Data(contentsOf: url) else { return }
		DispatchQueue.global().async {
			guard let image = UIImage(data: data) else { return }
			DispatchQueue.main.async {
				completion(image)
			}
		}
	}
}

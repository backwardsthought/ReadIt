//
//  UIImageView+Extensions.swift
//  ReadIt
//
//  Created by Felipe Lobo on 26/08/19.
//  Copyright © 2019 Copyisright. All rights reserved.
//

import UIKit

extension UIImageView {
	
	func imageFromURL(_ imageUrl: URL) {
		let cache = URLCache.shared
		let request = URLRequest(url: imageUrl)
		
		DispatchQueue.global(qos: .userInitiated).async { [weak self] in
			if let data = cache.cachedResponse(for: request)?.data,
				let image = UIImage(data: data) {

				DispatchQueue.main.async {
					self?.transition(image: image)
				}
				return
			}
			
			URLSession.shared.dataTask(with: imageUrl) { (data, response, error) in
				if let data = data, let response = response as? HTTPURLResponse,
					let image = UIImage(data: data) {
					let cachedData = CachedURLResponse(response: response, data: data)
					cache.storeCachedResponse(cachedData, for: request)

					DispatchQueue.main.async {
						self?.transition(image: image)
					}
				}
			}.resume()
		}
	}
	
	private func transition(image: UIImage) {
		UIView.transition(with: self,
						  duration: 0.3,
						  options: .transitionCrossDissolve,
						  animations: {
							self.image = image
		}, completion: nil)
	}
	
}

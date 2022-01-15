//
// Created by Felipe Lobo on 22/08/18.
// Copyright (c) 2018 Copyisright. All rights reserved.
//

import Foundation

struct Pocket {

	struct Author {
		let name: String
		let url: String
	}

	struct Image {
		let src: URL
	}

	let title: String
 	let url: URL
    let excerpt: String
	let timeToRead: Int?
	let hasImage: Bool
	let topImage: Image?
    let authors: [Author]?
	let images: [Image]?
    let timeUpdated: TimeInterval?

}

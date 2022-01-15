//
// Created by Felipe Lobo on 21/08/18.
// Copyright (c) 2018 Copyisright. All rights reserved.
//

import Foundation

struct Reading {

	let title: String
	let source: URL
    let dateAdded: Date?
    let excerpt: String
	let cover: Image?
    let images: [Image]?
    let author: String?
	let timeToRead: Int?
    
    struct Image {
        let src: URL
    }

}

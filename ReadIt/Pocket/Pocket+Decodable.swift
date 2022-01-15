//  
//  Pocket+Decodable.swift
//  ReadIt
//
//  Created by Felipe Lobo on 13/05/21.
//  Copyright (c) 2021 Copyisright. All rights reserved.
//

import Foundation

extension Pocket: Decodable {

	enum CodingKeys: String, CodingKey {
		case title = "resolved_title"
		case url = "resolved_url"
		case excerpt
		case timeUpdated = "time_updated"
		case timeToRead = "time_to_read"
		case hasImage = "has_image"
//		case imageUrl = "top_image_url"
		case topImage = "image"
		case authors
		case images
	}

	init(from decoder: Decoder) throws {
		let container = try decoder.container(keyedBy: CodingKeys.self)

		title = try container.decode(String.self, forKey: .title)

		let urlString = try container.decode(String.self, forKey: .url)
		let allowedUrlString = urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
		url = URL(string: allowedUrlString!)!

		excerpt = try container.decode(String.self, forKey: .excerpt)
		timeToRead = try container.decodeIfPresent(Int.self, forKey: .timeToRead)

        if let authorsContainer = try container.decodeIfPresent([String: Author].self, forKey: .authors) {
            authors = authorsContainer.map { $1 }
        } else {
            authors = []
        }

		topImage = try container.decodeIfPresent(Image.self, forKey: .topImage)

        if let imagesContainer = try container.decodeIfPresent([String: Image].self, forKey: .images) {
            images = imagesContainer
				.map { (key, value) in (key: key, value: value) }
				.sorted(by: { $0.key < $1.key })
				.map(\.value)
        } else {
            images = []
        }

		let hasImageFlag = try container.decode(String.self, forKey: .hasImage)
		hasImage = hasImageFlag == "1"

		let stringTimeUpdated = try container.decode(String.self, forKey: .timeUpdated)
		timeUpdated = TimeInterval(stringTimeUpdated)
	}

}

extension Pocket.Author: Decodable {

	init(from decoder: Decoder) throws {
		let container = try decoder.container(keyedBy: CodingKeys.self)

		name = try container.decode(String.self, forKey: .name)
		url = try container.decode(String.self, forKey: .url)
	}
	
	enum CodingKeys: String, CodingKey {
		case name
		case url
	}

}

extension Pocket.Image: Decodable {

	init(from decoder: Decoder) throws {
		let container = try decoder.container(keyedBy: CodingKeys.self)

		src = try container.decode(URL.self, forKey: .src)
	}

	enum CodingKeys: String, CodingKey {
		case src, id = "image_id"
	}

}

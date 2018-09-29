//
// Created by Felipe Lobo on 22/08/18.
// Copyright (c) 2018 Copyisright. All rights reserved.
//

import Foundation
import UIKit
import Moya
import RxSwift

struct Pocket: Codable {

	let title: String
	let url: String
	let hasImage: String
	let timeToRead: Int?
	let imageUrl: String?

	enum CodingKeys: String, CodingKey {
		case title = "resolved_title"
		case url = "resolved_url"
		case timeToRead = "time_to_read"
		case hasImage = "has_image"
		case imageUrl = "top_image_url"
	}

}


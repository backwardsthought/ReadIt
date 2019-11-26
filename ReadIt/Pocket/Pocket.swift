//
// Created by Felipe Lobo on 22/08/18.
// Copyright (c) 2018 Copyisright. All rights reserved.
//

import Foundation
import UIKit
import Moya
import RxSwift

struct Pocket: Decodable {

	let title: String
 	let url: String
    let excerpt: String
	let timeToRead: Int?
	let imageUrl: String?
    let authors: [Author]?
    let images: [Image]?
    
    private let has_image: String
    
    var hasImage: Bool {
        return has_image == "1"
    }
    
    private let time_updated: String
    
    var timeAdded: TimeInterval {
        return TimeInterval(exactly: Double(time_updated)!)!
    }

    struct Author: Decodable {
        let name: String
        let url: String
    }
    
    struct Image: Decodable {
        let src: String
    }
    
	enum CodingKeys: String, CodingKey {
		case title = "resolved_title"
		case url = "resolved_url"
        case excerpt
        case time_updated
		case timeToRead = "time_to_read"
		case has_image
		case imageUrl = "top_image_url"
        case authors
        case images
	}

}

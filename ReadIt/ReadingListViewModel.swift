//
// Created by Felipe Lobo on 21/08/18.
// Copyright (c) 2018 Copyisright. All rights reserved.
//

import Foundation

protocol ReadingListViewModelType: class {

	var readingList: [Reading] { get }

}

class ReadingListViewModel: ReadingListViewModelType {

	private(set) var readingList: [Reading]

	init() {
		let reading1 = Reading(title: "Some reading", source: "www.somewebsite.com")
		let reading2 = Reading(title: "Tweeted something", source: "twitter.com")
		let reading3 = Reading(title: "Why can't we be friends", source: "www.whycantwebefriends.net")

		readingList = [reading1, reading2, reading3]
	}

}
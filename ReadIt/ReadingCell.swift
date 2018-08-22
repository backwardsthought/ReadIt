//
// Created by Felipe Lobo on 21/08/18.
// Copyright (c) 2018 Copyisright. All rights reserved.
//

import UIKit

class ReadingCell: UITableViewCell {

	override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
		super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)

		self.textLabel?.font = UIFont(name: "Palatino", size: 20)

		self.detailTextLabel?.font = .systemFont(ofSize: 11)
		self.detailTextLabel?.textColor = .gray
	}

	required init?(coder aDecoder: NSCoder) {
		fatalError("You should not use init?(coder:), ever!")
	}
}

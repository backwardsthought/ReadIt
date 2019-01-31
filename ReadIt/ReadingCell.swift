//
// Created by Felipe Lobo on 21/08/18.
// Copyright (c) 2018 Copyisright. All rights reserved.
//

import UIKit

class ReadingCell: UITableViewCell {

	let titleLabel: UILabel
	let subtitleLabel: UILabel
	let coverView: UIImageView

	override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
		let titleLabel = UILabel()
		titleLabel.font = UIFont(name: "Palatino", size: 20)
		titleLabel.textColor = .darkText

		self.titleLabel = titleLabel

		let subtitleLabel = UILabel()
		subtitleLabel.font = .systemFont(ofSize: 11)
		subtitleLabel.textColor = .gray

		self.subtitleLabel = subtitleLabel

		let coverView = UIImageView()
		coverView.backgroundColor = .gray
		coverView.contentMode = .scaleAspectFill
		coverView.clipsToBounds = true

		self.coverView = coverView

		super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)

		prepareLayout()
	}

	func prepareLayout() {
		titleLabel.translatesAutoresizingMaskIntoConstraints = false
		contentView.addSubview(titleLabel)

		subtitleLabel.translatesAutoresizingMaskIntoConstraints = false
		contentView.addSubview(subtitleLabel)

		coverView.translatesAutoresizingMaskIntoConstraints = false
		contentView.addSubview(coverView)

		contentView.addConstraints([
			.equal(from: coverView, to: contentView, attr: .left),
			.equal(from: coverView, to: contentView, attr: .top),
			.equal(from: contentView, to: coverView, attr: .bottom),
			.width(value: 56, of: coverView),
			.create(from: titleLabel, .left, to: coverView, .right, constant: 16),
			.equal(from: titleLabel, to: contentView, attr: .topMargin),
			.equal(from: contentView, to: titleLabel, attr: .right),
			.create(from: subtitleLabel, .top, to: titleLabel, .bottom),
			.create(from: subtitleLabel, .left, to: coverView, .right, constant: 16),
			.equal(from: contentView, to: subtitleLabel, attr: .bottomMargin)
		])
	}

	required init?(coder aDecoder: NSCoder) {
		fatalError("You should not use init?(coder:), ever!")
	}

	override func prepareForReuse() {
		super.prepareForReuse()

		coverView.image = nil
	}
}

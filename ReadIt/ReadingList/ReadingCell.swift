//
// Created by Felipe Lobo on 21/08/18.
// Copyright (c) 2018 Copyisright. All rights reserved.
//

import UIKit

class ReadingCell: UITableViewCell {

	lazy var titleLabel: UILabel = {
		let label = UILabel(frame: .zero)
		label.translatesAutoresizingMaskIntoConstraints = false
		label.font = UIFont(name: "Palatino", size: 20)
		label.textColor = .label
		label.numberOfLines = 2
		return label
	}()
	
	lazy var authorLabel: UILabel = {
		let label = UILabel(frame: .zero)
		label.translatesAutoresizingMaskIntoConstraints = false
		label.font = UIFont(name: "Palatino", size: 11)
		label.textColor = .systemGray
		return label
	}()
	
	lazy var descriptionLabel: UILabel = {
		let label = UILabel(frame: .zero)
		label.translatesAutoresizingMaskIntoConstraints = false
		label.font = UIFont(name: "Palatino", size: 12)
		label.numberOfLines = 2
		return label
	}()
	
	lazy var estimatedTimeLabel: UILabel = {
		let label = UILabel(frame: .zero)
		label.translatesAutoresizingMaskIntoConstraints = false
		label.font = .systemFont(ofSize: 10)
		label.textColor = .systemGray
		return label
	}()
	
	lazy var banner: UIImageView = {
		let image = UIImageView(frame: .zero)
		image.translatesAutoresizingMaskIntoConstraints = false
		image.contentMode = .scaleAspectFill
		image.clipsToBounds = true
//		image.layer.cornerRadius = 4
		return image
	}()

	private var authorLabelConstraints: [NSLayoutConstraint] = []
	
	override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
		super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)

		setupViewConfiguration()
	}
	
	private func setupViewConfiguration() {
		buildViewHierarchy()
		setupConstraints()
	}
	
	private func buildViewHierarchy() {
		contentView.addSubview(banner)
		contentView.addSubview(titleLabel)
		contentView.addSubview(authorLabel)
		contentView.addSubview(descriptionLabel)
		contentView.addSubview(estimatedTimeLabel)
	}
	
	private func setupConstraints() {
		banner.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
		banner.topAnchor.constraint(greaterThanOrEqualTo: contentView.topAnchor, constant: 8).isActive = true
		banner.bottomAnchor.constraint(lessThanOrEqualTo: contentView.bottomAnchor, constant: -8).isActive = true
		banner.trailingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.trailingAnchor).isActive = true
		banner.widthAnchor.constraint(equalToConstant: 80).isActive = true

		let bannerHeight = banner.heightAnchor.constraint(equalToConstant: 80)
		bannerHeight.priority = .defaultHigh
		bannerHeight.isActive = true
		
		titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16).isActive = true
		titleLabel.leadingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.leadingAnchor).isActive = true
		titleLabel.trailingAnchor.constraint(equalTo: banner.leadingAnchor, constant: -8).isActive = true

		authorLabelConstraints = [
			authorLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 6),
			authorLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
			authorLabel.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor),
			descriptionLabel.topAnchor.constraint(equalTo: authorLabel.bottomAnchor, constant: 8)
		]
		
		let authorLabelSkippingConstraint = descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8)
		authorLabelSkippingConstraint.priority = UILayoutPriority(201)
		authorLabelSkippingConstraint.isActive = true

		descriptionLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor).isActive = true
		descriptionLabel.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor).isActive = true
		
		estimatedTimeLabel.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 6).isActive = true
		estimatedTimeLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor).isActive = true
		estimatedTimeLabel.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor).isActive = true
		estimatedTimeLabel.bottomAnchor.constraint(lessThanOrEqualTo: contentView.bottomAnchor, constant: -8)

		let bottomBreakableConstraint = estimatedTimeLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8)
		bottomBreakableConstraint.priority = UILayoutPriority(200)
		bottomBreakableConstraint.isActive = true
	}

	required init?(coder aDecoder: NSCoder) {
		fatalError("You should not use init?(coder:), ever!")
	}

	func configure(_ reading: Reading) {
		if let author = reading.author {
			authorLabel.text = author
			NSLayoutConstraint.activate(authorLabelConstraints)
			layoutIfNeeded()
		}

		titleLabel.text = reading.title
		descriptionLabel.text = reading.excerpt

		let pathURL = reading.images?.first?.src
		banner.imageFromURL(pathURL)
		
		if let timeToRead = reading.timeToRead {
			estimatedTimeLabel.text = "\(timeToRead) min read"
		}
	}

	override func prepareForReuse() {
		super.prepareForReuse()

		NSLayoutConstraint.deactivate(authorLabelConstraints)
		authorLabel.text = nil
		estimatedTimeLabel.text = nil
		banner.image = nil

		layoutIfNeeded()
	}
}


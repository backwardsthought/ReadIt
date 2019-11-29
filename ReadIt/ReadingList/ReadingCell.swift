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
	
	lazy var companyLabel: UILabel = {
		let label = UILabel(frame: .zero)
		label.translatesAutoresizingMaskIntoConstraints = false
		label.font = .systemFont(ofSize: 10)
		label.textColor = .systemGray
		return label
	}()
	
	lazy var descriptionLabel: UILabel = {
		let label = UILabel(frame: .zero)
		label.translatesAutoresizingMaskIntoConstraints = false
		label.font = .systemFont(ofSize: 12)
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
		image.layer.cornerRadius = 4
		return image
	}()
	
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
		contentView.addSubview(companyLabel)
		contentView.addSubview(descriptionLabel)
		contentView.addSubview(estimatedTimeLabel)
	}
	
	private func setupConstraints() {
		banner.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
		banner.trailingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.trailingAnchor).isActive = true
		banner.widthAnchor.constraint(equalToConstant: 80).isActive = true
		banner.heightAnchor.constraint(equalToConstant: 80).isActive = true
		
		titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8).isActive = true
		titleLabel.leadingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.leadingAnchor).isActive = true
		titleLabel.trailingAnchor.constraint(equalTo: banner.leadingAnchor, constant: -8).isActive = true
		
		companyLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8).isActive = true
		companyLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor).isActive = true
		companyLabel.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor).isActive = true
		
		descriptionLabel.topAnchor.constraint(equalTo: companyLabel.bottomAnchor, constant: 8).isActive = true
		descriptionLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor).isActive = true
		descriptionLabel.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor).isActive = true
		
		estimatedTimeLabel.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 8).isActive = true
		estimatedTimeLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor).isActive = true
		estimatedTimeLabel.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor).isActive = true
		estimatedTimeLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8).isActive = true
	}

	required init?(coder aDecoder: NSCoder) {
		fatalError("You should not use init?(coder:), ever!")
	}

	func configure(_ reading: Reading) {
		titleLabel.text = reading.title
		companyLabel.text = reading.author
		descriptionLabel.text = reading.excerpt
		banner.image = nil
		
		let pathURL = reading.images?.first?.src
		banner.imageFromURL(pathURL)
		
		if let timeToRead = reading.timeToRead {
			estimatedTimeLabel.text = "\(timeToRead) min read"
		}
	}
}


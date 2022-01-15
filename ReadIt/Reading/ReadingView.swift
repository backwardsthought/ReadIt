//
//  ReadingView.swift
//  ReadIt
//
//  Created by Felipe Lobo on 26/08/19.
//  Copyright © 2019 Copyisright. All rights reserved.
//

import UIKit

class ReadingView: UIView {
    
    let titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.text = "Title"
        titleLabel.font = UIFont(name: "Palatino-Bold", size: 36.0)
        titleLabel.numberOfLines = 3

        return titleLabel
    }()

    let detailLabel: UILabel = {
        let detailLabel = UILabel()
        detailLabel.translatesAutoresizingMaskIntoConstraints = false
        detailLabel.text = "Detail"
        detailLabel.textColor = UIColor.label.withAlphaComponent(0.95)
        detailLabel.font = UIFont(name: "Palatino", size: 20.0)
        detailLabel.numberOfLines = 6

        return detailLabel
    }()
    
    let authorLabel: UILabel = {
        let authorLabel = UILabel()
        authorLabel.translatesAutoresizingMaskIntoConstraints = false
        authorLabel.text = "John Cutler"
        authorLabel.font = .systemFont(ofSize: 20)

        return authorLabel
    }()

    let dateLabel: UILabel = {
        let dateLabel = UILabel()
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        dateLabel.text = "15 dec 1993"
        dateLabel.textColor = .darkGray
        dateLabel.font = .systemFont(ofSize: 18)

        return dateLabel
    }()
    
    let imagesView: ReadingImagesView = {
        let imageContainer = ReadingImagesView()
        imageContainer.backgroundColor = .clear
        imageContainer.translatesAutoresizingMaskIntoConstraints = false

        return imageContainer
    }()
    
    let buttonsContainer: ReadingBottomView = {
        let buttonsContainer = ReadingBottomView()
        buttonsContainer.translatesAutoresizingMaskIntoConstraints = false

        return buttonsContainer
    }()

    var backgroundImage: UIImage? {
        didSet {
            if backgroundImageView.image == nil {
                backgroundImageView.image = backgroundImage
                UIView.animate(withDuration: 40, delay: 0, options: .curveEaseOut, animations: {
                    self.backgroundImageView.transform = CGAffineTransform(scaleX: 1.33, y: 1.33)
                }, completion: nil)
            }
        }
    }

    private let headerView: UIView = {
        let headerView = UIView()
        headerView.translatesAutoresizingMaskIntoConstraints = false

        return headerView
    }()

    private let backgroundImageView: UIImageView = {
        let backgroundImageView = UIImageView()
        backgroundImageView.translatesAutoresizingMaskIntoConstraints = false
        backgroundImageView.contentMode = .scaleAspectFill
        backgroundImageView.clipsToBounds = true
        backgroundImageView.backgroundColor = .systemGray3

        return backgroundImageView
    }()

	private let gradientMaskView: UIView = {
        let gradientMaskView = UIView()
        gradientMaskView.translatesAutoresizingMaskIntoConstraints = false

        return gradientMaskView
    }()

    private let gradientLayer: CAGradientLayer = {
        let clear = UIColor.clear.cgColor
        let systemColor1 = UIColor.systemBackground.cgColor
        let systemColor2 = UIColor.systemBackground.withAlphaComponent(0.75).cgColor

        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [systemColor2, systemColor1, systemColor1, clear, clear]
        gradientLayer.locations = [0, 0.15, 0.66, 0.9, 1]

        return gradientLayer
    }()
    
    init() {
        super.init(frame: .zero)

        backgroundColor = .systemBackground
        clipsToBounds = true

	    gradientMaskView.layer.mask = gradientLayer

	    addSubview(gradientMaskView)
		gradientMaskView.addSubview(backgroundImageView)

        addSubview(headerView)
        headerView.addSubview(authorLabel)
        headerView.addSubview(dateLabel)
        
        addSubview(titleLabel)
        addSubview(detailLabel)
        
        addSubview(imagesView)

        addSubview(buttonsContainer)

        directionalLayoutMargins = NSDirectionalEdgeInsets(top: 8, leading: 24, bottom: 8, trailing: 24)

        setupLayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("You should not use init?(coder:), ever!")
    }

    override func layoutSublayers(of layer: CALayer) {
        super.layoutSublayers(of: layer)
        
        gradientLayer.frame = gradientMaskView.bounds
    }

    private func setupLayout() {
        addConstraints([
            gradientMaskView.topAnchor.constraint(equalTo: topAnchor),
            gradientMaskView.leadingAnchor.constraint(equalTo: leadingAnchor),
            centerYAnchor.constraint(equalTo: gradientMaskView.centerYAnchor),
            trailingAnchor.constraint(equalTo: gradientMaskView.trailingAnchor)
        ])

        gradientMaskView.addConstraints(matchingEdgesOf: backgroundImageView)

        headerView.addConstraints([
            authorLabel.topAnchor.constraint(equalTo: headerView.topAnchor),
            authorLabel.leadingAnchor.constraint(equalTo: headerView.leadingAnchor),
            headerView.trailingAnchor.constraint(equalTo: authorLabel.trailingAnchor),

            dateLabel.topAnchor.constraint(equalTo: authorLabel.bottomAnchor, constant: 4),
            dateLabel.leadingAnchor.constraint(equalTo: headerView.leadingAnchor),
            headerView.trailingAnchor.constraint(equalTo: dateLabel.trailingAnchor),
            headerView.bottomAnchor.constraint(equalTo: dateLabel.bottomAnchor)
        ])

        addConstraints([
            headerView.leadingAnchor.constraint(equalTo: layoutMarginsGuide.leadingAnchor),
            layoutMarginsGuide.trailingAnchor.constraint(equalTo: headerView.trailingAnchor),

            titleLabel.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: 16),
            titleLabel.leadingAnchor.constraint(equalTo: layoutMarginsGuide.leadingAnchor),
            layoutMarginsGuide.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor),

            detailLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor),
            detailLabel.leadingAnchor.constraint(equalTo: layoutMarginsGuide.leadingAnchor),
            layoutMarginsGuide.trailingAnchor.constraint(equalTo: detailLabel.trailingAnchor),

            imagesView.topAnchor.constraint(equalTo: detailLabel.bottomAnchor, constant: 16),
            imagesView.leadingAnchor.constraint(equalTo: leadingAnchor),
            trailingAnchor.constraint(equalTo: imagesView.trailingAnchor),
            imagesView.heightAnchor.constraint(equalToConstant: 88),

            buttonsContainer.topAnchor.constraint(equalTo: imagesView.bottomAnchor, constant: 32),
            buttonsContainer.leadingAnchor.constraint(equalTo: layoutMarginsGuide.leadingAnchor),
            layoutMarginsGuide.trailingAnchor.constraint(equalTo: buttonsContainer.trailingAnchor),
            buttonsContainer.heightAnchor.constraint(equalToConstant: 44)
        ])

        buttonsContainer.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor).isActive = true
    }
    
}

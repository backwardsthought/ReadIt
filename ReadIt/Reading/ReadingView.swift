//
//  ReadingView.swift
//  ReadIt
//
//  Created by Felipe Lobo on 26/08/19.
//  Copyright © 2019 Copyisright. All rights reserved.
//

import UIKit

class ReadingView: UIView {
    
    private let headerView: UIView
    
    let titleLabel: UILabel
    let detailLabel: UILabel
    
    let authorLabel: UILabel
    let dateLabel: UILabel
    
    let imageContainer: UIView
    let imageCollectionView: UICollectionView
    
    let buttonsContainer: UIView

    let neverButton: UIButton
    let readItButton: UIButton
    let laterButton: UIButton

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

    private let backgroundImageView: UIImageView
	private let gradientMaskView: UIView
    private let gradientLayer: CAGradientLayer
    
    init() {
        backgroundImageView = UIImageView()
        backgroundImageView.translatesAutoresizingMaskIntoConstraints = false
        backgroundImageView.contentMode = .scaleAspectFill
        backgroundImageView.clipsToBounds = true
	    backgroundImageView.backgroundColor = .systemGray3

	    gradientMaskView = UIView()
	    gradientMaskView.translatesAutoresizingMaskIntoConstraints = false

        headerView = UIView()
        headerView.translatesAutoresizingMaskIntoConstraints = false
        
        titleLabel = UILabel()
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.text = "Title"
        titleLabel.font = UIFont(name: "Palatino-Bold", size: 36.0)
        titleLabel.numberOfLines = 3
        
        detailLabel = UILabel()
        detailLabel.translatesAutoresizingMaskIntoConstraints = false
        detailLabel.text = "Detail"
	    detailLabel.textColor = UIColor.label.withAlphaComponent(0.95)
        detailLabel.font = UIFont(name: "Palatino", size: 20.0)
        detailLabel.numberOfLines = 6
        
        authorLabel = UILabel()
        authorLabel.translatesAutoresizingMaskIntoConstraints = false
        authorLabel.text = "John Cutler"
        authorLabel.font = .systemFont(ofSize: 20)
        
        dateLabel = UILabel()
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        dateLabel.text = "15 dec 1993"
        dateLabel.textColor = .darkGray
        dateLabel.font = .systemFont(ofSize: 18)

        imageContainer = UIView()
        imageContainer.backgroundColor = .clear
        imageContainer.translatesAutoresizingMaskIntoConstraints = false
        
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.itemSize = CGSize(width: 88, height: 88)
        flowLayout.minimumInteritemSpacing = 8
        flowLayout.scrollDirection = .horizontal
        
        imageCollectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        imageCollectionView.translatesAutoresizingMaskIntoConstraints = false
        imageCollectionView.backgroundColor = .clear
        imageCollectionView.clipsToBounds = false
        
        buttonsContainer = UIView()
        buttonsContainer.translatesAutoresizingMaskIntoConstraints = false
        
        neverButton = UIButton()
        neverButton.translatesAutoresizingMaskIntoConstraints = false
        neverButton.setTitle("Never", for: .normal)
        
        readItButton = UIButton()
        readItButton.translatesAutoresizingMaskIntoConstraints = false
        readItButton.setTitle("Read it", for: .normal)
        readItButton.titleLabel?.font = .systemFont(ofSize: 20)
        
        laterButton = UIButton()
        laterButton.translatesAutoresizingMaskIntoConstraints = false
        laterButton.setTitle("Later", for: .normal)

        let clear = UIColor.clear.cgColor
        let systemColor1 = UIColor.systemBackground.cgColor
        let systemColor2 = UIColor.systemBackground.withAlphaComponent(0.75).cgColor
        
        gradientLayer = CAGradientLayer()
        gradientLayer.colors = [systemColor2, systemColor1, systemColor1, clear, clear]
        gradientLayer.locations = [0, 0.15, 0.66, 0.9, 1]
        
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
        
        addSubview(imageContainer)
        imageContainer.addSubview(imageCollectionView)
        
        addSubview(buttonsContainer)
        buttonsContainer.addSubview(neverButton)
        buttonsContainer.addSubview(readItButton)
        buttonsContainer.addSubview(laterButton)
        
        layoutMargins = UIEdgeInsetsMake(8, 24, 8, 24)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("You should not use init?(coder:), ever!")
    }
    
    override func layoutSubviews() {
	    addConstraints([
		    .equal(from: gradientMaskView, to: self, attr: .top),
		    .equal(from: gradientMaskView, to: self, attr: .leading),
            .create(from: self, .centerY, to: gradientMaskView, .bottom),
		    .equal(from: self, to: gradientMaskView, attr: .trailing),
	    ])

	    gradientMaskView.addConstraintsForAllEdges(of: backgroundImageView)

        headerView.addConstraints([
            .equal(from: authorLabel, to: headerView, attr: .top),
            .equal(from: authorLabel, to: headerView, attr: .leadingMargin),
            .equal(from: headerView, to: authorLabel, attr: .trailingMargin),
            .create(from: dateLabel, .top, to: authorLabel, .bottom, constant: 4),
            .equal(from: dateLabel, to: headerView, attr: .leadingMargin),
            .equal(from: headerView, to: dateLabel, attr: .trailingMargin),
            .equal(from: headerView, to: dateLabel, attr: .bottom)
        ])
        
        imageContainer.addConstraintsForAllEdges(of: imageCollectionView)
        
        addConstraints([
            .equal(from: headerView, to: self, attr: .leadingMargin),
            .equal(from: headerView, to: self, attr: .trailingMargin),
            .create(from: titleLabel, .top, to: headerView, .bottom, constant: 16),
            .equal(from: titleLabel, to: self, attr: .leadingMargin),
            .equal(from: self, to: titleLabel, attr: .trailingMargin),
            .create(from: detailLabel, .top, to: titleLabel, .bottom, constant: 8),
            .equal(from: detailLabel, to: self, attr: .leadingMargin, constant: 2),
            .equal(from: self, to: detailLabel, attr: .trailingMargin, constant: 2),
            .create(from: imageContainer, .top, to: detailLabel, .bottom, constant: 16),
            .equal(from: imageContainer, to: self, attr: .leading),
            .equal(from: self, to: imageContainer, attr: .trailing),
            .create(from: buttonsContainer, .top, to: imageContainer, .bottom, constant: 32),
            .equal(from: buttonsContainer, to: self, attr: .leadingMargin),
            .equal(from: self, to: buttonsContainer, attr: .trailingMargin),
        ])
        
        buttonsContainer.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor).isActive = true
        
        buttonsContainer.addConstraints([
            .equal(from: neverButton, to: buttonsContainer, attr: .leading),
            .equal(from: neverButton, to: buttonsContainer, attr: .top),
            .equal(from: buttonsContainer, to: neverButton, attr: .bottom),
            .equal(from: readItButton, to: buttonsContainer, attr: .top),
            .equal(from: readItButton, to: buttonsContainer, attr: .centerX),
            .equal(from: buttonsContainer, to: readItButton, attr: .bottom),
            .equal(from: laterButton, to: buttonsContainer, attr: .top),
            .equal(from: laterButton, to: buttonsContainer, attr: .bottom),
            .equal(from: buttonsContainer, to: laterButton, attr: .right)
        ])
        
        addConstraint(.height(value: 88.0, of: imageContainer))
        addConstraint(.height(value: 44.0, of: buttonsContainer))
    }
    
    override func layoutSublayers(of layer: CALayer) {
        super.layoutSublayers(of: layer)
        
        gradientLayer.frame = gradientMaskView.bounds
    }
    
}

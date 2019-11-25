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
    
    init() {
        headerView = UIView()
        headerView.translatesAutoresizingMaskIntoConstraints = false
        
        titleLabel = UILabel()
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.text = "Title"
        titleLabel.font = UIFont(name: "Palatino-Bold", size: 22.0)
        titleLabel.numberOfLines = 3
        
        detailLabel = UILabel()
        detailLabel.translatesAutoresizingMaskIntoConstraints = false
        detailLabel.text = "Detail"
        detailLabel.font = UIFont(name: "Palatino", size: 14.0)
        detailLabel.numberOfLines = 8
        
        authorLabel = UILabel()
        authorLabel.translatesAutoresizingMaskIntoConstraints = false
        authorLabel.text = "John Cutler"
        
        dateLabel = UILabel()
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        dateLabel.text = "15 dec 1993"
        dateLabel.textColor = .darkGray
        dateLabel.font = .systemFont(ofSize: 14)
        
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
        buttonsContainer.backgroundColor = .gray
        buttonsContainer.translatesAutoresizingMaskIntoConstraints = false
        
        super.init(frame: .zero)
        
        backgroundColor = .white
        
        addSubview(headerView)
        headerView.addSubview(authorLabel)
        headerView.addSubview(dateLabel)
        
        addSubview(titleLabel)
        addSubview(detailLabel)
        
        addSubview(imageContainer)
        imageContainer.addSubview(imageCollectionView)
        
        addSubview(buttonsContainer)
        
        layoutMargins = UIEdgeInsetsMake(8, 24, 8, 24)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("You should not use init?(coder:), ever!")
    }
    
    override func layoutSubviews() {
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
            .create(from: detailLabel, .top, to: titleLabel, .bottom, constant: 16),
            .equal(from: detailLabel, to: self, attr: .leadingMargin, constant: 4),
            .equal(from: self, to: detailLabel, attr: .trailingMargin, constant: 4),
            .create(from: imageContainer, .top, to: detailLabel, .bottom, constant: 16),
            .equal(from: imageContainer, to: self, attr: .leading),
            .equal(from: self, to: imageContainer, attr: .trailing),
            .create(from: buttonsContainer, .top, to: imageContainer, .bottom, constant: 8),
            .equal(from: buttonsContainer, to: self, attr: .leadingMargin),
            .equal(from: self, to: buttonsContainer, attr: .trailingMargin),
        ])
        
        buttonsContainer.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor).isActive = true
        
        addConstraint(.height(value: 88.0, of: imageContainer))
        addConstraint(.height(value: 44.0, of: buttonsContainer))
    }
    
}

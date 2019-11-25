//
//  ReadingImageCell.swift
//  ReadIt
//
//  Created by Felipe Lobo on 10/09/19.
//  Copyright © 2019 Copyisright. All rights reserved.
//

import UIKit

class ReadingImageViewCell: UICollectionViewCell {
    
    let imageView: UIImageView
    
    override init(frame: CGRect) {
        imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        
        super.init(frame: frame)
        
        backgroundColor = .systemGray2
        clipsToBounds = true
        
        layer.borderColor = UIColor.lightGray.cgColor
        layer.borderWidth = 1 / UIScreen.main.scale
        
//        translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(imageView)
        
        addConstraintsForAllEdges(of: imageView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("You should not use init?(coder:), ever!")
    }
    
}

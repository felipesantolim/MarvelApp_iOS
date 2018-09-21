//
//  MAFeedViewCell.swift
//  MarvelApp_iOS
//
//  Created by Felipe Henrique Santolim on 20/09/18.
//  Copyright © 2018 Felipe Santolim. All rights reserved.
//

import UIKit
import MarvelAppApi
import Kingfisher

class MAFeedViewCell: UICollectionViewCell {

    /// Porperties
    fileprivate let imageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFill
        view.clipsToBounds = true
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    fileprivate let lblTitle: UILabel = {
        let view = UILabel()
        view.backgroundColor = .white
        view.textAlignment = .center
        view.font = UIFont(name: "AvenirNext-Bold", size: 14)
        view.minimumScaleFactor = 0.4
        view.numberOfLines = 0
        view.textColor = .black
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setup()
    }
}

extension MAFeedViewCell {
    
    fileprivate func setup() {
        addSubview(lblTitle)
        addSubview(imageView)
        setupConstraints()
    }
    
    fileprivate func setupConstraints() {
        
        lblTitle.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0.5).isActive = true
        lblTitle.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0.5).isActive = true
        lblTitle.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0.5).isActive = true
        lblTitle.heightAnchor.constraint(equalToConstant: 60).isActive = true
        
        imageView.topAnchor.constraint(equalTo: topAnchor, constant: 0.5).isActive = true
        imageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0.5).isActive = true
        imageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0.5).isActive = true
        imageView.bottomAnchor.constraint(equalTo: lblTitle.topAnchor, constant: 2.0).isActive = true
    }
}

extension MAFeedViewCell {
    
    public func configure(with char: MACharactersModel) {
        
        if let `thumbnail` = char.thumbnail {
            if let `path` = thumbnail.path, let _extension = thumbnail._extension {
                imageView.kf.setImage(with: URL(string:
                    path.replacingOccurrences(of: "http", with: "https") + "/portrait_uncanny." + _extension)!)
            }
        }
        
        if let `title` = char.name, !title.isEmpty {
            lblTitle.text = title
        }
    }
}

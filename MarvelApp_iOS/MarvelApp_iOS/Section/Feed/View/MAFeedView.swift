//
//  MAFeedView.swift
//  MarvelApp_iOS
//
//  Created by Felipe Henrique Santolim on 20/09/18.
//  Copyright © 2018 Felipe Santolim. All rights reserved.
//

import UIKit

class MAFeedView: UIView {
    
    @IBOutlet public weak var collectionView: UICollectionView! {
        didSet {
            collectionView.allowsMultipleSelection = false
            collectionView.showsVerticalScrollIndicator = false
            collectionView.showsHorizontalScrollIndicator = false
            collectionView.register(R.nib.maFeedViewCell(),
                                    forCellWithReuseIdentifier: R.nib.maFeedViewCell.identifier)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        backgroundColor = .black
    }
}

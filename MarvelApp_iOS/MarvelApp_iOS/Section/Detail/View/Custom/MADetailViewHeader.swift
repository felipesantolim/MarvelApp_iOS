//
//  MADetailViewHeader.swift
//  MarvelApp_iOS
//
//  Created by Felipe Henrique Santolim on 21/09/18.
//  Copyright © 2018 Felipe Santolim. All rights reserved.
//

import UIKit
import MarvelAppApi
import MarvelAppSupport
import Kingfisher

class MADetailViewHeader: BaseXibView {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet var lblNumbers: [UILabel]!
}

extension MADetailViewHeader {
    
    public func configure(with model: MACharactersModel) {
        
        if let `title` = model.name, !title.isEmpty {
            lblTitle.text = title
        }
        
        if let `thumbnail` = model.thumbnail {
            if let `path` = thumbnail.path, let _extension = thumbnail._extension {
                imageView.kf.setImage(with: URL(string:
                    path.replacingOccurrences(of: "http", with: "https") + "/portrait_uncanny." + _extension)!)
            }
        }
        
        if let `comic` = model.comics { lblNumbers[0].text = "\(comic)" }
        if let `series` = model.series { lblNumbers[1].text = "\(series)" }
        if let `stories` = model.stories { lblNumbers[2].text = "\(stories)" }
        if let `events` = model.events { lblNumbers[3].text = "\(events)" }
    }
}

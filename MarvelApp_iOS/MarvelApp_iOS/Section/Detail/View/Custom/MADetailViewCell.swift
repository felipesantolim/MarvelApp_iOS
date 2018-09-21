//
//  MADetailViewCell.swift
//  MarvelApp_iOS
//
//  Created by Felipe Henrique Santolim on 21/09/18.
//  Copyright © 2018 Felipe Santolim. All rights reserved.
//

import UIKit

class MADetailViewCell: UITableViewCell {

    @IBOutlet fileprivate weak var lblDescription: UILabel! { didSet {} }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}

extension MADetailViewCell {
    
    public func config(_ plot: String?) {
        if let `_plot` = plot, !_plot.isEmpty {
            lblDescription.text = _plot
        }else {
            lblDescription.text = R.string.global.noDesc().uppercased()
        }
    }
}


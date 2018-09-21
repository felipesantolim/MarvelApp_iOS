//
//  MADetailViewController.swift
//  MarvelApp_iOS
//
//  Created by Felipe Henrique Santolim on 20/09/18.
//  Copyright © 2018 Felipe Santolim. All rights reserved.
//

import UIKit
import MarvelAppApi
import MarvelAppSupport

class MADetailViewController: MABaseViewController {

    private var character: MACharactersModel?
    private var mainView: MADetailView {
        return self.view as! MADetailView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        layout()
    }
    
    override func setup() {
        mainView.tableView.delegate = self
        mainView.tableView.dataSource = self
    }
    
    override func layout() {
        setHeader()
        self.navigationItem.title = R.string.details.detailsTitle().uppercased()
    }
}

extension MADetailViewController {
    public func configure(with model: MACharactersModel) {
        self.character = model
    }
}

extension MADetailViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int { return 1 }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int { return 1 }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: R.reuseIdentifier.maDetailViewCell.identifier, for: indexPath) as! MADetailViewCell
        if let `character` = character {
            cell.config(character.description)
        }
        return cell
    }
}

extension MADetailViewController: UITableViewDelegate {}

extension MADetailViewController {
    
    private func setHeader() {
        let header = MADetailViewHeader(frame: CGRect(x: 0.0, y: 0.0, width: mainView.bounds.width, height: 350))
        header.backgroundColor = .clear
        if let `character` = character {
            header.configure(with: character)
        }
        mainView.tableView.tableHeaderView = header
    }
}

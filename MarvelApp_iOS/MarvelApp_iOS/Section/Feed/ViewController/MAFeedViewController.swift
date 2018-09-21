//
//  ViewController.swift
//  MarvelApp_iOS
//
//  Created by Felipe Henrique Santolim on 20/09/18.
//  Copyright © 2018 Felipe Santolim. All rights reserved.
//

import UIKit
import MarvelAppSupport
import MarvelAppApi

class MAFeedViewController: MABaseViewController {
    
    /// Properties
    private var currentPg: Int = 1
    private var fetchingMore: Bool = false
    private var chars = [MACharactersModel]()
    private var mainView: MAFeedView {
        return self.view as! MAFeedView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
        layout()
        service()
    }
    
    override func setup() {
        mainView.collectionView.delegate = self
        mainView.collectionView.dataSource = self
    }
    
    override func layout() {
        self.navigationItem.title = R.string.feed.feedTitle().uppercased()
    }
    
    override func service() {
        fetchingMore = true
        _ = MAManager.shared.fetchAllCharacters(with: currentPg, { _chars in
            if let `_chars` = _chars, _chars.count > 0 {
                _ = _chars.map { item in
                    self.chars.append(item)
                }
                self.currentPg += 22
                self.fetchingMore = !self.fetchingMore
            }
            _ = DispatchQueue.main.async {
                self.mainView.collectionView.reloadData()
            }
        })
    }
    
}

// MARK: - UICollectionViewDataSource
extension MAFeedViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int { return 1 }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int { return chars.count }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: R.reuseIdentifier.maFeedViewCell.identifier,
                                                      for: indexPath) as! MAFeedViewCell
        cell.configure(with: chars[indexPath.item])
        return cell
        
    }
}

// MARK: - UICollectionViewDelegate
extension MAFeedViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let `detail` = storyboard?.instantiateViewController(
            withIdentifier: R.storyboard.main.maDetailViewController.identifier) as? MADetailViewController {
            detail.configure(with: chars[indexPath.item])
            navigationController?.pushViewController(detail, animated: true)
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        if offsetY > contentHeight - scrollView.frame.height * 2 {
            if !fetchingMore { service() }
        }
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension MAFeedViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let xInsets: CGFloat = 1
        let cellSpacing: CGFloat = 1
        let numberOfColumns: CGFloat = 3
        let width = mainView.collectionView.frame.size.width
        
        return CGSize(width: (width / numberOfColumns) - (xInsets + cellSpacing), height: 240)
    }
}


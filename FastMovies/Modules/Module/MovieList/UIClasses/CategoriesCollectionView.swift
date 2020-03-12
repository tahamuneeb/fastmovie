//
//  CategoriesCollectionView.swift
//  FastMovies
//
//  Created by Taha Muneeb on 15/01/2020.
//  Copyright © 2020 FastOrder. All rights reserved.
//

import UIKit

protocol CategoriesCollectionViewSelectionDelegate: class {
    func collectionViewSelected(type: MovieType)
}

class CategoriesCollectionView: UICollectionView, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {

    weak var selectionDelegate: CategoriesCollectionViewSelectionDelegate?

    var categories: [String] = ["Popular", "Top Rated", "Upcoming"]

    var selectedIndex: IndexPath = IndexPath.init(row: 0, section: 0)

    override func draw(_ rect: CGRect) {

        super.draw(rect)
        self.delegate = self
        self.dataSource = self
        self.reloadData()

    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categories.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CategoriesCell", for: indexPath) as? CategoriesCell {
          cell.lblCategory.text = categories[indexPath.row]
          if indexPath == selectedIndex {
              cell.lblCategory.textColor = UIColor.init(named: "PurpleText")!
          } else {
              cell.lblCategory.textColor = UIColor.init(named: "UnselectedGrey")!
          }
          return cell
        } else {
            return collectionView.dequeueReusableCell(withReuseIdentifier: "CategoriesCell", for: indexPath)
        }
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedIndex = indexPath
        self.reloadData()
        if let delegate = selectionDelegate {
            if indexPath.row == 0 {
                delegate.collectionViewSelected(type: .popular)
            } else if indexPath.row == 1 {
                delegate.collectionViewSelected(type: .topRated)
            } else {
                delegate.collectionViewSelected(type: .upComing)
            }
        }

    }

}

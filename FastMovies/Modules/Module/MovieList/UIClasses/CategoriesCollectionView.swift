//
//  CategoriesCollectionView.swift
//  FastMovies
//
//  Created by Taha Muneeb on 15/01/2020.
//  Copyright © 2020 FastOrder. All rights reserved.
//

import UIKit

protocol CategoriesCollectionViewSelectionDelegate:class {
    func collectionViewSelected(type:MovieType)
}

class CategoriesCollectionView: UICollectionView, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    
    weak var selectionDelegate:CategoriesCollectionViewSelectionDelegate?

    var categories:[String] = ["Popular", "Top Rated", "Upcoming"]
    
    var selectedIndex:IndexPath = IndexPath.init(row: 0, section: 0)
    
    override func draw(_ rect: CGRect) {
        
        super.draw(rect)
        self.delegate = self
        self.dataSource = self
        self.reloadData()
//        if let layout = self.collectionViewLayout as? UICollectionViewFlowLayout{
//            layout.estimatedItemSize = CGSize.init(width: 1, height: 1)
//        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CategoriesCell", for: indexPath) as! CategoriesCell
        cell.lblCategory.text = categories[indexPath.row]
        if indexPath == selectedIndex{
            cell.lblCategory.textColor = UIColor.init(named: "PurpleText")!
        }else{
            cell.lblCategory.textColor = UIColor.init(named: "UnselectedGrey")!
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedIndex = indexPath
        self.reloadData()
        if let d = selectionDelegate{
            if indexPath.row == 0{
                d.collectionViewSelected(type: .popular)
            }else if indexPath.row == 1{
                d.collectionViewSelected(type: .topRated)
            }else{
                d.collectionViewSelected(type: .upComing)
            }
        }
        
    }
    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        return
//    }
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}

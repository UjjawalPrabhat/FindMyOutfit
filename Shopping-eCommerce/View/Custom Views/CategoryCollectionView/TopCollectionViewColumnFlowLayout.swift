//
//  TopCollectionViewColumnFlowLayout.swift
//  FindMyOutfit
//
//  
//

import UIKit

class TopCollectionViewColumnFlowLayout: UICollectionViewFlowLayout {
    
    let columnCount: Int
    var heightRatio: CGFloat = (1.0 / 3.0)
    
    init(columnCount: Int, minColumnSpacing: CGFloat = 0, minRowSpacing: CGFloat = 0) {
        self.columnCount = columnCount
        super.init()
        
        self.minimumInteritemSpacing = minColumnSpacing
        self.minimumLineSpacing = minRowSpacing
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepare() {
        super.prepare()
        
        guard let collectionView = collectionView else { return }
        
        let spacing = collectionView.safeAreaInsets.left + collectionView.safeAreaInsets.right + minimumInteritemSpacing * CGFloat(columnCount - 1)
        
        let itemWidth = (collectionView.bounds.size.width - spacing) / CGFloat(columnCount).rounded(.down)
        let itemHeight = itemWidth * heightRatio
        
        itemSize = CGSize(width: itemWidth, height: itemHeight)
    }
}

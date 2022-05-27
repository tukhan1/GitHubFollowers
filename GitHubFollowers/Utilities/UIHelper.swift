//
//  UIHelper.swift
//  GitHubFollowers
//
//  Created by Egor Tushev on 05.04.2022.
//

import UIKit

struct UIHelper {
    static func createThreeColumnFlowLayout(in view: UIView) -> UICollectionViewFlowLayout {
        let widht = view.bounds.width
        let padding: CGFloat = 12
        let minimumItemSpacing: CGFloat = 10
        let avalibleWidth = widht - (padding * 2) - (minimumItemSpacing * 2)
        let itemWidht = avalibleWidth / 3
        
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.sectionInset = UIEdgeInsets(top: padding, left: padding, bottom: padding, right: padding)
        flowLayout.itemSize = CGSize(width: itemWidht, height: itemWidht + 40)
        
        return flowLayout
    }
}

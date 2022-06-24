//
//  CollectionCell+Ext.swift
//  GitHubFollowers
//
//  Created by Egor Tushev on 05.04.2022.
//

import UIKit

protocol CollectionCell: AnyObject {
    static var identifier: String { get }
}

extension UICollectionView {
    func register<T: CollectionCell>(_ type: T.Type) {
        self.register(type, forCellWithReuseIdentifier: type.identifier)
    }

    func dequeueReusableCell<T: CollectionCell>(type: T.Type, for indexPath: IndexPath) -> T {
        self.dequeueReusableCell(withReuseIdentifier: type.identifier, for: indexPath) as! T
    }
}

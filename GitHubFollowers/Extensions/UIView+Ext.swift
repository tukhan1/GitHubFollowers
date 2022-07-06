//
//  UIView+Ext.swift
//  GitHubFollowers
//
//  Created by Egor Tushev on 06.07.2022.
//

import UIKit

extension UIView {

    func addSubviews(_ views: UIView...) {
        for view in views { addSubview(view) }
    }
}

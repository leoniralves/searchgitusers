//
//  NibLoadableView.swift
//  SearchGitUsersMVC
//
//  Created by Leonir Alves Deolindo on 11/03/20.
//  Copyright © 2020 Leonir Deolindo. All rights reserved.
//

import UIKit

protocol NibLoadableView {
    static var nibName: String { get }
    static var nib: UINib { get }
}

extension NibLoadableView where Self: UIView {
    static var nibName: String {
        return String(describing: self)
    }
    
    static var nib: UINib {
        return UINib(nibName: nibName, bundle: Bundle(for: Self.self))
    }
}

extension UIView: NibLoadableView {}

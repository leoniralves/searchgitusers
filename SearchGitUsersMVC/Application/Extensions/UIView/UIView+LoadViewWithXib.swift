//
//  UIView+LoadViewWithXib.swift
//  SearchGitUsersMVC
//
//  Created by Leonir Alves Deolindo on 10/03/20.
//  Copyright © 2020 Leonir Deolindo. All rights reserved.
//

import UIKit

extension UIView {
    func loadView() {
        guard let view = Self.nib.instantiate(withOwner: self,
                                         options: nil)[0] as? UIView else {
            return
        }
        view.frame = bounds
        view.autoresizingMask = [.flexibleWidth,
                                 .flexibleHeight]
        addSubview(view)
    }
}

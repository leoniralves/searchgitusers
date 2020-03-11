//
//  UITableView+DataSource.swift
//  SearchGitUsersMVC
//
//  Created by Leonir Alves Deolindo on 11/03/20.
//  Copyright © 2020 Leonir Deolindo. All rights reserved.
//

import UIKit

extension UITableView {
    
    func register<T: UITableViewCell>(_ : T.Type) {
        register(T.nib, forCellReuseIdentifier: T.reuseIdentifier)
    }
    
    func dequeueReusableCell<T: UITableViewCell>(indexPath: IndexPath) -> T {
        guard let cell = dequeueReusableCell(withIdentifier: T.reuseIdentifier, for: indexPath) as? T else {
            fatalError("Error dequeue cell with identifier: \(T.reuseIdentifier)")
        }
        return cell
    }
}

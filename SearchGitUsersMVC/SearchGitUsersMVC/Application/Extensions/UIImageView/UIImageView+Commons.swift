//
//  UIImageView+Commons.swift
//  SearchGitUsersMVC
//
//  Created by Leonir Alves Deolindo on 11/03/20.
//  Copyright © 2020 Leonir Deolindo. All rights reserved.
//

import UIKit

extension UIImageView {
    
    // MARK: Load Images Async
    func load(url: URL?, placeholder: UIImage) {
        self.image = placeholder
        
        guard let url = url else {
            return
        }
        
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                DispatchQueue.main.async {
                    self?.image = UIImage(data: data)
                }
            }
        }
    }
}

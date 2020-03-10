//
//  HomeView.swift
//  SearchGitUsersMVC
//
//  Created by Leonir Alves Deolindo on 10/03/20.
//  Copyright © 2020 Leonir Deolindo. All rights reserved.
//

import UIKit

class HomeView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .red
        loadView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

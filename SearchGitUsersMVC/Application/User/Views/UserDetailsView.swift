//
//  UserDetailsView.swift
//  SearchGitUsersMVC
//
//  Created by Leonir Alves Deolindo on 18/03/20.
//  Copyright © 2020 Leonir Deolindo. All rights reserved.
//

import UIKit

class UserDetailsView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        loadView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(_ user: User) {
        print(user)
    }
}

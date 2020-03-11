//
//  HomeViewCell.swift
//  SearchGitUsersMVC
//
//  Created by Leonir Alves Deolindo on 11/03/20.
//  Copyright © 2020 Leonir Deolindo. All rights reserved.
//

import UIKit

class HomeViewCell: UITableViewCell {
    
    @IBOutlet weak var lbName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configure(user: User) {
        lbName.text = user.login
    }
}

//
//  UserListViewCell.swift
//  SearchGitUsersMVC
//
//  Created by Leonir Alves Deolindo on 11/03/20.
//  Copyright © 2020 Leonir Deolindo. All rights reserved.
//

import UIKit

class UserListViewCell: UITableViewCell {
    
    @IBOutlet weak var lbName: UILabel!
    @IBOutlet weak var ivImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configure(user: User) {
        lbName.text = user.login
        let placeholder = UIView(frame: ivImage.frame)
        placeholder.backgroundColor = .lightGray
        ivImage.load(url: user.avatarURL, placeholder: placeholder.asImage())
        ivImage.layer.cornerRadius = ivImage.frame.width/2
    }
}

//
//  UserDetailsView.swift
//  SearchGitUsersMVC
//
//  Created by Leonir Alves Deolindo on 18/03/20.
//  Copyright © 2020 Leonir Deolindo. All rights reserved.
//

import UIKit

class UserDetailsView: UIView {
    
    @IBOutlet weak var ivUserImage: UIImageView!
    @IBOutlet weak var lbName: UILabel!
    @IBOutlet weak var lbBio: UILabel!
    @IBOutlet weak var lbCompany: UILabel!
    @IBOutlet weak var lbLocalization: UILabel!
    @IBOutlet weak var btnLinkURL: UIButton!
    @IBOutlet weak var btnLinkBlog: UIButton!
    @IBOutlet weak var folowersCount: UILabel!
    @IBOutlet weak var folowingCount: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        loadView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(_ user: User) {
        ivUserImage.layer.cornerRadius = ivUserImage.frame.width/2
        ivUserImage.load(url: user.avatarURL, placeholder: UIImage())
        
        folowersCount.text = "Seguidores: \(user.followers ?? 0)"
        folowingCount.text = "Seguindo: \(user.following ?? 0)"
        
        lbName.text = user.name
        lbBio.text = user.bio
        lbCompany.text = user.company
        lbLocalization.text = user.location
        btnLinkURL.setTitle(user.htmlURL, for: .normal)
        btnLinkBlog.setTitle(user.blog, for: .normal)
    }
}

//
//  User.swift
//  SearchGitUsersMVC
//
//  Created by Leonir Alves Deolindo on 07/03/20.
//  Copyright © 2020 Leonir Deolindo. All rights reserved.
//

import Foundation

struct User: Decodable {
    let login: String
    
    private let avatarURLString: String
    
    var avatarURL: URL? {
        return URL(string: avatarURLString)
    }
    
    enum CodingKeys: String, CodingKey {
        case login
        case avatarURLString = "avatar_url"
    }
}

struct Users: Decodable {
    let items: [User]
}

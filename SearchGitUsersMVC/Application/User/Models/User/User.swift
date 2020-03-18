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
    let name: String?
    let followers: Int?
    let following: Int?
    let htmlURL: String?
    let publicRepos: Int?
//    let createdAt: Date?
    
    private let avatarURLString: String
    
    var avatarURL: URL? {
        return URL(string: avatarURLString)
    }
    
    enum CodingKeys: String, CodingKey {
        case login
        case name
        case followers
        case following
        case htmlURL = "html_url"
        case publicRepos = "public_repos"
//        case createdAt = "created_at"
        case avatarURLString = "avatar_url"
    }
}

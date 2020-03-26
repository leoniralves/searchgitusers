//
//  UserAPI.swift
//  SearchGitUsersMVC
//
//  Created by Leonir Alves Deolindo on 07/03/20.
//  Copyright © 2020 Leonir Deolindo. All rights reserved.
//

import Foundation

enum UserAPI {
    case search(name: String, page: Int)
    case profile(login: String)
}

extension UserAPI: ServiceTargetProtocol {
    var baseURL: URL? {
        return URL(string: "https://api.github.com")
    }
    
    var path: String {
        switch self {
        case .search:
            return "search/users"
        case .profile(let login):
            return "users/\(login)"
        }
    }
    
    var method: HTTPMethod {
        return .GET
    }
    
    var parameters: [String : String] {
        switch self {
        case .search(let name, let page):
            return ["q": name,
                    "page": String(page)]
        default:
            return [:]
        }
    }
}

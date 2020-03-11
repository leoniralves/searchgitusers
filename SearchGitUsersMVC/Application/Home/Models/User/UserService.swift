//
//  UserService.swift
//  SearchGitUsersMVC
//
//  Created by Leonir Alves Deolindo on 07/03/20.
//  Copyright © 2020 Leonir Deolindo. All rights reserved.
//

import Foundation

enum UserService: ServiceProtocol {
    
    case query(name: String, page: Int)
    
    var baseURL: URL? {
        return URL(string: "https://api.github.com")
    }
    
    var path: String {
        switch self {
        case .query:
            return "search/users"
        }
    }
    
    var method: HTTPMethod {
        return .GET
    }
    
    var parameters: [String : String] {
        switch self {
        case .query(let name, let page):
            return ["q": name,
                    "page": String(page)]
        }
    }
}

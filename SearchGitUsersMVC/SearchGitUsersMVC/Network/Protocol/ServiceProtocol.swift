//
//  ServiceProtocol.swift
//  SearchGitUsersMVC
//
//  Created by Leonir Alves Deolindo on 07/03/20.
//  Copyright © 2020 Leonir Deolindo. All rights reserved.
//

import Foundation

protocol ServiceTargetProtocol {
    var baseURL: URL? { get }
    var path: String { get }
    var method: HTTPMethod { get }
    var parameters: [String: String] { get }
}

extension ServiceTargetProtocol {
    var baseURL: URL? {
        return URL(string: "https://api.github.com")
    }
}

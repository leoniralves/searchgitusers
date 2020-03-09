//
//  NetworkError.swift
//  SearchGitUsersMVC
//
//  Created by Leonir Alves Deolindo on 07/03/20.
//  Copyright © 2020 Leonir Deolindo. All rights reserved.
//

import Foundation

enum NetworkError: Error {
    case badURL
    case connectionFailure(Error)
    case noData
    case parseError(Error)
}

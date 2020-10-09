//
//  UserService.swift
//  SearchGitUsersMVC
//
//  Created by Leonir Alves Deolindo on 26/03/20.
//  Copyright © 2020 Leonir Deolindo. All rights reserved.
//

import Foundation

class UserService: ServiceProvider {
    
    func search(name: String,
                       page: Int = 0,
                       completion: @escaping (Result<Users, NetworkError>)->Void) {
        request(target: UserAPI.search(name: name,
                                       page: page),
                completion: completion)
    }
    
    func profile(userlogin: String,
                 completion: @escaping (Result<User, NetworkError>)->Void) {
        request(target: UserAPI.profile(login: userlogin),
                completion: completion)
    }
}

//
//  HomeViewController.swift
//  SearchGitUsersMVVM-C
//
//  Created by Leonir Alves Deolindo on 09/10/20.
//

import UIKit

class HomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        ServiceProvider().request(target: UserAPI.search(name: "leonir", page: 0)) { (result: Result<Users, NetworkError>) in
            switch result {
            case .success(let users):
                print("success: \(users)")
            case .failure(let error):
                print(error)
            }
        }
    }
}


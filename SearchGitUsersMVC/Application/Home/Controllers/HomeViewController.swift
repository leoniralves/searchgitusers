//
//  HomeViewController.swift
//  SearchGitUsersMVC
//
//  Created by Leonir Alves Deolindo on 07/03/20.
//  Copyright © 2020 Leonir Deolindo. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    private let homeView = HomeView()
    private let sessionProvider = SessionProvider()
    
    override func loadView() {
        view = homeView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Home"
        homeView.delegate = self
    }

    private func searchUser(with name: String, page: Int) {
        sessionProvider.request(type: Users.self, service: UserService.query(name: name, page: page)) { [weak self] (result) in
            switch result {
            case .success(let users):
                self?.homeView.configure(users: users)
            case .failure(let error):
                print(error)
            }
        }
    }
}

extension HomeViewController: HomeViewDelegate {
    func homeView(_ homeView: HomeView, searchTextDidChange: String) {
        searchUser(with: searchTextDidChange, page: 0)
    }
}

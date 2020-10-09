//
//  UserListViewController.swift
//  SearchGitUsersMVC
//
//  Created by Leonir Alves Deolindo on 07/03/20.
//  Copyright © 2020 Leonir Deolindo. All rights reserved.
//

import UIKit

final class UserListViewController: UIViewController {
    
    let userListView = UserListView()
    private let service: UserService
    
    init(service: UserService = UserService()) {
        self.service = service
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = userListView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Home"
        userListView.delegate = self
    }
    
    private func searchUser(with name: String, page: Int) {
        service.search(name: name,
                           page: page) { [weak self] (result) in
                            switch result {
                            case .success(let users):
                                self?.userListView.configure(users: users)
                            case .failure(let error):
                                print(error)
                            }
                            
        }
    }
}

extension UserListViewController: UserListViewDelegate {
    func userListView(_ homeView: UserListView, didSelected user: User) {
        self.show(UserDetailsViewController(user: user), sender: nil)
    }
    
    func userListView(_ homeView: UserListView, searchTextDidChange: String) {
        searchUser(with: searchTextDidChange, page: 0)
    }
}

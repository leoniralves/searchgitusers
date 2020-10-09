//
//  UserDetailsViewController.swift
//  SearchGitUsersMVC
//
//  Created by Leonir Alves Deolindo on 18/03/20.
//  Copyright © 2020 Leonir Deolindo. All rights reserved.
//

import UIKit

final class UserDetailsViewController: UIViewController {
    
    private var userDetailView = UserDetailsView()
    private var user: User
    private let service: UserService
    
    init(user: User, service: UserService = UserService()) {
        self.user = user
        self.service = service
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = userDetailView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = user.login
        loadData()
    }
    
    private func loadData() {
        service.profile(userlogin: user.login) { (result) in
            switch result {
            case .success(let user):
                DispatchQueue.main.async {
                    self.userDetailView.configure(user)
                }
            case .failure(let error):
                print(error)
            }
        }
    }
}

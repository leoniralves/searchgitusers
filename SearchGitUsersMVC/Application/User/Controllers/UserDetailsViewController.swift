//
//  UserDetailsViewController.swift
//  SearchGitUsersMVC
//
//  Created by Leonir Alves Deolindo on 18/03/20.
//  Copyright © 2020 Leonir Deolindo. All rights reserved.
//

import UIKit

class UserDetailsViewController: UIViewController {
    
    private var userDetailView = UserDetailsView()
    private var user: User
    
    override func loadView() {
        view = userDetailView
    }
    
    init(user: User) {
        self.user = user
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = user.login
        loadData()
    }
    
    private func loadData() {
        let sessionProvider = SessionProvider()
        sessionProvider.request(type: User.self, service: UserService.profile(login: user.login)) { (result) in
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

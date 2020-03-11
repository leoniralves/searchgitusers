//
//  HomeView.swift
//  SearchGitUsersMVC
//
//  Created by Leonir Alves Deolindo on 10/03/20.
//  Copyright © 2020 Leonir Deolindo. All rights reserved.
//

import UIKit

class HomeView: UIView {
    
    @IBOutlet weak var tableView: UITableView!
    
    private var users: [User] = []
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        loadView()
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(users: Users) {
        self.users = users.items
        DispatchQueue.main.sync {
            tableView.reloadData()
        }
    }
    
    private func setup() {
        // Delegate & Data Source
        tableView.dataSource = self
        
        // Register Cell
        tableView.register(HomeViewCell.self)
        
        // Configure Layout
        tableView.tableFooterView = UIView()
    }
}

extension HomeView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: HomeViewCell = tableView.dequeueReusableCell(indexPath: indexPath)
        cell.configure(user: users[indexPath.row])
        return cell
    }
}

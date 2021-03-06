//
//  UserListView.swift
//  SearchGitUsersMVC
//
//  Created by Leonir Alves Deolindo on 10/03/20.
//  Copyright © 2020 Leonir Deolindo. All rights reserved.
//

import UIKit

protocol UserListViewDelegate: class {
    func userListView(_ userListView: UserListView, searchTextDidChange: String)
    func userListView(_ userListView: UserListView, didSelected user: User)
}

class UserListView: UIView {
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    weak var delegate: UserListViewDelegate?
    
    private(set) var users: [User] = []
    
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
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    private func setup() {
        /// SearchBar Delegate
        searchBar.delegate = self
        
        /// TableView Delegate & Data Source
        tableView.dataSource = self
        tableView.delegate = self
        
        /// Register Cell
        tableView.register(UserListViewCell.self)
        
        /// Configure Layout
        tableView.tableFooterView = UIView()
    }
}

extension UserListView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UserListViewCell = tableView.dequeueReusableCell(indexPath: indexPath)
        cell.configure(user: users[indexPath.row])
        return cell
    }
}

extension UserListView: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.userListView(self, didSelected: users[indexPath.row])
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        endEditing(true)
    }
}

extension UserListView: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchText = searchBar.text else {
            return
        }
        delegate?.userListView(self, searchTextDidChange: searchText)
        endEditing(!searchText.isEmpty)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
            print("clear")
        }
    }
}

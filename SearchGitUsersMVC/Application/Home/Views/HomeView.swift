//
//  HomeView.swift
//  SearchGitUsersMVC
//
//  Created by Leonir Alves Deolindo on 10/03/20.
//  Copyright © 2020 Leonir Deolindo. All rights reserved.
//

import UIKit

protocol HomeViewDelegate: class {
    func homeView(_ homeView: HomeView, searchTextDidChange: String)
}

class HomeView: UIView {
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    weak var delegate: HomeViewDelegate?
    
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
        /// SearchBar Delegate
        searchBar.delegate = self
        
        /// TableView Delegate & Data Source
        tableView.dataSource = self
        tableView.delegate = self
        
        /// Register Cell
        tableView.register(HomeViewCell.self)
        
        /// Configure Layout
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

extension HomeView: UITableViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        endEditing(true)
    }
}

extension HomeView: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchText = searchBar.text else {
            return
        }
        delegate?.homeView(self, searchTextDidChange: searchText)
        endEditing(!searchText.isEmpty)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
            print("clear")
        }
    }
}

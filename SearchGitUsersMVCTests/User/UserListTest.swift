//
//  UserListTest.swift
//  SearchGitUsersMVCTests
//
//  Created by Leonir Alves Deolindo on 26/03/20.
//  Copyright © 2020 Leonir Deolindo. All rights reserved.
//

import XCTest
@testable import SearchGitUsersMVC

class UserListTest: XCTestCase {

    var userListViewController: UserListViewController!
    var service: UserService!
    
    override func setUp() {
        service = UserService()
        userListViewController = UserListViewController(service: service)
        userListViewController.viewDidLoad()
    }

    override func tearDown() {
        userListViewController = nil
    }
    
    func testList() {
        XCTAssertEqual(userListViewController.title, "Home")
    }

    func testList2() {
        let listView = userListViewController.userListView
        XCTAssertNotNil(listView.searchBar.delegate)
        
        listView.searchBar.text = "leoniralves"
        listView.searchBarSearchButtonClicked(listView.searchBar)
        
        guard let user = listView.users.first else {
            XCTFail("No one user!")
            return
        }
        
        XCTAssertEqual(user.login, "leoniralves")
    }
}

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
    var mockURLSession: MockURLSession!
    
    override func setUp() {
        mockURLSession = MockURLSession()
        service = UserService(session: mockURLSession)
        userListViewController = UserListViewController(service: service)
        userListViewController.viewDidLoad()
    }

    override func tearDown() {
        userListViewController = nil
    }

    func testSearchUser_WithUsername_ShouldSuccess() {
        let expectation = XCTestExpectation(description: "Request User data")
        
        XCTAssertTrue(mockURLSession.loadJsonWith(name: "ResponseUserExists"))
        
        let listView = userListViewController.userListView
        listView.searchBar.text = "leoniralves"
        listView.searchBarSearchButtonClicked(listView.searchBar)

        expectation.fulfill()
        
        XCTAssertTrue(listView.users.count > 0, "List of users is empty")
        
        wait(for: [expectation], timeout: 10.0)
    }
    
    func testSearchUser_WithUsernameNotExist_ShouldSuccess() {
        let expectation = XCTestExpectation(description: "Request User data")
        
        XCTAssertTrue(mockURLSession.loadJsonWith(name: "ResponseUserNotExists"))
        
        let listView = userListViewController.userListView
        listView.searchBar.text = "leoniralves"
        listView.searchBarSearchButtonClicked(listView.searchBar)

        expectation.fulfill()
        
        XCTAssertTrue(listView.users.count == 0, "List of users isn't empty")
        
        wait(for: [expectation], timeout: 10.0)
    }
}

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
    
    func testList() {
        XCTAssertEqual(userListViewController.title, "Home")
    }

    func testSearchUserWithLogin() {
        let expectation = XCTestExpectation(description: "Request User data")
        
        XCTAssertTrue(mockURLSession.loadJsonWith(name: "user"))
        
        let listView = userListViewController.userListView
        XCTAssertNotNil(listView.searchBar.delegate)
        
        listView.searchBar.text = "leoniralves"
        listView.searchBarSearchButtonClicked(listView.searchBar)

        expectation.fulfill()
        
        guard let user = listView.users.first else {
            XCTFail("No one user!")
            return
        }
        
        XCTAssertEqual(user.login, "userTest")
        XCTAssertEqual(user.avatarURL, URL(string: "https://avatars3.githubusercontent.com/u/00000"))
        
        wait(for: [expectation], timeout: 10.0)
    }
}

//
//  SessionProviderTests.swift
//  SearchGitUsersMVCTests
//
//  Created by Leonir Alves Deolindo on 07/03/20.
//  Copyright © 2020 Leonir Deolindo. All rights reserved.
//

import XCTest
@testable import SearchGitUsersMVC

enum MockService: ServiceProtocol {
    
    case mock
    
    var baseURL: URL? {
        return URL(string: "http://opa.com")
    }
    
    var path: String {
        return "users"
    }
    
    var method: HTTPMethod {
        return HTTPMethod.GET
    }
    
    var parameters: [String : String] {
        return [:]
    }
    
    
}

class SessionProviderTests: XCTestCase {

    private var sessionProvider: SessionProvider!
    private let mockURLSession = MockURLSession()
    
    override func setUp() {
        sessionProvider = SessionProvider(session: mockURLSession)
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testRequestWithURL() {
        let expectation = XCTestExpectation(description: "Request User data")
        sessionProvider.request(type: User.self, service: MockService.mock) { [weak self] result in
            XCTAssertEqual(self?.mockURLSession.lastURL, URL(string: "http://opa.com/users"))
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 10.0)
    }
    
    func testRequestResumeCalled() {
        
        let dataTask = MockURLSessionDataTask()
        mockURLSession.dataTask = dataTask
        
        let expectation = XCTestExpectation(description: "Request User data")
        sessionProvider.request(type: User.self,
                                service: MockService.mock) { _ in
            expectation.fulfill()
        }
        XCTAssertTrue(dataTask.mockResumeCalled)
        wait(for: [expectation], timeout: 10.0)
    }
    
    func testParseJsonResponse() {
        let bundle = Bundle(for: Self.self)
        guard let url = bundle.url(forResource: "user", withExtension: "json") else {
            XCTFail("Missing file: User.json")
            return
        }
        let data = try? Data(contentsOf: url)
        XCTAssertNotNil(data)
        
        mockURLSession.data = data
        
        let expectation = XCTestExpectation(description: "Request User data")
        sessionProvider.request(type: Users.self,
                                service: MockService.mock) { result in
            switch result {
            case .success(let users):
                XCTAssertEqual(users.items[0].login, "leoniralves")
            case .failure(let error):
                XCTFail("Error: \(error)")
            }
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 10.0)
    }
}

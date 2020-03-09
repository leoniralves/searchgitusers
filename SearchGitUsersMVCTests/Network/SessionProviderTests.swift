//
//  SessionProviderTests.swift
//  SearchGitUsersMVCTests
//
//  Created by Leonir Alves Deolindo on 07/03/20.
//  Copyright © 2020 Leonir Deolindo. All rights reserved.
//

import XCTest
@testable import SearchGitUsersMVC

class MockURLSessionDataTask: URLSessionDataTaskProtocol {
    var mockResumeCalled = false
    func resume() {
        mockResumeCalled = true
    }
}

class MockURLSession: URLSessionProtocol {
    var lastURL: URL?
    var dataTask = MockURLSessionDataTask()
    
    func dataTask(request: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTaskProtocol {
        lastURL = request.url
        completionHandler(nil, nil, nil)
        return dataTask
    }
}

enum MockUserService: ServiceProtocol {
    
    case query(name: String, page: Int)
    
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
        sessionProvider.request(type: User.self,
                                service: MockUserService.query(name: "leonir",
                                                           page: 1)) { [weak self] result in
                                                            
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
                                service: MockUserService.query(name: "leonir",
                                                           page: 1)) { _ in
            expectation.fulfill()
        }
        XCTAssertTrue(dataTask.mockResumeCalled)
        wait(for: [expectation], timeout: 10.0)
    }
}

//
//  MockURLSessionDataTask.swift
//  SearchGitUsersMVCTests
//
//  Created by Leonir Alves Deolindo on 09/03/20.
//  Copyright © 2020 Leonir Deolindo. All rights reserved.
//

import Foundation
@testable import SearchGitUsersMVC

class MockURLSessionDataTask: URLSessionDataTaskProtocol {
    var mockResumeCalled = false
    func resume() {
        mockResumeCalled = true
    }
}

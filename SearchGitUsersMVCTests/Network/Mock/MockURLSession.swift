//
//  MockURLSession.swift
//  SearchGitUsersMVCTests
//
//  Created by Leonir Alves Deolindo on 09/03/20.
//  Copyright © 2020 Leonir Deolindo. All rights reserved.
//

import Foundation
@testable import SearchGitUsersMVC

class MockURLSession: URLSessionProtocol {
    var lastURL: URL?
    var dataTask = MockURLSessionDataTask()
    var data: Data?
    
    func dataTask(request: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTaskProtocol {
        lastURL = request.url
        completionHandler(data, nil, nil)
        return dataTask
    }
}

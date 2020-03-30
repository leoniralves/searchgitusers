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
    
    private var data: Data?
    
    func successHttpURLResponse(request: URLRequest) -> URLResponse {
        return HTTPURLResponse(url: request.url!,
                               statusCode: 200,
                               httpVersion: "HTTP/1.1",
                               headerFields: nil)!
    }
    
    func dataTask(request: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTaskProtocol {
        lastURL = request.url
        
        completionHandler(data,
                          successHttpURLResponse(request: request),
                          nil)
        return dataTask
    }
    
    func loadJsonWith(name: String) -> Bool {
        let bundle = Bundle(for: Self.self)
        guard let url = bundle.url(forResource: name, withExtension: "json"),
            let data = try? Data(contentsOf: url) else {
            return false
        }
        self.data = data
        return true
    }
}

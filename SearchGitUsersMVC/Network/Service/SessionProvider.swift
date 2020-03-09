//
//  SessionProvider.swift
//  SearchGitUsersMVC
//
//  Created by Leonir Alves Deolindo on 07/03/20.
//  Copyright © 2020 Leonir Deolindo. All rights reserved.
//

import Foundation

class SessionProvider {
    
    private var session: URLSessionProtocol
    
    init(session: URLSessionProtocol = URLSession.shared) {
        self.session = session
    }
    
    func request<T: Decodable>(type: T.Type, service: ServiceProtocol, completion: @escaping (Result<T, NetworkError>) -> Void) {
        guard let url = service.baseURL?.appendingPathComponent(service.path) else {
            completion(.failure(.badURL))
            return
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.addValue("Bearer 299fe800f61647ad4087a52b90fd656e8ab18f89",
                            forHTTPHeaderField: "Authorization")
        
        let session = self.session.dataTask(request: urlRequest) { (data, response, error) in
            if let error = error {
                completion(.failure(.connectionFailure(error)))
            } else {
                guard let data = data else {
                    completion(.failure(.noData))
                    return
                }
                
                do {
                    let decoded = try JSONDecoder().decode(T.self, from: data)
                    completion(.success(decoded))
                } catch(let error) {
                    completion(.failure(.parseError(error)))
                }
            }
        }
        
        session.resume()
    }
}

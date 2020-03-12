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
        
        guard var components = URLComponents(url: url, resolvingAgainstBaseURL: false) else {
            completion(.failure(.badURL))
            return
        }
        
//        components.queryItems = service.parameters.map({ URLQueryItem(name: $0.key, value: $0.value) })
        
        guard let componentURL = components.url else {
            completion(.failure(.badURL))
            return
        }
        
        var urlRequest = URLRequest(url: componentURL)
        urlRequest.addValue(auth,
                            forHTTPHeaderField: "Authorization")
        
        let session = self.session.dataTask(request: urlRequest) { [weak self] (data, response, error) in
            self?.debugResponse(request: urlRequest, data: data)
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
    
    private lazy var auth: String = {
        let auth = "Bearer \(Credentials.accessToken)"
        return auth
    }()
    
    private func debugResponse(request: URLRequest, data: Data?) {
        print("==== REQUEST ====")
        print("\nURL: \(request.url?.absoluteString ?? "")")
        
        if let requestHeader = request.allHTTPHeaderFields {
            if let data = try? JSONSerialization.data(withJSONObject: requestHeader, options: .prettyPrinted) {
                print("\nHEADER: \(String(data: data, encoding: .utf8) ?? "")")
            }
        }
        
        print("\nMETHOD: \(request.httpMethod ?? "")")
        
        print("\n==== RESPONSE ====")
        if let data = data {
            if let jsonObject = try? JSONSerialization.jsonObject(with: data) {
                if let jsonData = try? JSONSerialization.data(withJSONObject: jsonObject, options: .prettyPrinted) {
                    print(String(data: jsonData, encoding: .utf8) ?? "")
                }
            }
        }
        print("\n================\n")
    }
}

//
//  NetworkService.swift
//  Movies
//
//  Created by Tatiana Ampilogova on 6/4/22.
//

import Foundation

protocol NetworkService {
    ///send request
    func send(request: NetworkRequest, completion: @escaping (Result<Data, Error>) -> Void)
}

class NetworkServiceImpl: NetworkService {
    
    private let urlSession = URLSession.shared
    
    func send(request: NetworkRequest, completion: @escaping (Result<Data, Error>) -> Void) {
        let urlRequest = request.url
        let dataTask = urlSession.dataTask(with: urlRequest) { data, responce, error in
            if let error = error {
                completion (.failure(error))
            } else if let data = data {
                completion(.success(data))
            } else {
                completion(.failure(NSError(domain: "network error", code: -1)))
            }
        }
        dataTask.resume()
    }
}

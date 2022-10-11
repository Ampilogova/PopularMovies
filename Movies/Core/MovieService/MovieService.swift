//
//  MovieService.swift
//  Movies
//
//  Created by Tatiana Ampilogova on 6/4/22.
//

import Foundation

protocol MovieService {
    ///load movies
    func loadMovie(page: Int, locale: String, completion: @escaping (Result<[Movie], Error>) -> Void)
}

class MovieServiceImpl: MovieService {
    
    private let decoder = JSONDecoder()
    private let url = "https://api.themoviedb.org/3/movie/top_rated?"
    private let api = "39881ecb924331f052250d9de01670ca"
    private let networkService: NetworkService
    
    init(networkService: NetworkService) {
        self.networkService = networkService
    }
    
    func loadMovie(page: Int, locale: String, completion: @escaping (Result<[Movie], Error>) -> Void) {
        let parameters = ["api_key": api,
                          "language": locale,
                          "page": String(page)]
        
        var urlComponents = URLComponents(string: url)
        urlComponents?.queryItems = parameters.map({ (key,value) -> URLQueryItem in
            URLQueryItem(name: key, value: value)
        })
        
        if let urlComponents = urlComponents?.url {
            let networkRequest = NetworkRequest(url: urlComponents)
            networkService.send(request: networkRequest) { [weak self] result in
                switch result {
                case .success(let data):
                    let movies = try? self?.decoder.decode(DataResult.self, from: data)
                    completion(.success(movies?.results ?? []))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        }
    }
}

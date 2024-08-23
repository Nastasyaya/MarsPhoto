//
//  NetworkService.swift
//  MarsCamera
//
//  Created by Анастасия Кутняхова on 23.08.2024.
//

import Foundation

protocol NetworkService {
    func fetchMarsDataResponse(
        sol: String,
        page: String,
        completion: @escaping (Result<Welcome, MarsPhotosError>) -> Void
    )
}

final class NetworkServiceImp: NetworkService {
    func fetchMarsDataResponse(
        sol: String,
        page: String,
        completion: @escaping (Result<Welcome, MarsPhotosError>) -> Void
    ) {
        guard let task = makeURLSessionDataTask(
            sol: sol,
            page: page,
            complition: completion
        ) else {
            completion(.failure(.missingTask))
            return
        }
        
        task.resume()
    }
    
    
    private func makeURLSessionDataTask(
        sol: String,
        page: String,
        complition: @escaping (Result<Welcome, MarsPhotosError>) -> Void
    ) -> URLSessionDataTask? {
        guard let request = makeURLRequest(
            sol: sol,
            page: page
        ) else {
            complition(.failure(.invalidRequest))
            return nil
        }
        
        return URLSession.shared.dataTask(with: request) { data, response, error in
            guard let response else {
                complition(.failure(.missingResponse))
                return
            }
            print(response)
            
            guard let data else {
                complition(.failure(.missingData))
                return
            }
            
            do {
                let response = try JSONDecoder().decode(Welcome.self, from: data)
                complition(.success(response))
            } catch {
                complition(.failure(.jsonDecodeFailed))
                print("Error: \(error.localizedDescription)")
            }
        }
    }
    
    private func makeURLRequest(sol: String, page: String) -> URLRequest? {
        guard let url = makeURL(sol: sol, page: page) else { return nil }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.timeoutInterval = 10
        
        return request
    }
    
    private func makeURL(sol: String, page: String) -> URL? {
        var components = URLComponents()
        
        components.scheme = "https"
        components.host = "api.nasa.gov"
        components.path = "/mars-photos/api/v1/rovers/curiosity/photos"
        components.queryItems = [
            URLQueryItem(name: "sol", value: sol),
            URLQueryItem(name: "page", value: page),
            URLQueryItem(name: "api_key", value: APIkey.key)
        ]
        
        return components.url
    }
}

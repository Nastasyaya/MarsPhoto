//
//  NetworkService.swift
//  MarsPhoto
//
//  Created by Анастасия Кутняхова on 23.08.2024.
//

import Foundation
import UIKit

protocol NetworkService {
    func fetchMarsDataResponse(
        sol: String,
        page: String,
        completion: @escaping (Result<PhotosResponse, MarsPhotosError>) -> Void
    )

    func fetchImage(
        url: String,
        completion: @escaping (Result<UIImage, MarsPhotosError>) -> Void
    )
}

final class NetworkServiceImp: NetworkService {
    static let shared = NetworkServiceImp()

    private init() {}

    func fetchMarsDataResponse(
        sol: String,
        page: String,
        completion: @escaping (Result<PhotosResponse, MarsPhotosError>) -> Void
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

    func fetchImage(
        url: String,
        completion: @escaping (Result<UIImage, MarsPhotosError>) -> Void
    ) {
        guard let url = URL(string: url) else {
            completion(.failure(.invalidRequest))
            return
        }

        let cache = URLCache.shared
        let request = URLRequest(url: url)

        if 
            let cachedResponse = cache.cachedResponse(for: request),
            let image = UIImage(data: cachedResponse.data)
        {
            completion(.success(image))
        } else {
            URLSession.shared.dataTask(with: request) { data, response, error in
                guard
                    let data = data,
                    let response = response,
                    let image = UIImage(data: data)
                else {
                    completion(.failure(.missingData))
                    return
                }

                let cachedData = CachedURLResponse(response: response, data: data)
                cache.storeCachedResponse(cachedData, for: request)
                completion(.success(image))
            }
            .resume()
        }
    }

    private func makeURLSessionDataTask(
        sol: String,
        page: String,
        complition: @escaping (Result<PhotosResponse, MarsPhotosError>) -> Void
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

            print(data.prettyPrintedJSONString ?? "Incorrect JSON format")

            do {
                let response = try JSONDecoder().decode(PhotosResponse.self, from: data)
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

extension Data {
    var prettyPrintedJSONString: NSString? {
        guard 
            let object = try? JSONSerialization.jsonObject(with: self, options: []),
            let data = try? JSONSerialization.data(withJSONObject: object, options: [.prettyPrinted]),
            let prettyPrintedString = NSString(data: data, encoding: String.Encoding.utf8.rawValue)
        else { return nil }

        return prettyPrintedString
    }
}

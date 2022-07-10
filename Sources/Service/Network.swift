//
//  Network.swift
//  MVVMC-SwiftUI
//
//  Created by Carlos Cayres on 08/07/22.
//

import Foundation
import Combine
import UIKit

protocol NetworkProtocol {
    
    func retrieve<T: Codable>(request: RequestProtocol) -> AnyPublisher<T, Error>
    func downloadImage(from urlString: String) -> AnyPublisher<Data, Error>
}

class Network: NetworkProtocol {
    
    func retrieve<T: Codable>(request: RequestProtocol) -> AnyPublisher<T, Error> {
        guard let url = request.urlRequest() else { return  Fail(error: URLError(.unsupportedURL)).eraseToAnyPublisher() }
        return performRequest(on: url)
            .decode(type: T.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
    
    func downloadImage(from urlString: String) -> AnyPublisher<Data, Error> {
        guard let url = URL(string: urlString) else { return Fail(error: URLError(.unsupportedURL)).eraseToAnyPublisher() }
        return performRequest(on: url)
            .eraseToAnyPublisher()
    }
    
    private func performRequest(on url: URL) -> AnyPublisher<Data, Error> {
        return URLSession.shared.dataTaskPublisher(for: url)
            .subscribe(on: DispatchQueue.global(qos: .background))
            .receive(on: DispatchQueue.main)
            .tryMap { (data, response) -> Data in
                guard let response = response as? HTTPURLResponse else { throw URLError(.badServerResponse) }
                guard response.statusCode >= 200 && response.statusCode < 300 else { throw URLError(.unknown) }
                return data
            }
            .eraseToAnyPublisher()
    }
}

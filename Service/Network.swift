//
//  Network.swift
//  MVVMC-SwiftUI
//
//  Created by Carlos Cayres on 08/07/22.
//

import Foundation
import Combine

class Network {
    
    func retrieve<T: Codable>(request: RequestProtocol) -> AnyPublisher<T, Error> {
    
        guard let url = request.urlRequest() else { return  Fail(error: URLError(.unsupportedURL)).eraseToAnyPublisher() }
        
        return URLSession.shared.dataTaskPublisher(for: url)
            .subscribe(on: DispatchQueue.global(qos: .background))
            .receive(on: DispatchQueue.main)
            .tryMap { (data, response) -> Data in
                
                guard let response = response as? HTTPURLResponse else { throw URLError(.badServerResponse) }
                
                guard response.statusCode >= 200 && response.statusCode < 300 else { throw URLError(.unknown) }
                
                let json = try JSONSerialization.jsonObject(with: data, options: .fragmentsAllowed) as? [String: Any]
                print(json)
                return data
            }
            .decode(type: T.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
}

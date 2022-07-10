//
//  Service.swift
//  MVVMC-SwiftUI
//
//  Created by Carlos Cayres on 08/07/22.
//

import Combine
import SwiftUI

protocol ServiceProtocol {
    
    func fetchCharacters(atPage page: Int) -> AnyPublisher<APIResponse<Characther>, Error>
    func fetchEpisodes(atPage page: Int) -> AnyPublisher<APIResponse<Episode>, Error>
    func fetchLocations(atPage page: Int) -> AnyPublisher<APIResponse<Location>, Error>
}

class Service: ServiceProtocol {
    
    let network: Network
    
    init(network: Network = Network()) {
        self.network = network
    }
    
    func fetchCharacters(atPage page: Int = 0) -> AnyPublisher<APIResponse<Characther>, Error> {
        return fetchFor(request: .characters(page))
    }
    
    func fetchEpisodes(atPage page: Int = 0) -> AnyPublisher<APIResponse<Episode>, Error> {
        return fetchFor(request: .episodes(page))
    }
    
    func fetchLocations(atPage page: Int = 0) -> AnyPublisher<APIResponse<Location>, Error> {
        return fetchFor(request: .locations(page))
    }
    
    func fetchFor<T: Codable>(request: APIRequest) -> AnyPublisher<T, Error> {
        return network.retrieve(request: request).eraseToAnyPublisher()
    }
}

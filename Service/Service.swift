//
//  Service.swift
//  MVVMC-SwiftUI
//
//  Created by Carlos Cayres on 08/07/22.
//

import Foundation
import Combine

class Service {
    
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

class ServiceManager {
    
    let service: Service
    
    var charactersInfos: APIREsponseInfo?
    var episodesInfos: APIREsponseInfo?
    var locationsarInfos: APIREsponseInfo?
    
    @Published var chars: [Characther]?
    @Published var episodes: [Episode]?
    @Published var locations: [Location]?
    
    @Published var onRequest: Bool?
    
    init(service:Service = Service()) {
        self.service = service
    }
    
    func loadMoreChars() {
        
        //Characters
        service.fetchCharacters()
            .mapError { error in
            return URLError(.unknown)
        }
        .sink { h in
            
            switch h {
                
            case .finished:
                self.onRequest = false
                
            case let .failure(error):
                self.onRequest = false
                print(error)
            }
            
        } receiveValue: { value in
            self.charactersInfos = value.info
            self.chars = value.results
        }
        
        // Episodes
        service.fetchEpisodes()
            .mapError { error in
            return URLError(.unknown)
        }
        .sink { h in
            
            switch h {
                
            case .finished:
                self.onRequest = false
                
            case let .failure(error):
                self.onRequest = false
                print(error)
            }
            
        } receiveValue: { value in
            self.episodesInfos = value.info
            self.episodes = value.results
        }
        
        // Locations
        service.fetchLocations()
            .mapError { error in
            return URLError(.unknown)
        }
        .sink { h in
            
            switch h {
                
            case .finished:
                self.onRequest = false
                
            case let .failure(error):
                self.onRequest = false
                print(error)
            }
            
        } receiveValue: { value in
            self.locationsarInfos = value.info
            self.locations = value.results
        }
    }
}

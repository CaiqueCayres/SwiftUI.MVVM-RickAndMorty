//
//  ServiceManager.swift
//  MVVMC-SwiftUI
//
//  Created by Carlos Cayres on 10/07/22.
//

import SwiftUI
import Combine

protocol DataManagerProtocol {
    
    func loadMoreChars()    -> AnyPublisher<[Characther], Error>
    func loadMoreEpisodes() -> AnyPublisher<[Episode], Error>
    func loadMoreLocation() -> AnyPublisher<[Location], Error>
}

class DataManager: ObservableObject {
    
    let service: ServiceProtocol
    
    var charactersInfos: APIREsponseInfo?
    var episodesInfos: APIREsponseInfo?
    var locationsarInfos: APIREsponseInfo?
    
    @Published var characthersList: [Characther] = []
    @Published var episodesList: [Episode] = []
    @Published var locationLists: [Location] = []
    
    init(service: ServiceProtocol = Service()) {
        self.service = service
    }
}

extension DataManager: DataManagerProtocol {
    
    func loadMoreChars() -> AnyPublisher<[Characther], Error> {
        
        let page = charactersInfos?.nextPageIndex ?? 0
        return service.fetchCharacters(atPage: page)
            .map { response in
                self.characthersList += response.results
                self.charactersInfos = response.info
                return Array(Set(self.characthersList.sorted { $0.name > $1.name }))
            }
            .removeDuplicates()
            .eraseToAnyPublisher()
    }
    
    func loadMoreEpisodes() -> AnyPublisher<[Episode], Error> {
        let page = charactersInfos?.nextPageIndex ?? 0
        return service.fetchEpisodes(atPage: page)
            .map { response in
                self.episodesList += response.results
                self.episodesInfos = response.info
                return self.episodesList
            }
            .removeDuplicates()
            .eraseToAnyPublisher()
    }
    
    func loadMoreLocation() -> AnyPublisher<[Location], Error> {
        let page = charactersInfos?.nextPageIndex ?? 0
        return service.fetchLocations(atPage: page)
            .map { response in
                self.locationLists += response.results
                self.locationsarInfos = response.info
                return self.locationLists
            }
            .removeDuplicates()
            .eraseToAnyPublisher()
    }
}

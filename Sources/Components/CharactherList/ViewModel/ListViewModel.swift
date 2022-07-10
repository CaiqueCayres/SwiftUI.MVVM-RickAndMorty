//
//  ListViewModel.swift
//  MVVMC-SwiftUI
//
//  Created by Carlos Cayres on 09/07/22.
//

import Foundation
import Combine
import SwiftUI

protocol ListViewModelProtocol {
    
    var serviceManager: ServiceManagerProtocol { get }
    
    
    func onFinishScroll(handler:(ServiceManagerProtocol) -> Void)
}

class ListViewModel: ObservableObject {
    
    let service: ServiceManagerProtocol
    
    @Published var sections: [ListSection] = []
    
    var disposeBag = Set<AnyCancellable>()
    
    init(service: ServiceManagerProtocol = ServiceManager()) {
        self.service = service
    }
    
    func updateChars() {
        service.loadMoreChars()
            .map { chars in
                
                return [ListSection(title: "Teste",
                                   contentFormatters: chars.map { CellFormatter(characther: $0) })]
            }
            .sink { error in
                print(error)
            } receiveValue: { sections in
                self.sections = sections
            }
            .store(in: &disposeBag)
    }
    
    struct ListSection: Hashable {
        let title: String
        let contentFormatters: [CellFormatter]
    }
}

//
//  ListViewModel.swift
//  MVVMC-SwiftUI
//
//  Created by Carlos Cayres on 09/07/22.
//

import Foundation
import Combine
import SwiftUI

class ListViewModel: ObservableObject {
    
    let manager: DataManagerProtocol
    
    @Published var sections: [ListSection] = []
    @Published var charsFullList: [Characther] = []
    @Published var sortValue: SortValue = .none
    @Published var filterValue: String = ""
    
    private var disposeBag = Set<AnyCancellable>()
    
    init(manager: DataManagerProtocol = DataManager()) {
        self.manager = manager
        self.addSubscribers()
    }
    
    func addSubscribers() {
        
        $charsFullList
            .combineLatest($filterValue)
            .map { chars, filter in
                guard !filter.isEmpty else { return chars }
                return chars.filter { char in
                    char.name.contains(filter) ||
                    char.species.contains(filter)
                }
            }
            .combineLatest($sortValue) { chars, sort in
                self.organizeInSections(chars: chars, by: sort)
            }
            .sink { sections in
                self.sections = sections
            }
            .store(in: &disposeBag)
    }
    
    func updateChars() {
        manager.loadMoreChars()
            .sink { error in
                print(error)
            } receiveValue: { updatedChars in
                self.charsFullList = updatedChars
            }
            .store(in: &disposeBag)
    }
    
    private func organizeInSections(chars: [Characther], by sortValue: SortValue) -> [ListSection] {
        
        switch sortValue {
            
        case .none:
            return [ListSection(title: "Characthers",
                                contentFormatters: chars.map { CellFormatter(characther: $0) })]
            
        case .species:
            let groupedDict = Dictionary(grouping: chars, by: { $0.species})
            return groupedDict.map { (key: String, value: [Characther]) in
                ListSection(title: key, contentFormatters: value.map { CellFormatter(characther: $0) })
            }
            
        case .charType:
            let groupedDict = Dictionary(grouping: chars, by: { $0.type})
            return groupedDict.map { (key: String, value: [Characther]) in
                ListSection(title: key, contentFormatters: value.map { CellFormatter(characther: $0) })
            }
            
        case .origin:
            let groupedDict = Dictionary(grouping: chars, by: { $0.origin.name})
            return groupedDict.map { (key: String, value: [Characther]) in
                ListSection(title: key, contentFormatters: value.map { CellFormatter(characther: $0) })
            }
        }
    }
    
    struct ListSection: Hashable {
        let title: String
        let contentFormatters: [CellFormatter]
    }
    
    enum SortValue: String {
        case none = "Characthers"
        case species = "Species"
        case origin = "Origin"
        case charType = "Type"
    }
}

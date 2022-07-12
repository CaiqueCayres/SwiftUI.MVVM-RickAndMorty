//
//  ListView.swift
//  MVVMC-SwiftUI
//
//  Created by Carlos Cayres on 10/07/22.
//

import SwiftUI

struct ListView: View {
    
    @ObservedObject var viewModel: ListViewModel
    @State var title: String
    
    let sortValues: [ListViewModel.SortValue] = [.none, .charType, .species, .origin]
    
    init(viewModel: ListViewModel,
         title: String = "") {
        self.viewModel = viewModel
        self.title = title
    }
    
    var body: some View {
        
        NavigationView {
        
            ZStack(alignment: .trailing) {
            
                VStack{
                    
                    SearchBarView(searchText: $viewModel.filterValue)
                    
                    listView()
                    .onAppear { viewModel.updateChars() }
                }
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        menuView(options: sortValues) { sortValue in
                            viewModel.sortValue = sortValue
                        }
                    }
                }
        }
        }
    }
    
    func listView() -> some View {
        
        List(viewModel.sections.indices, id:\.self) { sId in
            
            let section = viewModel.sections[sId]
            
            Section(section.title) {
                ForEach(section.contentFormatters.indices, id:\.self) { rId in
                    
                    let data = section.contentFormatters[rId]
                    
                    CharactherView(model: CellViewModel(data: data))
                        .onAppear {
                            guard rId == section.contentFormatters.count - 1 &&
                                  sId == viewModel.sections.count - 1 else { return }
                            viewModel.updateChars()
                        }
                }
            }
        }
    }
    
    func menuView(options: [ListViewModel.SortValue],
                  onClick: @escaping (ListViewModel.SortValue) -> Void) -> some View {
        
        Menu {
            ForEach(options, id:\.self) { value in
                Button {
                    onClick(value)
                } label: {
                    Text(value.rawValue)
                }
            }
        } label: {
            Image(systemName: "plus")
        }
        .padding()
    }
}

struct ListView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ListView(viewModel: ListViewModel())
                .previewLayout(.sizeThatFits)
                .preferredColorScheme(.light)
            
            ListView(viewModel: ListViewModel())
                .previewLayout(.sizeThatFits)
                .preferredColorScheme(.dark)
        }
    }
}

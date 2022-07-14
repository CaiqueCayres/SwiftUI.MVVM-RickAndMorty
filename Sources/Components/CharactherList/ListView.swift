//
//  ListView.swift
//  MVVMC-SwiftUI
//
//  Created by Carlos Cayres on 10/07/22.
//

import SwiftUI

struct ListView: View {
    
    @ObservedObject var viewModel: ListViewModel
    @Namespace var animation
    @State var title: String
    
    let sortValues: [ListViewModel.SortValue] = [.none, .charType, .species, .origin]
    
    init(viewModel: ListViewModel,
         title: String = "") {
        self.viewModel = viewModel
        self.title = title
    }
    
    var body: some View {
        
        ZStack(alignment: .trailing) {
            
            VStack{
                
                CustomSegmentedBar(options: sortValues)
                    .padding()
                
                SearchBarView(searchText: $viewModel.filterValue,
                              placeHolder: "Search by name or species")
                
                ListView()
                    .onAppear { viewModel.updateChars() }
            }
        }
    }
    
    @ViewBuilder
    func ListView() -> some View {
        
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
    
    
    @ViewBuilder
    func CustomSegmentedBar(options: [ListViewModel.SortValue]) -> some View {
        
        HStack(spacing: 10) {
            ForEach(options, id: \.self) { tab in
                Text(tab.rawValue)
                    .font(.callout)
                    .fontWeight(.semibold)
                    .scaleEffect(0.9)
                    .foregroundColor(viewModel.sortValue == tab ? .black : .gray)
                    .padding(.vertical, 6)
                    .frame(maxWidth: .infinity)
                    .contentShape(Capsule())
                    .onTapGesture {
                        withAnimation { viewModel.sortValue = tab }
                    }
            }
        }
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

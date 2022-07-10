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
    
    init(viewModel: ListViewModel,
         title: String = "") {
        self.viewModel = viewModel
        self.title = title
    }
    
    var body: some View {
        
        VStack{
            List(viewModel.sections, id:\.self) { section in
                Section(section.title) {
                    ForEach(section.contentFormatters, id:\.self) { cellData in
                        CharactherView(model: CellViewModel(data: cellData))
                    }
                }
            }
            .onAppear { viewModel.updateChars() }
            .onTapGesture { viewModel.updateChars() }
        }
    }
}

struct ListView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ListView(viewModel: ListViewModel())
        }
    }
}

//
//  CharactherView.swift
//  MVVMC-SwiftUI
//
//  Created by Carlos Cayres on 10/07/22.
//

import SwiftUI

struct CharactherView: View {
    
    @ObservedObject var model: CellViewModel
    
    init(model: CellViewModel) {
        self.model = model
    }
    
    var body: some View {
        HStack(alignment: .top, spacing: 8) {
            
            Image(uiImage: model.charImage)
                .resizable()
                .frame(width: 60, height: 60)
            
            VStack(alignment: .leading) {
                Text(model.data.name).bold()
                Text(model.data.status)
                Text(model.data.species)
            }
        }
    }
}

struct CharactherView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            CharactherView(model: CellViewModel(data: CellFormatter(characther: Characther(id: 0,
                                                                                           name: "Eu",
                                                                                           status: "alive",
                                                                                           species: "Human",
                                                                                           type: "",
                                                                                           gender: "",
                                                                                           origin: Characther.Origin(name: "",
                                                                                                                     url: ""),
                                                                                           image: "",
                                                                                           episode: [],
                                                                                           url: "",
                                                                                           created: "" ))))
        }
    }
}

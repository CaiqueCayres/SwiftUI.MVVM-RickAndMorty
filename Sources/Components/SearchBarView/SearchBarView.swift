//
//  SearchBarView.swift
//  MVVMC-SwiftUI
//
//  Created by Carlos Cayres on 11/07/22.
//

import SwiftUI

struct SearchBarView: View {
    
    @Binding var searchText: String
    
    var body: some View {
        HStack {
            Image(systemName: "magnifyingglass")
                .foregroundColor(searchText.isEmpty ? .secondary : .primary)
            
            TextField("Search by name or species",
                      text: $searchText)
            .foregroundColor(searchText.isEmpty ? .secondary : .primary)
                .overlay(
                    Image(systemName: "xmark.circle.fill")
                        .padding()
                        .offset(x: 10)
                        .foregroundColor(.white)
                        .opacity(searchText.isEmpty ? 0 : 1)
                        .onTapGesture {
                            searchText = ""
                        },
                    alignment: .trailing
                )
        }
        .font(.body)
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 30)
                .fill(.background)
                .shadow(color: .gray,
                        radius: 10,
                        x: 0,
                        y: 0)
        )
    }
}

struct SearchBarView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            SearchBarView(searchText: .constant(""))
            .previewLayout(.sizeThatFits)
            .preferredColorScheme(.light)
            
        SearchBarView(searchText: .constant(""))
            .previewLayout(.sizeThatFits)
            .preferredColorScheme(.dark)
        }
    }
}

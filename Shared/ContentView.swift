//
//  ContentView.swift
//  Shared
//
//  Created by Carlos Cayres on 08/07/22.
//

import SwiftUI
import Combine

struct ContentView: View {
    
    var body: some View {
        
        VStack {
            ListView(viewModel: ListViewModel(), title: "OI")
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ContentView()
        }
    }
}

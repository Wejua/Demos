//
//  ContentView.swift
//  RefreshableScrollView
//
//  Created by weijie.zhou on 2023/4/29.
//

import SwiftUI

struct Model {
    var name: String = "ac"
    var id = UUID()
}

struct ContentView: View {
    @State var itemModels: [Model] = [Model(), Model(), Model()]
    
    var body: some View {
        RefreshableScrollView(itemModels: $itemModels) {
            LazyVStack {
                ForEach(itemModels, id: \.id) { model in
                    Text(model.name)
//                        .foregroundColor(.black)
                }
            }
        } refreshFunc: { loadPage, success in
            
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

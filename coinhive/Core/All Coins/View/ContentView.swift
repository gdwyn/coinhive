//
//  ContentView.swift
//  coinhive
//
//  Created by Godwin IE on 19/09/2024.
//

import SwiftUI

struct ContentView: View {
    @State var coinsVM = CoinsViewModel()
    var body: some View {
        VStack {
            Text("\(coinsVM.coin) : \(coinsVM.price)")
        }
        .padding()
    }
}

#Preview {
    ContentView()
}

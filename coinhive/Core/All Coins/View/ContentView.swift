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
        List {
            ForEach(coinsVM.coins) { coin in
                Text(coin.name + " " + coin.symbol)
            }
        }
        .overlay {
            if let error = coinsVM.errorMsg {
                Text(error)
            }
        }
    }
}

#Preview {
    ContentView()
}

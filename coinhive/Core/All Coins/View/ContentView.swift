//
//  ContentView.swift
//  coinhive
//
//  Created by Godwin IE on 19/09/2024.
//

import SwiftUI

struct ContentView: View {
    @State var coinsVM = CoinsViewModel()
    @State var prog = 0.00
    
    var body: some View {
        NavigationStack {
            VStack {
                Image("coinhive")
                    .resizable()
                    .scaledToFit()
                    .frame(height: 48)
                
                if let error = coinsVM.errorMsg {
                    Text(error)
                } else {
                    ScrollView(showsIndicators: false) {
                        TopGainers(coins: coinsVM.topGainers)
                        
                        CoinList(coins: coinsVM.coins)
                    }
                }
            }
            .task {
                try? await coinsVM.fetchCoins()
            }
        }
    }
}

#Preview {
    ContentView()
}

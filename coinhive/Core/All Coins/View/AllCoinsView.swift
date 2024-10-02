//
//  ContentView.swift
//  coinhive
//
//  Created by Godwin IE on 19/09/2024.
//

import SwiftUI

struct AllCoinsView: View {
    @EnvironmentObject var coinsVM: CoinsViewModel
    
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
                    ScrollView(showsIndicators: true) {
                        TopGainers()
                        
                        CoinList()
                    }
                    .refreshable {
                        await coinsVM.refreshCoins()
                    }
                }
            }
            .task {
                coinsVM.LoadCoins()
            }
        }
    }
}

#Preview {
    AllCoinsView()
}

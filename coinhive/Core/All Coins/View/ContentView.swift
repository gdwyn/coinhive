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
            
            //HStack {
                ForEach(coinsVM.topGainers) { topCoin in
                    VStack {
                        Text(topCoin.symbol.uppercased())
                            .font(.headline)
                        Text(String(format: "$%.2f", topCoin.currentPrice))
                            .font(.subheadline)
                            .foregroundColor(.gray)
                    }
                    .padding()
                    .background(Color(UIColor.systemBackground))
                    .cornerRadius(8)
                    .shadow(radius: 4)
                }
            //}
            
            List {
                ForEach(coinsVM.topGainers) { coin in
                    VStack {
                        SparklineView(sparkline: coin.sparkLine.price, maxVisiblePoints: 30, lineColor: coin.priceChangePercentage >= 0 ? .green : .red)
                            .frame(width: 100, height: 48)
                        Text(String(format: "%.2f", coin.priceChangePercentage))
                            .foregroundColor(coin.priceChangePercentage >= 0 ? .green : .red)
                        Text(coin.name + " " + coin.symbol)
                    }
                }
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

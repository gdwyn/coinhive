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
                
                VStack(alignment: .leading, spacing: 8) {
                    Text("Top gainers")
                        .font(.title2)
                        .fontWeight(.semibold)
                    
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 14) {
                            ForEach(coinsVM.topGainers) { topCoin in
                                VStack(alignment: .leading) {
                                    AsyncImage(url: URL(string: topCoin.image)) { image in
                                        image
                                            .resizable()
                                            .aspectRatio(contentMode: .fit)
                                            .frame(width: 40, height: 40)
                                            .clipShape(Circle())
                                    } placeholder: {
                                        ProgressView()
                                            .frame(width: 40, height: 40)
                                    }
                                    
                                    HStack {
                                        Text(topCoin.name)
                                            .font(.headline)
                                            .fontWeight(.medium)
                                        
                                        Spacer()
                                        
                                        Text(topCoin.symbol.uppercased())
                                            .font(.callout)
                                            .foregroundStyle(.gray)
                                    }
                                    
                                    SparklineView(sparkline: topCoin.sparkLine.price, maxVisiblePoints: 30, lineColor: topCoin.priceChangePercentage >= 0 ? .green : .red)
                                        .frame(height: 48)
                                        .background(topCoin.priceChangePercentage >= 0 ? .green.opacity(0.04) : .red.opacity(0.04), in: RoundedRectangle(cornerRadius: 12))
                                        .padding(.vertical, 8)
                                    
                                    Text(topCoin.currentPrice, format: .currency(code: "GBP"))
                                        .font(.subheadline)
                                }
                                .padding()
                                .background(Color(UIColor.systemBackground))
                                .cornerRadius(12)
                                .frame(width: 200)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 18)
                                        .stroke(Color.gray.opacity(0.2), lineWidth: 1)
                                )
                            }
                        }
                    }
                }
                
                List {
                    ForEach(coinsVM.coins) { coin in
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
}

#Preview {
    ContentView()
}

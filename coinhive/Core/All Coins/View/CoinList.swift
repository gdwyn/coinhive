//
//  CoinList.swift
//  coinhive
//
//  Created by Godwin IE on 30/09/2024.
//

import SwiftUI

struct CoinList: View {
    var coins: [Coin]

    var body: some View {
        VStack(alignment: .leading) {
            Text("Coins")
                .font(.title3)
                .fontWeight(.semibold)
            
            LazyVStack(alignment: .leading, spacing: 8) {
                ForEach(coins) { coin in
                    VStack {
                        HStack(spacing: 0) {
                            HStack(spacing: 12) {
                                AsyncImage(url: URL(string: coin.image)) { image in
                                    image
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: 40, height: 40)
                                        .clipShape(Circle())
                                } placeholder: {
                                    ProgressView()
                                        .frame(width: 40, height: 40)
                                }
                                
                                VStack(alignment: .leading, spacing: 4) {
                                    Text(coin.name)
                                        .font(.headline)
                                        .fontWeight(.regular)
                                        .lineLimit(1)
                                    
                                    Text(coin.symbol.uppercased())
                                        .font(.caption)
                                        .foregroundStyle(.gray)
                                }
                            }
                            .frame(width: 140, alignment: .leading)
                            
                            Spacer()
                            
                            VStack(alignment: .leading, spacing: 4) {
                                Text(coin.currentPrice, format: .currency(code: "GBP"))
                                    .font(.subheadline)
                                
                                HStack(spacing: 2) {
                                    Image(systemName: coin.priceChangePercentage >= 0 ? "chevron.up" : "chevron.down")
                                    Text(String(format: "%.2f", coin.priceChangePercentage))
                                }
                                .foregroundColor(coin.priceChangePercentage >= 0 ? .green : .red)
                                .font(.caption)
                                
                            }
                            
                            Spacer()

                            SparklineView(sparkline: coin.sparkLine.price, maxVisiblePoints: 30, lineColor: coin.priceChangePercentage >= 0 ? .green : .red)
                                .background(coin.priceChangePercentage >= 0 ? .green.opacity(0.04) : .red.opacity(0.04))
                                .clipShape(RoundedRectangle(cornerRadius: 12))
                                .frame(width: 78, height: 48)

                        }
                        .padding()

                        
                        Divider()
                            .frame(alignment: .bottom)
                            .foregroundStyle(.gray.opacity(0.2))
                    }
                }
            }
            .overlay(
                RoundedRectangle(cornerRadius: 18)
                    .stroke(Color.gray.opacity(0.2), lineWidth: 1)
            )
            .clipped()
        }
        .padding(.horizontal)
        .padding(.top, 24)
    }
}

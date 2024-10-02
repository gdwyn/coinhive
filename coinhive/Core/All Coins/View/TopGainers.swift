//
//  TopGainers.swift
//  coinhive
//
//  Created by Godwin IE on 30/09/2024.
//

import SwiftUI

struct TopGainers: View {
    @EnvironmentObject var coinsVM: CoinsViewModel

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Top gainers")
                .font(.title3)
                .fontWeight(.semibold)
                .padding(.horizontal)
            
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
                            .padding(.bottom, 4)
                            
                            HStack(alignment: .firstTextBaseline) {
                                Text(topCoin.name)
                                    .font(.headline)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .lineLimit(1)
                                
                                Spacer()
                                
                                Text(topCoin.symbol.uppercased())
                                    .font(.caption)
                                    .foregroundStyle(.gray)
                                    .padding(.bottom, 2)
                            }
                            
                            SparklineView(sparkline: topCoin.sparkLine.price, maxVisiblePoints: 30, lineColor: topCoin.priceChangePercentage >= 0 ? .green : .red)
                                .frame(height: 48)
//                                .background(topCoin.priceChangePercentage >= 0 ? .green.opacity(0.04) : .red.opacity(0.04), in: RoundedRectangle(cornerRadius: 12))
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
            .safeAreaPadding(.horizontal)
        }
    }
}

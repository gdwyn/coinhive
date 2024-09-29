//
//  Coin.swift
//  coinhive
//
//  Created by Godwin IE on 23/09/2024.
//

import Foundation

struct Coin: Decodable, Identifiable {
    let id: String
    let symbol: String
    let name: String
    let image: String
    let currentPrice: Double
    let marketCap: Int
    let marketCapRank: Int
    let sparkLine: Sparkline
    let priceChangePercentage: Double

    enum CodingKeys: String, CodingKey {
        case id, symbol, name, image
        case currentPrice = "current_price"
        case marketCapRank = "market_cap_rank"
        case marketCap = "market_cap"
        case sparkLine = "sparkline_in_7d"
        case priceChangePercentage = "price_change_percentage_24h"
    }
}

struct Sparkline: Decodable {
    let price: [Double]
}

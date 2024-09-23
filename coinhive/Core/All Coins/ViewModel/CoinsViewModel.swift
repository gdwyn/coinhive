//
//  CoinsViewModel.swift
//  coinhive
//
//  Created by Godwin IE on 19/09/2024.
//

import Foundation

@Observable
class CoinsViewModel {
    var coin = ""
    var price = 0.00
    
    var coinService = CoinDataService()
    
    init() {
        fetchPrice(coin: "litecoin")
    }
    
    func fetchPrice(coin: String) {
        coinService.fetchPrice(coin: coin) { price in
            DispatchQueue.main.async {
                self.price = price
                self.coin = coin
            }
        }
    }
   
}


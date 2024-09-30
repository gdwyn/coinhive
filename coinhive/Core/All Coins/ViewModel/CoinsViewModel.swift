//
//  CoinsViewModel.swift
//  coinhive
//
//  Created by Godwin IE on 19/09/2024.
//

import Foundation

@Observable
class CoinsViewModel {
    var coins = [Coin]()
    
    var topGainers: [Coin] {
        return Array(self.coins.sorted(by: { $0.marketCap > $1.marketCap }).prefix(10))
    }
    
    var errorMsg : String?

    var coinService = CoinDataService()
    
    init() {
        Task {
           try await fetchCoins()
        }
    }
    
    func fetchCoins() async throws {
        self.coins = try await coinService.fetchCoins()
    }
    
//    func fetchCoinWithCompletionHandler() {
//        // use [weak self] to avoid retain cycles and memory leaks
//        coinService.fetchCoinsWithResult { [weak self] result in
//            DispatchQueue.main.async {
//                switch result {
//                case .success(let coins):
//                    self?.coins = coins
//                case .failure(let error):
//                    self?.errorMsg = error.localizedDescription
//                }
//            }
//        }
//    }
   
}


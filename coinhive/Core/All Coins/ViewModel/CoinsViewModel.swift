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
    var errorMsg : String?

    var coinService = CoinDataService()
    
    init() {
        fetchCoins()
    }
    
    func fetchCoins() {
        coinService.fetchCoins { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let coins):
                    self.coins = coins
                case .failure(let error):
                    self.errorMsg = error.localizedDescription
                }
            }
        }
        
//        coinService.fetchCoins { coins, error in
//            DispatchQueue.main.async {
//                if let error = error {
//                    self.errorMsg = error.localizedDescription
//                    return
//                }
//                
//                self.coins = coins ?? []
//            }
//        }
    }
   
}


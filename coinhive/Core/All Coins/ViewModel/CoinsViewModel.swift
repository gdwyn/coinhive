//
//  CoinsViewModel.swift
//  coinhive
//
//  Created by Godwin IE on 19/09/2024.
//

import Foundation

@Observable
class CoinsViewModel {
    var coinService = CoinDataService()
    var coins = [Coin]()
    var topGainers: [Coin] {
        return Array(self.coins.sorted(by: { $0.priceChangePercentage > $1.priceChangePercentage }).prefix(10))
    }
    var errorMsg : String?

    func fetchCoins() async throws {
        do {
            self.coins = try await coinService.fetchCoins()
            
        } catch let coinError as CoinAPIError { // catch custom errors
            self.errorMsg = coinError.customDescription
            
        } catch { // catch generic errors
            self.errorMsg = error.localizedDescription
        }
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


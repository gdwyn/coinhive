//
//  CoinsViewModel.swift
//  coinhive
//
//  Created by Godwin IE on 19/09/2024.
//

import Foundation

@Observable
class CoinsViewModel: ObservableObject {
    //using ObservableObject conformance because .environmentObject macro does not conform to @Observable macro
    var coinService = CoinDataService()
    var coins = [Coin]()
    var topGainers: [Coin] {
        return Array(self.coins.sorted(by: { $0.priceChangePercentage > $1.priceChangePercentage }).prefix(10))
    }
    var errorMsg : String?
    
    var pageLimit = 20
    var page = 0

    func fetchCoins() async throws {
        do {
            page += 1
            self.coins.append(contentsOf: try await coinService.fetchCoins(pageLimit: pageLimit, page: page))
            
        } catch let coinError as CoinAPIError { // catch custom errors
            self.errorMsg = coinError.customDescription
            
        } catch { // catch generic errors
            self.errorMsg = error.localizedDescription
        }
    }
    
    func LoadCoins() {
        Task(priority: .medium) {
            try await fetchCoins()
        }
    }
    
    func refreshCoins() async {
        coins.removeAll()
        page = 0
        try? await fetchCoins()
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


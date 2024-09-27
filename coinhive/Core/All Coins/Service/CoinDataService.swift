//
//  CoinDataService.swift
//  coinhive
//
//  Created by Godwin IE on 22/09/2024.
//

import Foundation

class CoinDataService {
    let urlString = "https://api.coingecko.com/api/v3/coins/markets?vs_currency=gbp&order=market_cap_desc&per_page=40&page=1&sparkline=false&price_change_percentage=24h&precision=2"
    
    func fetchCoins(completion: @escaping(Result<[Coin], Error>) -> Void) {
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }

            guard let data = data else { return }
            
            guard let coins = try? JSONDecoder().decode([Coin].self, from: data) else {
                print("DEBUG: failed to fetch coins")
                return
            }
            
            completion(.success(coins))
            
        }.resume()
    }
    
    
//    func fetchPrice(coin: String, completion: @escaping(Double) -> Void) {
//        let urlString = "https://api.coingecko.com/api/v3/simple/price?ids=\(coin)&vs_currencies=usd"
//        guard let url = URL(string: urlString) else { return }
//        
//        URLSession.shared.dataTask(with: url) { data, response, error in
//            
//            if let error = error {
//                print("DEBUG: \(error.localizedDescription)")
//            }
//            
//            guard let httpResponse = response as? HTTPURLResponse else {
//                print("Bad http request")
//                return
//            }
//            
//            guard httpResponse.statusCode == 200 else {
//                print("Not 200")
//                return
//            }
//            
//            guard let data = data else { return }
//            guard let jsonObject = try? JSONSerialization.jsonObject(with: data) as? [String: Any] else { return }
//            guard let value = jsonObject[coin] as? [String: Double] else {
//                print("failed to parse value")
//                return
//            }
//            guard let price = value["usd"] else { return }
//            
//            //                self.coin = coin.capitalized
//            //                self.price = "$\(price)"
//            completion(price)
//            
//        }.resume()
//        
//        print("did reach end of function")
//    }
}

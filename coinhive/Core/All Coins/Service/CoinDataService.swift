//
//  CoinDataService.swift
//  coinhive
//
//  Created by Godwin IE on 22/09/2024.
//

import Foundation

class CoinDataService {
    let BASE_URL = "https://api.coingecko.com/api/v3/coins/"
    
    func fetchCoins(pageLimit: Int, page: Int) async throws -> [Coin] {
        let urlString = "\(BASE_URL)markets?vs_currency=gbp&order=market_cap_desc&per_page=\(pageLimit)&page=\(page)&sparkline=true&price_change_percentage=24h&precision=2"
        
        guard let url = URL(string: urlString) else { throw CoinAPIError.invalidURL}
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard (response as? HTTPURLResponse)?.statusCode == 200 else { throw CoinAPIError.invalidStatusCode(code: (response as? HTTPURLResponse)?.statusCode ?? 404)} //server error
        
        guard let coins = try? JSONDecoder().decode([Coin].self, from: data) else { throw CoinAPIError.invalidData }
        
        return coins
        
    }
}




// MARK: Completion handler

extension CoinDataService {
    func fetchCoinsWithResult(completion: @escaping(Result<[Coin], CoinAPIError>) -> Void) {
        let urlString = "\(BASE_URL)markets?vs_currency=gbp&order=market_cap_desc&per_page=40&page=1&sparkline=true&price_change_percentage=24h&precision=2"
        
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(.unknownError(error: error)))
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse else {
                completion(.failure(.requestFailed(description: "Request failed")))
                return
            }
           
            guard httpResponse.statusCode == 200 else {
                completion(.failure(.invalidStatusCode(code: httpResponse.statusCode)))
                return
            }

            guard let data = data else {
                completion(.failure(.invalidData))
                return
            }
            
            do {
                let coins = try JSONDecoder().decode([Coin].self, from: data)
                completion(.success(coins))
            } catch {
                print("DEBUG: error, \(error.localizedDescription)")
                completion(.failure(.jsonParsingFailure))
            }

            
        }.resume()
    }
}

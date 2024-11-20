//
//  HoldingsViewModel.swift
//  Assignment
//
//  Created by Sapna Fulwani on 18/11/24.
//

import Foundation

class HoldingsViewModel {
    private(set) var holdings: [Holding] = []

    var currentValue: Double {
        var total = 0.0
        for holding in holdings {
            total += holding.ltp * Double(holding.quantity)
        }
        return total
    }

    var totalInvestment: Double {
        var total = 0.0
        for holding in holdings {
            total += holding.avgPrice * Double(holding.quantity)
        }
        return total
    }

    var totalPNL: Double {
        return currentValue - totalInvestment
    }
    
    var todaysPNL: Double {
        var total = 0.0
        for holding in holdings {
            total += (holding.close - holding.ltp) * Double(holding.quantity)
        }
        return total
    }


    
    func fetchHoldings(completion: @escaping (Bool) -> Void) {
        guard let url = URL(string: "https://35dee773a9ec441e9f38d5fc249406ce.api.mockbin.io/") else {
            print("Invalid URL")
            completion(false)
            return
        }

        URLSession.shared.dataTask(with: url) { data, _, error in
            if let error = error {
                print("Error fetching data: \(error.localizedDescription)")
                completion(false)
                return
            }

            guard let data = data else {
                print("No data received")
                completion(false)
                return
            }

            do {
                let response = try JSONDecoder().decode(HoldingsResponse.self, from: data)
                self.holdings = response.data.userHolding
                print("Fetched holdings: \(self.holdings)") 
                completion(true)
            } catch {
                print("Error decoding JSON: \(error.localizedDescription)")
                completion(false)
            }
        }.resume()
    }


}

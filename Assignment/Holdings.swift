//
//  Holdings.swift
//  Assignment
//
//  Created by Sapna Fulwani on 18/11/24.
//

import Foundation

struct HoldingsResponse: Decodable {
    let data: HoldingsData
}

struct HoldingsData: Decodable {
    let userHolding: [Holding]
}

struct Holding: Decodable {
    let symbol: String
    let quantity: Int
    let ltp: Double
    let avgPrice: Double
    let close: Double
}


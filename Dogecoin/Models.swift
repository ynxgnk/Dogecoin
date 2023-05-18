//
//  Models.swift
//  Dogecoin
//
//  Created by Nazar Kopeyka on 22.04.2023.
//

import Foundation

struct APIResponse: Codable { /* 63 */
    let data: [Int: DogeCoinData] /* 64 */
}

struct DogeCoinData: Codable { /* 42 */
    let id: Int /* 65 */
    let name: String /* 65 */
    let symbol: String /* 65 */
    let date_added: String /* 79 */
    let tags: [String] /* 80 */
    let total_supply: Float /* 81 */
    let quote: [String: Quote] /* 82 */
}

struct Quote: Codable { /* 83 */
    let price: Float /* 84 */
    let volume_24h: Float /* 84 */
}

import UIKit

struct Evolution: Codable {
    let id: Int?
    let order: Int
    let name: String
}

struct Pokemon: Codable {
    let id: Int
    let name: String
    let image: String
    let weight: Int
    let height: Int
    let types: [String]
    let abilities: [String]
    let evolution: [Evolution]?
}


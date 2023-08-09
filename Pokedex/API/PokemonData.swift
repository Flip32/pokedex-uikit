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


var pokemonList: [Pokemon] = []
var pokemonListInitial: [Pokemon] = []
var imageNotFound = "https://cdn.neemo.com.br/uploads/settings_webdelivery/logo/3136/image-not-found.jpg"

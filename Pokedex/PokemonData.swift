import UIKit

struct Pokemon {
    let id: Int
    let name: String
    let bio: String
    let image: UIImage
}

let pokemonList = [
    Pokemon(id: 4, name: "Charmander", bio: "It has a preference for hot things. When it rains, steam is said to spout from the tip of its tail.", image: UIImage(named: "Charmander Destaque")!),
    Pokemon(id: 5, name: "Charmeleon", bio: "It has a barbaric nature. In battle, it whips its fiery tail around and slashes away with sharp claws.", image: UIImage(named: "Charmeleon destaque")!),
    Pokemon(id: 6, name: "Charizard", bio: "It is said that Charizard’s fire burns hotter if it has experienced harsh battles. ", image: UIImage(named: "Charizard destaque")!)
]

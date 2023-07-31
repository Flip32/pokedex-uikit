import UIKit

struct Pokemon {
    let id: Int
    let name: String
    let bioDescription: String
    let image: UIImage
}

let pokemonList = [
    Pokemon(id: 4, name: "Charmander", bioDescription: "It has a preference for hot things. When it rains, steam is said to spout from the tip of its tail.", image: UIImage(named: "Charmander Destaque")!),
    Pokemon(id: 5, name: "Charmeleon", bioDescription: "It has a barbaric nature. In battle, it whips its fiery tail around and slashes away with sharp claws.", image: UIImage(named: "Charmeleon destaque")!),
    Pokemon(id: 6, name: "Charizard", bioDescription: "It is said that Charizard’s fire burns hotter if it has experienced harsh battles. ", image: UIImage(named: "Charizard destaque")!),
    Pokemon(id: 5, name: "Charmeleon", bioDescription: "It has a barbaric nature. In battle, it whips its fiery tail around and slashes away with sharp claws.", image: UIImage(named: "Charmeleon destaque")!),
]
import UIKit

class PokemonController: UIViewController {
    
    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var bio: UILabel!
    
    var pokemonId: Int?
    var pokemon: Pokemon?

    @IBOutlet weak var imgPokemon: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        print("Chegou na Pokemon controller \(pokemonId!)")
        
        if let id = pokemonId {
                    pokemon = pokemonList.first { $0.id == id }
                    
                    if let pokemon = pokemon {
                        print("Nome do Pokémon: \(pokemon.name)")
                        print("Bio do Pokémon: \(pokemon.bio)")
                        img.image = pokemon.image
                        bio.text = pokemon.bio
                    }
                }
    }
    
    
}

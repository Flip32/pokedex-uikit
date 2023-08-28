import Foundation

final class PokemonViewModel: PokemonViewModelProtocol {

    var pokemonDidChange: ((PokemonViewModelProtocol) -> ())?

    var pokemon: Pokemon {
        didSet {
            // Updates
            self.pokemonDidChange?(self)
        }
    }


    init()
}
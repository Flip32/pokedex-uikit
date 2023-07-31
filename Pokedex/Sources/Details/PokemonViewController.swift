import UIKit

class PokemonController: UIViewController {
    private var customView: PokemonView? = nil
    
    var pokemonId: Int?
    var pokemon: Pokemon?

    override func viewDidLoad() {
        super.viewDidLoad()
        buildView()
    }
    
    private func buildView() {
        if let id = pokemonId {
            let pokemonView = PokemonView(pokemonId: id)
            view = pokemonView
            customView = pokemonView
        }
    }
    
}

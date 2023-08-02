import UIKit

class HomeViewController: UIViewController {
    private var customView: HomeView? = nil
    private var newPokemonList: [Pokemon] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        do {
            let service = PokemonService()
            service.getPokemonInfo(id: 1) { result in
                DispatchQueue.main.async {
                    switch result {
                    case let .failure(error):
                        print(error)
                    case let .success(data):
                        print("caiu aqui no success")
//                        print(data.id)front_default
                            
                            let newPokemon = Pokemon(id: data.id, name: data.name, bioDescription: "teste descricao", image: data.sprites.other?.home?.frontDefault ?? "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/4.png")
                        self.newPokemonList.append(newPokemon)
                        pokemonList = self.newPokemonList
                        print("Chegou no fim")
                        self.buildView()
                    }
                }
            }
        }
    }
    private func buildView() {
        view = HomeView()
        customView = view as? HomeView
    }


    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToPokemonController" {
            if let destinationVC = segue.destination as? PokemonController,
               let pokemonId = sender as? Int {
                destinationVC.pokemonId = pokemonId
            }
        }
    }

}

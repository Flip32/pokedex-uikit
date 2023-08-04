import UIKit

protocol HomeViewDelegate: AnyObject {
    func menuButtonTapped()
}

class HomeViewController: UIViewController, HomeViewDelegate {
    private var customView: HomeView? = nil
    private var loadingIndicator: UIActivityIndicatorView?

    override func viewDidLoad() {
        super.viewDidLoad()
        fetchPokemonDataInRange()

/*        do {
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
        }*/
    }

    private func buildView() {
        view = HomeView()
        customView = view as? HomeView
        customView?.delegate = self
    }

    private func showLoadingIndicator() {
        loadingIndicator = UIActivityIndicatorView(style: .large)
        loadingIndicator?.center = view.center
        loadingIndicator?.color = .gray
        loadingIndicator?.startAnimating()
        view.addSubview(loadingIndicator!)
    }

    private func hideLoadingIndicator() {
        loadingIndicator?.stopAnimating()
        loadingIndicator?.removeFromSuperview()
        loadingIndicator = nil
    }

    // MARK: - Actions
    private func fetchPokemonDataInRange() {
        print("vai chamar a api")
        showLoadingIndicator()
        let service = PokemonService()
        let dispatchGroup = DispatchGroup()
        var newPokemonList: [Pokemon] = []

        for id in 1...150 {
            dispatchGroup.enter()
            service.getPokemonInfo(id: id) { result in
                DispatchQueue.main.async {
                    switch result {
                    case let .failure(error):
                        print(error)
                    case let .success(data):
                        let newPokemon = Pokemon(id: data.id, name: data.name, bioDescription: "teste descricao", image: data.sprites.other?.home?.frontDefault ?? imageNotFound, weight: data.weight, height: data.height, types: data.types, sprites: data.sprites, abilities: data.abilities)
                        newPokemonList.append(newPokemon)
                        print("Successfully fetched data for Pokemon with ID: \(data.id)")
                    }
                    // pokemon list recebe newPokemonList ordenado por id
                    pokemonList = newPokemonList.sorted(by: { $0.id < $1.id })
                    dispatchGroup.leave()
                }
            }
        }

        dispatchGroup.notify(queue: .main) {
            print("chegou no fim")
            self.buildView()
            self.hideLoadingIndicator()
        }
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

    func menuButtonTapped() {
        print("menu button tapped na controller")
    }

}

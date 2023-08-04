import UIKit

protocol HomeViewDelegate: AnyObject {
    func menuButtonTapped()
}

class HomeViewController: UIViewController {
    private var customView: UIView? = nil
    private var tableView: PokemonTableView? = nil
//    private var scrollview: HomeView? = nil
    private var loadingIndicator: UIActivityIndicatorView?

    override func viewDidLoad() {
        super.viewDidLoad()
        fetchPokemonDataInRange()
    }

    private func buildView() {
        customView = UIView(frame: view.bounds)
        guard let customView = customView else { return }

        tableView = PokemonTableView(frame: customView.bounds, style: .plain)
        guard let tableView = tableView else { return }
        print("passou do table view guard let")

        tableView.delegate = tableView
        tableView.dataSource = tableView

        tableView.register(PokemonTableViewCell.self, forCellReuseIdentifier: PokemonTableViewCell.reuseIdentifier)

        customView.addSubview(tableView)
        view.addSubview(customView)

        view.backgroundColor = UIColor.systemPink

        /*NSLayoutConstraint.activate([
            customView.topAnchor.constraint(equalTo: view.topAnchor),
            customView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            customView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            customView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])*/

        tableView.reloadData()
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

        for id in 1...2 {
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
                    pokemonList = newPokemonList.sorted(by: { $0.id > $1.id })
                    dispatchGroup.leave()
                }
            }
        }

        dispatchGroup.notify(queue: .main) {
            print("chegou no fim")
            print("pokemon list", pokemonList[0])
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

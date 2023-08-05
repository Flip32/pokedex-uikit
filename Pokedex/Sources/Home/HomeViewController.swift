import UIKit

protocol HomeViewDelegate: AnyObject {
    func menuButtonTapped()
}

class HomeViewController: UIViewController {
    private let customView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private let tableView: PokemonTableView = {
        let tableView = PokemonTableView(frame: .zero, style: .plain)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.estimatedRowHeight = 100
        tableView.rowHeight = UITableView.automaticDimension
        return tableView
    }()
//    private var scrollview: HomeView? = nil
    private var loadingIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.color = .gray
        return activityIndicator
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        fetchPokemonDataInRange()
    }

    private func configureView() {
        configureCustomView()
        configureTableView()

        loadingIndicator.center = view.center
    }

    private func configureCustomView() {
        view.addSubview(customView)

        NSLayoutConstraint.activate([
            customView.topAnchor.constraint(equalTo: view.topAnchor),
            customView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            customView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            customView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }

    private func configureTableView() {
        customView.addSubview(tableView)

        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: customView.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: customView.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: customView.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: customView.bottomAnchor)
        ])
    }

    private func showLoadingIndicator() {
        view.addSubview(loadingIndicator)
        loadingIndicator.startAnimating()
    }

    private func hideLoadingIndicator() {
        loadingIndicator.stopAnimating()
        loadingIndicator.removeFromSuperview()
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
                    pokemonList = newPokemonList.sorted(by: { $0.id > $1.id })
                    dispatchGroup.leave()
                }
            }
        }

        dispatchGroup.notify(queue: .main) { [weak self] in
            print("chegou no fim")
            print("pokemon list", pokemonList[0])
            self?.hideLoadingIndicator()
            self?.tableView.reloadData()
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

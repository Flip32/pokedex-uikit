import UIKit


class HomeViewController: UIViewController {
    var cardViews: [CardPokemonView] = []
    var screenShown: String = "ScrollView"
    var sortedList: String = "up"

    private let logo: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.image = UIImage(named: "Logo")
        return image
    }()

    private let menuButton: UIButton = {
        let button = UIButton(type: .custom)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .clear
        button.isEnabled = true
        return button
    }()

    private let sortButton: UIButton = {
        let button = UIButton(type: .custom)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .clear
        button.isEnabled = true
        return button
    }()

    private let customView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .black
        return view
    }()

    private let tableView: PokemonTableView = {
        let tableView = PokemonTableView(frame: .zero, style: .plain)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.estimatedRowHeight = 100
        tableView.rowHeight = UITableView.automaticDimension
        tableView.backgroundColor = .black
        return tableView
    }()

    private let scrollView: UIScrollView = {
        let scroll = UIScrollView()
        scroll.translatesAutoresizingMaskIntoConstraints = false
        return scroll
    }()

    private let contentView: UIStackView = {
        let stackView = UIStackView()
        stackView.backgroundColor = .clear
        stackView.spacing = 10
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fillProportionally
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    private var loadingIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.color = .gray
        return activityIndicator
    }()

    private var imgSort: UIImage = {
        let sortImage = UIImage(named: "icon_sort")
//        sortImage?.withTintColor(.blue)
        return sortImage!
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        fetchPokemonDataInRange()

    }

    private func configureView() {
        configureCustomView()
        configureScrollView()
        configureTableView()
        loadingIndicator.center = view.center
    }

    private func configureCustomView() {
        let menuImage = UIImage(named: "lista_menu")
        menuImage?.withTintColor(.darkGray)
        menuButton.setImage(menuImage, for: .normal)
        menuButton.addTarget(self, action: #selector(menuButtonTapped), for: .touchUpInside)

        // sortButton
        sortButton.setImage(imgSort, for: .normal)
        sortButton.addTarget(self, action: #selector(sortPokemons), for: .touchUpInside)

        customView.addSubview(logo)
        customView.addSubview(menuButton)
        customView.addSubview(sortButton)
        view.addSubview(customView)

        NSLayoutConstraint.activate([
            customView.topAnchor.constraint(equalTo: view.topAnchor),
            customView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            customView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            customView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])

        NSLayoutConstraint.activate([
            logo.centerXAnchor.constraint(equalTo: customView.centerXAnchor),
            logo.topAnchor.constraint(equalTo: customView.topAnchor, constant: 30)
        ])

        NSLayoutConstraint.activate([
            sortButton.topAnchor.constraint(equalTo: logo.bottomAnchor, constant: 0),
            sortButton.widthAnchor.constraint(equalToConstant: 35),
            sortButton.heightAnchor.constraint(equalToConstant: 35),
            sortButton.trailingAnchor.constraint(equalTo: menuButton.leadingAnchor, constant: -5)
        ])

        NSLayoutConstraint.activate([
            menuButton.topAnchor.constraint(equalTo: logo.bottomAnchor, constant: 0),
            menuButton.widthAnchor.constraint(equalToConstant: 40),
            menuButton.heightAnchor.constraint(equalToConstant: 40),
            menuButton.trailingAnchor.constraint(equalTo: customView.trailingAnchor, constant: -20)
        ])
    }

    private func configureScrollView() {

        /*if let scrollView = scrollView as? UIScrollView {
            scrollView.removeFromSuperview()
        }*/

        customView.addSubview(scrollView)
        scrollView.addSubview(contentView)

        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: menuButton.bottomAnchor, constant: 20),
            scrollView.leadingAnchor.constraint(equalTo: customView.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: customView.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: customView.bottomAnchor, constant: -20)
        ])

        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
        ])

        print("chegou no for: ", pokemonList.count)
        for pokemon in pokemonList {
            createCardView(for: pokemon)
        }

        if let lastCardView = cardViews.last {
            contentView.bottomAnchor.constraint(equalTo: lastCardView.bottomAnchor, constant: 16).isActive = true
        }
    }

    private func configureTableView() {
        customView.addSubview(tableView)

        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: menuButton.bottomAnchor, constant: 20),
            tableView.leadingAnchor.constraint(equalTo: customView.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: customView.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: customView.bottomAnchor, constant: -20)
        ])

        tableView.isHidden = true
        sortButton.isHidden = true
    }

    private func showLoadingIndicator() {
        view.addSubview(loadingIndicator)
        loadingIndicator.startAnimating()
    }

    private func hideLoadingIndicator() {
        loadingIndicator.stopAnimating()
        loadingIndicator.removeFromSuperview()
    }

    func createCardView(for pokemon: Pokemon) {
        let cardView = CardPokemonView() // Crie uma nova instância da CardPokemonView
        cardView.translatesAutoresizingMaskIntoConstraints = false

        contentView.addSubview(cardView)


        NSLayoutConstraint.activate([
            cardView.topAnchor.constraint(equalTo: cardViews.last?.bottomAnchor ?? contentView.topAnchor, constant: 16),
            cardView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            //                    cardView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            cardView.heightAnchor.constraint(equalToConstant: 250),
        ])

        cardViews.append(cardView)
        cardView.pokemon = pokemon
    }

    // MARK: - Actions
    private func fetchPokemonDataInRange() {
        print("vai chamar a api")
        showLoadingIndicator()
        let service = PokemonService()
        let dispatchGroup = DispatchGroup()
        var newPokemonList: [Pokemon] = []

        for id in 1...500 {
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

        dispatchGroup.notify(queue: .main) { [weak self] in
            print("chegou no fim")
            print("pokemon list", pokemonList[0])
            self?.hideLoadingIndicator()
            self?.tableView.reloadData()
            self?.configureView()
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

    @objc func menuButtonTapped() {
        scrollView.isHidden = !scrollView.isHidden
        tableView.isHidden = !tableView.isHidden
        sortButton.isHidden = tableView.isHidden
    }

    @objc func sortPokemons() {
        // comprar o sortedList, se for up, ordena do menor para o maior, se for down, ordena do maior para o menor
        print(sortedList)
        if sortedList == "up" {
            pokemonList = pokemonList.sorted(by: { $0.id > $1.id })
            sortedList = "down"
        } else {
            pokemonList = pokemonList.sorted(by: { $0.id < $1.id })
            sortedList = "up"
        }

        tableView.reloadData()
    }
}

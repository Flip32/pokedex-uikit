import UIKit


class HomeViewController: UIViewController {
    var sortedList: String = "up"

    private let logo: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.image = UIImage(named: "Logo")
        return image
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
        configureView()
        fetchPokemonDataInRange()
    }

    private func configureView() {
        configureCustomView()
        configureTableView()
        loadingIndicator.center = view.center
    }

    private func configureCustomView() {

        // sortButton
        sortButton.setImage(imgSort, for: .normal)
        sortButton.addTarget(self, action: #selector(sortPokemons), for: .touchUpInside)

        customView.addSubview(logo)
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
            sortButton.trailingAnchor.constraint(equalTo: customView.trailingAnchor, constant: -5)
        ])
    }

    private func configureTableView() {
        customView.addSubview(tableView)

        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: sortButton.bottomAnchor, constant: 20),
            tableView.leadingAnchor.constraint(equalTo: customView.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: customView.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: customView.bottomAnchor, constant: -20)
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

        dispatchGroup.enter()
//        let genIDs = [1, 2, 3, 4, 5]
        service.getPokemonsCached(genIDs: [1]) { result in
            DispatchQueue.main.async {
                switch result {
                case let .failure(error):
                        print("caiu no error")
                    print(error)
                case let .success(data):
                    pokemonList = data.sorted(by: { $0.id < $1.id })
                }
                dispatchGroup.leave()
            }
        }

        dispatchGroup.notify(queue: .main) { [weak self] in
            self?.tableView.reloadData()
            self?.hideLoadingIndicator()
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

    @objc func sortPokemons() {
        // comprar o sortedList, se for up, ordena do menor para o maior, se for down, ordena do maior para o menor
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
